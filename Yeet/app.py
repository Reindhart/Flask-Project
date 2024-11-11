from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL, MySQLdb
from flask_bcrypt import bcrypt

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('inicio.html')

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
