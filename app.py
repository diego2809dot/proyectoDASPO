# from flask import Flask, render_template, request, redirect

# app = Flask(__name__)

# comentarios = []

# @app.route('/')
# def inicio():
#     return render_template('index.html')

# @app.route('/quiz')
# def quiz():
#     return render_template('quiz.html')

# @app.route('/foro', methods=['GET', 'POST'])
# def foro():
#     global comentarios
#     if request.method == 'POST':
#         nombre = request.form.get('nombre')
#         mensaje = request.form.get('mensaje')
#         if nombre and mensaje:
#             comentarios.append({'nombre': nombre, 'mensaje': mensaje})
#     return render_template('foro.html', comentarios=comentarios)

# if __name__ == '__main__':
#     app.run(debug=True)

#bootstrap
#Flask

# from flask import Flask, render_template

# app = Flask(__name__)

# @app.route('/')
# def inicio():
#     return render_template('index.html')

# if __name__ == '__main__':
#     app.run(debug=True)

from flask import Flask, render_template, request, redirect

app = Flask(__name__)

# Simulación de almacenamiento temporal de comentarios
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
        nombre = request.form['nombre']
        mensaje = request.form['mensaje']
        comentarios.append({'nombre': nombre, 'mensaje': mensaje})
        return redirect('/foro')
    return render_template('foro.html', comentarios=comentarios)

if __name__ == '__main__':
    app.run(debug=True)
