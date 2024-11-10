from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL, MySQLdb
from flask_bcrypt import bcrypt

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('inicio.html')

if __name__ == "__main__":
    app.run(debug=True)
