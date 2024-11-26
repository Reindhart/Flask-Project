from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify, make_response
from flask_mysqldb import MySQL, MySQLdb
from flask_bcrypt import bcrypt
from flask_wtf.csrf import generate_csrf
import secrets, uuid

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'test'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
app.secret_key = secrets.token_hex(32)
mysql = MySQL(app)

def generate_session_id():
    """Genera o recupera una ID de carrito única."""
    session_id = request.cookies.get('session_id')  # Intenta obtener la cookie del cliente
    if not session_id:
        session_id = str(uuid.uuid4())  # Genera una nueva ID única
    return session_id

@app.before_request
def assign_session_id():
    if not session.get('session_id'):
        session['session_id'] = generate_session_id()

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
            if(registro(request.form, is_admin)):
                session['role'] = 2 if is_admin else 1
                session['nombre'] = request.form['nombre']
                return redirect(url_for('index'))
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
   
@app.route('/Buscar')
def productos():
    selProducto = mysql.connection.cursor()
    selProducto.execute("SELECT * FROM producto")
    i = selProducto.fetchall()
    carrito = session.get('carrito', [])
    return render_template('productos.html', productos=i, role=get_role(), carrito=carrito)

@app.route('/productos')
def infoprod():
    return render_template('infoprod.html')

@app.route('/getCarrito')
def get_cart():
    cart = session.get('carrito', [])

    # Crea una respuesta y añade la cookie si no existe.
    response = make_response(jsonify({'session_id': session['session_id'], 'cart': cart}))
    response.set_cookie('session_id', session['session_id'], max_age=30 * 24 * 60 * 60)  # 30 días de persistencia
    return response

@app.route('/sync-cart', methods=['POST'])
def sync_cart():
    if not is_authenticated():
        return jsonify({'error': 'User not authenticated'}), 401

    user_id = session['session_id']
    client_cart = request.get_json().get('carrito', [])
    
    # Busca o crea el carrito en la base de datos
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT id_ca FROM carritos WHERE id_sesion = %s", (user_id,))
    carrito = cursor.fetchone()

    if not carrito:
        cursor.execute("INSERT INTO carritos (usuario_id) VALUES (%s)", (user_id,))
        mysql.connection.commit()
        carrito_id = cursor.lastrowid
    else:
        carrito_id = carrito['id']

    # Limpia el carrito existente en la base de datos
    cursor.execute("DELETE FROM detalle_carrito WHERE carrito_id = %s", (carrito_id,))
    mysql.connection.commit()

    # Inserta los productos desde el carrito del cliente
    for item in client_cart:
        cursor.execute(
            "INSERT INTO detalle_carrito (carrito_id, producto_id, cantidad, precio) VALUES (%s, %s, %s, %s)",
            (carrito_id, item['id'], item['cantidad'], item['precio'])
        )
    mysql.connection.commit()
    return jsonify({'message': 'Cart synced successfully'})

@app.route('/addCarrito')
def addCarrito():
    return render_template('/Comprar', methods=['POST'])

@app.route('/Comprar', methods=['POST'])
def comprar():
    return render_template('compra.html')
   
@app.route('/<username>')
def profile(username):
    if not is_authenticated():
        return render_template('404.html'), 404

    is_admin = get_role()
    table = "admin" if is_admin == 2 else "clientes"
    column = "nombre_u" if is_admin == 2 else "nombre_c"
    
    try:
        cursor = mysql.connection.cursor()
        # Usa marcadores de posición seguros
        query = f"SELECT * FROM {table} WHERE {column} = %s"
        cursor.execute(query, (username,))
        user = cursor.fetchone()

        if not user:
            return render_template('404.html'), 404

        if session.get('nombre') != username:
            return redirect(url_for('index'))
        
        context = {
            "nombre": user.get('nombre_c') or user.get('nombre_u'),
            "apellido": "Pinedo",
            "correo": user.get('correo_c') or user.get('correo_u'),
            "telefono": user.get('telefono_c', ''),  # Opcional
            "direccion": user.get('direccion_c', ''),  # Opcional
            "role": get_role()
        }
        
    except Exception as e:
        
        return render_template('500.html'), 500

    return render_template('perfil.html', **context)

