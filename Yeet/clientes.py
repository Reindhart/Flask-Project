from app import app, request, mysql, flash, redirect, url_for, bcrypt

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


@app.route('/dCliente', methods=['GET', 'POST'])
def dCliente():
    id_c = request.form['id_c']
    delCliente = mysql.connection.cursor()
    delCliente.execute("DELETE FROM clientes WHERE id_c=%s", (id_c,))
    mysql.connection.commit()
    flash('Se ha elminado satisfactoriamente')
    return redirect(url_for('Clientes_ABCD'))


@app.route('/iCliente', methods=['POST'])
def iCliente():
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
    return redirect(url_for('Clientes_ABCD'))