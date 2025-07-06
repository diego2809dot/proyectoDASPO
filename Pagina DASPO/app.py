from flask import Flask, render_template, request, redirect, url_for, session, flash
from werkzeug.security import generate_password_hash, check_password_hash
import pyodbc
import os 

app = Flask(__name__)
app.secret_key = os.urandom(24)


def conectar_db():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-AUEI0C4\SQLEXPRESS01;'
        'DATABASE=DASPO;'
        'Trusted_Connection=yes;'
    )
    return conn

# Simulación de almacenamiento en memoria
comentarios = []

@app.route('/')
def inicio():
    return render_template('index.html')

@app.route('/quiz')
def quiz():
    return render_template('quiz.html')

@app.route('/foro', methods=['GET', 'POST'])
def foro():
    if request.method == 'POST':
        nombre = request.form.get('nombre', 'Anónimo').strip()
        mensaje = request.form.get('mensaje', '').strip()
        if mensaje:
            comentarios.append({'nombre': nombre if nombre else 'Anónimo', 'mensaje': mensaje})
        return redirect(url_for('foro'))
    return render_template('foro.html', comentarios=comentarios)

@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        usuario = request.form['usuario']
        password = request.form['password']
        conn = conectar_db()
        cursor = conn.cursor()
        try:
            cursor.execute("""
                INSERT INTO Usuario (Nombre_de_Usuario, Contraseña, Activo)
                VALUES (?, ?, 1)
            """, (usuario, generate_password_hash(password)))
            conn.commit()
            flash('Cuenta creada. Inicia sesión.', 'success')
            return redirect(url_for('login'))
        except Exception:
            flash('Ese usuario ya existe o hubo un error.', 'error')
        finally:
            conn.close()
    return render_template('registro.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        usuario = request.form['usuario']
        password = request.form['password']
        conn = conectar_db()
        cursor = conn.cursor()
        cursor.execute("SELECT ID, Contraseña FROM Usuario WHERE Nombre_de_Usuario = ? AND Activo = 1", usuario)
        row = cursor.fetchone()
        conn.close()
        if row and check_password_hash(row[1], password):
            session['usuario'] = usuario
            session['usuario_id'] = row[0]
            flash('Sesión iniciada.', 'success')
            return redirect(url_for('inicio'))
        else:
            flash('Usuario o contraseña incorrectos.', 'error')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('usuario', None)
    session.pop('usuario_id', None)
    flash('Sesión cerrada.', 'info')
    return redirect(url_for('inicio'))

# EJECUCIÓN DE LA APP
if __name__ == '__main__':
    app.run(debug=True)