@app.route('/update-profile', methods=['POST'])
def actualizarPerfil():
    username = session.get('nombre')
    return redirect(url_for('profile', username=username))

@app.route('/<username>-carrito')
def carrito(username):
    if not is_authenticated():
        return render_template('404.html'), 404
    
    is_admin = get_role()
    table = "admin" if is_admin == 2 else "clientes"
    column = "nombre_u" if is_admin == 2 else "nombre_c"

    try:
        cursor = mysql.connection.cursor()
        query = f"SELECT * FROM {table} WHERE {column} = %s"
        cursor.execute(query, (username,))
        user = cursor.fetchone()

        if not user:
            return render_template('404.html'), 404

        if session.get('nombre') != username:
            return redirect(url_for('index'))

        return render_template('carrito.html', user=user, role=get_role())

    except Exception as e:

        return render_template('500.html'), 500

@app.route('/Clientes')
def Clientes_ABCD():
    if get_role() == 2:
        selCliente = mysql.connection.cursor()
        selCliente.execute("SELECT * FROM clientes")
        i = selCliente.fetchall() 
        return render_template('sCliente.html', role=get_role(), clientes=i)
    else:
        return redirect(url_for('index'))

@app.route('/iClientes', methods=['POST'])
def iClientes():
    if request.method == 'POST':
        nombre_c = request.form['nombre_c']
        correo_c = request.form['correo_c']
        telefono_c = request.form['telefono_c']
        direccion_c = request.form['direccion_c']
        clave_c = request.form['clave_c'].encode('utf-8')
        Ccifrada = bcrypt.hashpw(clave_c, bcrypt.gensalt())
        regCliente = mysql.connection.cursor()
        regCliente.execute("INSERT INTO clientes (nombre_c, correo_c, telefono_c, direccion_c, clave_c) VALUES (%s,%s,%s,%s,%s)",
                           (nombre_c, correo_c, telefono_c, direccion_c, Ccifrada))
        mysql.connection.commit()
        flash(f'Se ha agregado el usuario {nombre_c} exitosamente')
    return redirect(url_for('Clientes_ABCD'))

@app.route('/dCliente', methods=['GET', 'POST'])
def dCliente():
    id_c = request.form['id_c']
    delCliente = mysql.connection.cursor()
    delCliente.execute("DELETE FROM clientes WHERE id_c=%s", (id_c,))
    mysql.connection.commit()
    flash('Se ha elminado satisfactoriamente')
    return redirect(url_for('Clientes_ABCD'))

@app.route('/uCliente', methods=['GET', 'POST'])
def uCliente():
    id_c = request.form['id_c']
    nombre_c = request.form['nombre_c']
    correo_c = request.form['correo_c']
    telefono_c = request.form['telefono_c']
    direccion_c = request.form['direccion_c']
    actCliente = mysql.connection.cursor()
    actCliente.execute("UPDATE clientes SET nombre_c=%s, correo_c=%s, telefono_c=%s, direccion_c=%s WHERE id_c=%s",
                       (nombre_c, correo_c, telefono_c, direccion_c, id_c))
    mysql.connection.commit()
    flash('Actualizado satisfactoriamente')
    return redirect(url_for('Clientes_ABCD'))

@app.route('/Productos')
def Productos_ABCD():
    if get_role() == 2:
        selProducto = mysql.connection.cursor()
        selProducto.execute("SELECT * FROM producto")
        i = selProducto.fetchall()
        return render_template('sProducto.html', role=get_role(), producto=i)
    else:
        return redirect(url_for('index'))
    
