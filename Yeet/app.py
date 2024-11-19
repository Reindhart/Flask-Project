from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
from flask_mysqldb import MySQL, MySQLdb
from flask_bcrypt import bcrypt
from flask_wtf.csrf import generate_csrf
import secrets
from clientes import *

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'test'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
app.secret_key = secrets.token_hex(32)
mysql = MySQL(app)

def is_authenticated():
    return session.get('role') is not None

def get_role():
    role = session.get('role', 0)
    return role

@app.route('/')
def index():
    return render_template('inicio.html', role=get_role())

@app.route('/sing-up_admin', methods=['GET', 'POST'])
@app.route('/sing-up', methods=['GET', 'POST'])
def auth():

    is_admin = request.path == '/sing-up_admin'

    if is_authenticated():
        return redirect(url_for('profile', username=session['nombre']))

    if request.method == 'POST':
        if request.is_json:
            data = request.get_json()
            current_path = data.get('currentPath')
            return jsonify({
                "pageType": 'signup' if current_path in ['/sing-up', '/sing-up_admin'] else None,
                "csrfToken": generate_csrf(),
            })
    
        action_type = request.form.get("action_type")
        if action_type == "signup":
            print(is_admin)
            if(registro(request.form, is_admin)):
                session['role'] = 2 if is_admin else 1
                session['nombre'] = request.form['nombre']
                return redirect(url_for('index'))
            else:
                print("error")
        elif action_type == "signin":
            if(login(request.form, is_admin)):
                session['role'] = 2 if is_admin else 1
                return redirect(url_for('index'))
            else:
                flash('Correo o contraseña incorrectos')
                redirect(request.url)    
    return render_template('singup.html', role=get_role(), admin=is_admin)

def registro(formulario, is_admin):
    try:
        nombre_c = formulario['nombre']
        correo_c = formulario['correo']
        telefono_c = formulario['telefono']
        direccion_c = formulario['direccion']
        clave_c = formulario['contrasena'].encode('utf-8')
        contrasena_confirm = formulario["contrasena_confirm"].encode('utf-8')
        
        if clave_c != contrasena_confirm:
            flash("Las contraseñas no coinciden.")
            return False
        
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT id_c FROM clientes WHERE correo_c = %s", (correo_c,))
        correo_existente = cursor.fetchone()
        
        if correo_existente:
            flash("Este correo ya está registrado.")
            return False
        
        Ccifrada = bcrypt.hashpw(clave_c, bcrypt.gensalt())
        
        if is_admin:
            regUsuario = mysql.connection.cursor()
            regUsuario.execute("INSERT INTO admin (nombre_u, correo_u, clave_u) VALUES (%s,%s,%s)",
                            (nombre_c, correo_c, Ccifrada))
        else:
            regCliente = mysql.connection.cursor()
            regCliente.execute("INSERT INTO clientes (nombre_c, correo_c, telefono_c, direccion_c, clave_c) VALUES (%s,%s,%s,%s,%s)",
                            (nombre_c, correo_c, telefono_c, direccion_c, Ccifrada))
        mysql.connection.commit()
        return True
    except Exception as err:
        print(err)
        return

def login(formulario, is_admin):
    correo_c = formulario['correo']
    clave_c = formulario['contrasena'].encode('utf-8')
    if is_admin:
        selAdmin = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        selAdmin.execute("SELECT * FROM admin WHERE correo_u=%s", (correo_c,))
        u = selAdmin.fetchone()
        selAdmin.close()
        if u is not None:
            if bcrypt.hashpw(clave_c, u['clave_u'].encode('utf-8')) == u['clave_u'].encode('utf-8'):
                session['nombre'] = u['nombre_u']
                session['correo'] = u['correo_u']
                return redirect(url_for('index'))
    else:        
        selCliente = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        selCliente.execute("SELECT * FROM clientes WHERE correo_c=%s", (correo_c,))
        c = selCliente.fetchone()
        selCliente.close()
        if c is not None:
            if bcrypt.hashpw(clave_c, c['clave_c'].encode('utf-8')) == c['clave_c'].encode('utf-8'):
                session['nombre'] = c['nombre_c']
                session['correo'] = c['correo_c']
                return redirect(url_for('index'))
        
@app.route('/restore', methods=['GET', 'POST'])        
def restore_password():
    return redirect(url_for('index'))

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))
   
@app.route('/<username>')
def profile(username):
    
    is_admin = get_role()
    if not is_authenticated():
        return render_template('404.html'), 404

    cursor = mysql.connection.cursor()
    cursor.execute(f"SELECT * FROM {"admin" if is_admin == 2 else "clientes"} WHERE {"nombre_u" if is_admin == 2 else "nombre_c"} = %s", (username,))
    user = cursor.fetchone()

    if not user:
        return render_template('404.html'), 404
    
    if session.get('nombre') != username:
        return redirect(url_for('index'))

    return render_template('perfil.html', user=user)

@app.route('/Clientes')
def Clientes_ABCD():
    if get_role() == 2:
        selCliente = mysql.connection.cursor()
        selCliente.execute("SELECT * FROM clientes")
        i = selCliente.fetchall()
        return render_template('sCliente.html', role=get_role(), clientes=i)
    else:
        return redirect(url_for('index'))

@app.route('/carta')
def carta():
    return render_template('carta.html')

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_server_error(e):
    return render_template('500.html'), 500

if __name__ == "__main__":
    app.run(port=3850, debug=True)
