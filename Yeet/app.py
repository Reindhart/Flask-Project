from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL, MySQLdb
from flask_bcrypt import bcrypt

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'         # Dirección del servidor MySQL
app.config['MYSQL_USER'] = 'root'          # Nombre de usuario para la base de datos
app.config['MYSQL_PASSWORD'] = ''   # Contraseña para el usuario
app.config['MYSQL_DB'] = 'nombre_basededatos' # Nombre de la base de datos

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('inicio.html')

@app.route('/sing-up')
def singup():
    return render_template('singup.html')
    
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
    app.run(debug=True)