@app.route('/iProducto', methods=['POST'])
def iProducto():
    if request.method == 'POST':
        nombre_p = request.form['nombre_p']
        precio = request.form['precio']
        descripcion = request.form['descripcion']
        existencia = request.form['existencia']
        imagen = request.form['imagen']
        regProducto = mysql.connection.cursor()
        regProducto.execute("INSERT INTO producto (nombre_p, precio, descripcion, existencia, imagen) VALUES (%s,%s,%s,%s,%s)",
                            (nombre_p, precio, descripcion, existencia, imagen))
        mysql.connection.commit()
    return redirect(url_for('Productos_ABCD'))
    
@app.route('/uProducto', methods=['GET', 'POST'])
def uProducto():
    id_p = request.form['id_p']
    nombre_p = request.form['nombre_p']
    precio = request.form['precio']
    descripcion = request.form['descripcion']
    existencia = request.form['existencia']
    imagen = request.form['imagen']
    actProducto = mysql.connection.cursor()
    actProducto.execute("UPDATE producto SET nombre_p=%s, precio=%s, descripcion=%s, existencia=%s, imagen=%s WHERE id_p=%s",
                        (nombre_p, precio, descripcion, existencia, imagen, id_p))
    mysql.connection.commit()
    flash('Actualizado satisfactoriamente')
    return redirect(url_for('Productos_ABCD'))

@app.route('/dProducto', methods=['GET', 'POST'])
def dProducto():
    id_p = request.form['id_p']
    delProducto = mysql.connection.cursor()
    delProducto.execute("DELETE FROM producto WHERE id_p=%s", (id_p,))
    mysql.connection.commit()
    flash('Se ha elminado satisfactoriamente')
    return redirect(url_for('Productos_ABCD'))

@app.route('/CompraVenta')
def CompraVenta_ABCD():
    if get_role() == 2:
        return render_template('sCompraVenta.html', role=get_role())
    else:
        return redirect(url_for('index'))
    
@app.route('/ejemplos', methods=['POST'])
def ejemplos():
    pass

@app.route('/carta')
def carta():
    return render_template('carta.html')

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_server_error(e):
    return render_template('500.html'), 500

def execute_sql(query):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    try:
        cursor.execute(query)
        result = cursor.fetchall()
    except Exception as e:
        result = f"Error al ejecutar la consulta: {e}"
    finally:
        cursor.close()
        
    return result

@app.route('/execute_query', methods=['POST'])
def execute_query():
    query = request.form['query']
    result = None
    
    # Aquí asignamos la consulta correcta según el botón presionado
    if query == 'equal_to':
        result = execute_sql("SELECT nombre_c, correo_c FROM clientes WHERE nombre_c = 'Juan Pérez';")
    elif query == 'not_equal_to':
        result = execute_sql("SELECT nombre_p, precio FROM producto WHERE precio <> 22.75;")
    elif query == 'greater_than':
        result = execute_sql("SELECT nombre_p, precio FROM producto WHERE precio > 10.00;")
    elif query == 'greater_or_equal':
        result = execute_sql("SELECT nombre_p, existencia FROM producto WHERE existencia >= 100;")
    elif query == 'less_than':
        result = execute_sql("SELECT nombre_c, telefono_c FROM clientes WHERE id_c < 10;")
    elif query == 'less_or_equal':
        result = execute_sql("SELECT nombre_p, descripcion FROM producto WHERE existencia <= 50;")
    elif query == 'between':
        result = execute_sql("SELECT nombre_c, telefono_c FROM clientes WHERE id_c BETWEEN 5 AND 20;")
    elif query == 'in_set':
        result = execute_sql("SELECT nombre_p FROM producto WHERE nombre_p IN ('Comida para canarios', 'Juguete para loros');")
    elif query == 'not_in_set':
        result = execute_sql("SELECT nombre_c FROM clientes WHERE nombre_c NOT IN ('Juan Pérez', 'Ana García');")
    elif query == 'is_null':
        result = execute_sql("SELECT nombre_c FROM clientes WHERE telefono_c IS NULL;")
    elif query == 'is_not_null':
        result = execute_sql("SELECT nombre_p FROM producto WHERE descripcion IS NOT NULL;")
    elif query == 'like':
        result = execute_sql("SELECT nombre_c, correo_c FROM clientes WHERE correo_c LIKE '%gmail.com';")
    elif query == 'not_like':
        result = execute_sql("SELECT nombre_c FROM clientes WHERE correo_c NOT LIKE '%yahoo.com';")
    elif query == 'count':
        result = execute_sql("SELECT COUNT(*) FROM producto WHERE existencia > 50;")
    elif query == 'avg':
        result = execute_sql("SELECT AVG(precio) FROM producto WHERE existencia > 50;")
    elif query == 'sum':
        result = execute_sql("SELECT SUM(existencia) FROM producto WHERE precio < 20;")
    elif query == 'max':
        result = execute_sql("SELECT MAX(precio) FROM producto;")
    elif query == 'min':
        result = execute_sql("SELECT MIN(precio) FROM producto;")
    elif query == 'count_field':
        result = execute_sql("SELECT COUNT(nombre_p) FROM producto WHERE existencia > 100;")
    elif query == 'avg_group':
        result = execute_sql("SELECT AVG(precio) FROM producto GROUP BY nombre_p;")
    elif query == 'count_client':
        result = execute_sql("SELECT nombre_c, COUNT(*) FROM clientes GROUP BY nombre_c;")
    elif query == 'min_price':
        result = execute_sql("SELECT MIN(precio) FROM producto WHERE existencia < 50;")
    elif query == 'avg_exist':
        result = execute_sql("SELECT AVG(existencia) FROM producto;")
    # Asignamos consultas para Group By, Having, Order By
    elif query == 'group_by_category':
        result = execute_sql("SELECT categoria, COUNT(*) AS total FROM producto GROUP BY categoria;")
    elif query == 'group_by_price_range':
        result = execute_sql("SELECT FLOOR(precio / 10) * 10 AS rango_precio, COUNT(*) AS total FROM producto GROUP BY rango_precio;")
    elif query == 'group_by_supplier':
        result = execute_sql("SELECT id_proveedor, COUNT(*) AS productos_totales FROM producto GROUP BY id_proveedor;")
    elif query == 'group_by_stock_status':
        result = execute_sql("SELECT CASE WHEN existencia > 50 THEN 'En Stock' ELSE 'Bajo Stock' END AS estado_stock, COUNT(*) AS total FROM producto GROUP BY estado_stock;")
    elif query == 'having_high_sales':
        result = execute_sql("SELECT categoria, SUM(precio * existencia) AS ventas FROM producto GROUP BY categoria HAVING ventas > 5000;")
    elif query == 'having_low_stock':
        result = execute_sql("SELECT nombre_p, existencia FROM producto HAVING existencia < 70;")
    elif query == 'order_by_price_asc':
        result = execute_sql("SELECT nombre_p, precio FROM producto ORDER BY precio ASC;")
    elif query == 'order_by_price_desc':
        result = execute_sql("SELECT nombre_p, precio FROM producto ORDER BY precio DESC;")
    elif query == 'order_by_name':
        result = execute_sql("SELECT nombre_c, correo_c FROM clientes ORDER BY nombre_c;")
    elif query == 'group_and_order':
        result = execute_sql("SELECT categoria, COUNT(*) AS total FROM producto GROUP BY categoria ORDER BY total DESC;") 
        
    # Consultas Básicas
    elif query == 'basic_1':
        result = execute_sql("SELECT * FROM producto;")
    elif query == 'basic_2':
        result = execute_sql("SELECT * FROM producto WHERE precio > 100;")
    elif query == 'basic_3':
        result = execute_sql("SELECT * FROM producto WHERE categoria = 'Alimentos';")
    elif query == 'basic_4':
        result = execute_sql("SELECT * FROM producto WHERE existencia > 100;")
    elif query == 'basic_5':
        result = execute_sql("SELECT * FROM producto WHERE nombre_p LIKE '%pato%';")
    elif query == 'basic_6':
        result = execute_sql("SELECT * FROM producto WHERE id_p = 1;")
    elif query == 'basic_7':
        result = execute_sql("SELECT * FROM producto WHERE precio BETWEEN 10 AND 50;")
    elif query == 'basic_8':
        result = execute_sql("SELECT * FROM producto WHERE nombre_p LIKE 'Comida%';")
    elif query == 'basic_9':
        result = execute_sql("SELECT * FROM producto WHERE descripcion IS NULL;")
    elif query == 'basic_10':
        result = execute_sql("SELECT * FROM producto WHERE existencia < 100;")
    elif query == 'basic_11':
        result = execute_sql("SELECT * FROM producto WHERE nombre_p = 'Jaula para periquitos';")
    elif query == 'basic_12':
        result = execute_sql("SELECT * FROM producto WHERE precio > 500 AND existencia > 50;")
    elif query == 'basic_13':
        result = execute_sql("SELECT * FROM producto WHERE imagen IS NULL;")
    elif query == 'basic_14':
        result = execute_sql("SELECT * FROM producto WHERE precio < 20 AND categoria = 'Cuidado';")
    elif query == 'basic_15':
        result = execute_sql("SELECT * FROM producto ORDER BY precio DESC;")


    # Consultas Complejas
    elif query == 'complex_1':
        result = execute_sql("SELECT * FROM producto WHERE existencia > 100 ORDER BY nombre_p;")
    elif query == 'complex_2':
        result = execute_sql("SELECT AVG(precio) AS promedio_precio FROM producto WHERE categoria = 'Alimentos';")
    elif query == 'complex_3':
        result = execute_sql("SELECT categoria, nombre_p, MAX(precio) AS precio_max FROM producto GROUP BY categoria;")
    elif query == 'complex_4':
        result = execute_sql("SELECT categoria, COUNT(*) AS total_productos FROM producto GROUP BY categoria;")
    elif query == 'complex_5':
        result = execute_sql("SELECT * FROM producto WHERE precio BETWEEN 50 AND 500 ORDER BY existencia DESC;")
    elif query == 'complex_6':
        result = execute_sql("SELECT categoria, nombre_p, MIN(precio) AS precio_min FROM producto GROUP BY categoria;")
    elif query == 'complex_7':
        result = execute_sql("SELECT * FROM producto WHERE existencia > 50 AND categoria IN ('Accesorios', 'Alimentos');")
    elif query == 'complex_8':
        result = execute_sql("SELECT * FROM producto WHERE categoria = 'Suplementos' ORDER BY precio ASC;")
    elif query == 'complex_9':
        result = execute_sql("SELECT * FROM producto WHERE nombre_p LIKE '%Pato%' AND existencia > 50;")
    elif query == 'complex_10':
        result = execute_sql("SELECT * FROM producto WHERE nombre_p LIKE 'Bebedero%' OR nombre_p LIKE 'Comida%';")
    elif query == 'complex_11':
        result = execute_sql("SELECT nombre_p, precio FROM producto WHERE existencia < 50 ORDER BY precio;")
    elif query == 'complex_12':
        result = execute_sql("SELECT categoria, COUNT(*) AS total_productos FROM producto WHERE existencia > 100 GROUP BY categoria;")
    elif query == 'complex_13':
        result = execute_sql("SELECT nombre_p, existencia FROM producto WHERE nombre_p LIKE '%aliment%';")
    elif query == 'complex_14':
        result = execute_sql("SELECT AVG(precio) AS promedio_precio FROM producto WHERE nombre_p LIKE '%pato%';")
    elif query == 'complex_15':
        result = execute_sql("SELECT * FROM producto WHERE categoria = 'Accesorios' AND precio > 100 AND existencia < 50;")


    # Consultas con Funciones de Agregación
    elif query == 'aggregation_1':
        result = execute_sql("SELECT COUNT(*) AS total_productos FROM producto;")
    elif query == 'aggregation_2':
        result = execute_sql("SELECT AVG(precio) AS precio_promedio FROM producto;")
    elif query == 'aggregation_3':
        result = execute_sql("SELECT SUM(precio) AS suma_precio FROM producto;")
    elif query == 'aggregation_4':
        result = execute_sql("SELECT MAX(precio) AS precio_maximo FROM producto;")
    elif query == 'aggregation_5':
        result = execute_sql("SELECT MIN(precio) AS precio_minimo FROM producto;")
    elif query == 'aggregation_6':
        result = execute_sql("SELECT categoria, COUNT(*) AS total_productos FROM producto GROUP BY categoria;")
    elif query == 'aggregation_7':
        result = execute_sql("SELECT categoria, SUM(existencia) AS total_existencia FROM producto GROUP BY categoria;")
    elif query == 'aggregation_8':
        result = execute_sql("SELECT AVG(precio) AS promedio_precio FROM producto WHERE existencia > 100;")
    elif query == 'aggregation_9':
        result = execute_sql("SELECT categoria, MIN(precio) AS precio_min FROM producto GROUP BY categoria;")
    elif query == 'aggregation_10':
        result = execute_sql("SELECT COUNT(*) AS total_productos FROM producto WHERE existencia > 50;")
    elif query == 'aggregation_11':
        result = execute_sql("SELECT SUM(precio) AS precio_total FROM producto WHERE categoria = 'Viviendas';")
    elif query == 'aggregation_12':
        result = execute_sql("SELECT AVG(precio) AS promedio_precio FROM producto WHERE nombre_p LIKE '%pato%';")
    elif query == 'aggregation_13':
        result = execute_sql("SELECT COUNT(*) AS total_productos FROM producto WHERE categoria = 'Juguetes';")
    elif query == 'aggregation_14':
        result = execute_sql("SELECT categoria, MAX(precio) AS precio_max, MIN(precio) AS precio_min FROM producto GROUP BY categoria;")
    elif query == 'aggregation_15':
        result = execute_sql("SELECT COUNT(*) AS total_productos FROM producto WHERE existencia > 100 AND precio > 50;")


        
    flash(result)

    return redirect(url_for('CompraVenta_ABCD'))

@app.route('/consulta_producto', methods=['GET'])
def consulta_producto():
    # Inicializar result vacío
    result = None
    
    # Verificar el parámetro de consulta recibido
    query = request.args.get('query')
    
    # Ejecutar la consulta correspondiente según el query recibido
    if query == 'vista_precio_promedio':
        result = execute_sql("SELECT * FROM vista_precio_promedio_categoria;")
    elif query == 'vista_existencia_baja':
        result = execute_sql("SELECT * FROM vista_existencia_baja;")
    elif query == 'vista_ventas_totales':
        result = execute_sql("SELECT * FROM vista_ventas_totales_categoria;")
        
    if result:
        flash_result = ""
        for row in result:
            for key, value in row.items():
                flash_result += f"<strong>{key}:</strong> {value}<br>"
            flash_result += "<hr>"  # Separador entre las filas
        flash(flash_result)
    
    # Retornar los resultados a la plantilla
    return render_template('consulta_producto.html', result=result)

@app.route('/vista_precio_promedio')
def vista_precio_promedio():
    return redirect(url_for('consulta_producto', query='vista_precio_promedio'))

@app.route('/vista_existencia_baja')
def vista_existencia_baja():
    return redirect(url_for('consulta_producto', query='vista_existencia_baja'))

@app.route('/vista_ventas_totales')
def vista_ventas_totales():
    return redirect(url_for('consulta_producto', query='vista_ventas_totales'))


if __name__ == "__main__":
    app.run(port=3850, debug=True)


