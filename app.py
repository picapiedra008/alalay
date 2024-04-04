from flask import Flask,render_template,request,redirect,url_for,jsonify,flash
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename
import os
import re

UPLOAD_FOLDER = os.path.abspath(os.path.join(os.getcwd(), 'static', 'archivos'))
ALLOWED_EXTENSION = set(['png', 'jpg'])



app = Flask(__name__)
app.config['UPLOAD_FOLDER']=UPLOAD_FOLDER
#mysql conecction
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3306  # Asegúrate de especificar el puerto como un número, no como una cadena
app.config['MYSQL_USER'] = 'root'  # Asegúrate de que este es tu usuario correcto
app.config['MYSQL_PASSWORD'] = ''  # Asegúrate de ingresar tu con
app.config['MYSQL_DB'] = 'campus_alalay'
mysql=MySQL(app)

#setings
app.secret_key='mysecretkey'

@app.route('/')
def index():
    return render_template('perfilDocente.html')

@app.route('/listar')
def listar_cursos():
     cur=mysql.connection.cursor()
     cur.execute("""SELEC*FROM curso,nivel,categoria 
                 WHERE curso.CODCATEGORIA=categoria.CODCATEGORIA 
                 and curso.CODNIVEL=nivel.CODNIVEL;""")
     return render_template('listarCurso.html')

@app.route('/registro')
def add():
    print(request.method)
    cur=mysql.connection.cursor()
    cir=cur
    cur.execute('select*from categoria')
    data1=cur.fetchall()
    cir.execute('select*from nivel')
    data2=cir.fetchall()
    return render_template('RegistroCurso.html',categorias=data1,niveles=data2)



@app.route('/subir',methods=['POST'])
def subir():
    if request.method=='POST':
         global titulo,categoria,nivel,cargaHoraria,costo
         titulo = request.form['titulo'] 
         categoria=request.form['categoria']
         nivel=request.form['nivel']
         cargaHoraria=request.form['cargaHoraria']
         costo=request.form['costo']
         pattern = r"^[A-Za-z\s'-]+$"
    
         if re.match(pattern, titulo):
        # El título del curso es válido
        # Aquí puedes procesar el título como necesites
            return render_template('subirfoto.html')
         else:
        # El título del curso no es válido
            flash('Solo se permiten letras, espacios, guiones (-) y comillas simples (\').')
            return redirect(url_for('add'))
    

def idCategoria(tit):
     c3=mysql.connection.cursor()
     c3.execute('select CODCATEGORIA from categoria where NOMCATEGORIA = %s',(tit,)) 
     id=c3.fetchall()
     print(id[0][0])
     return id[0][0] 
def idNivel(niv):
   c3=mysql.connection.cursor()
   c3.execute('SELECT CODNIVEL FROM NIVEL WHERE NOMNIVEL = %s',(niv,)) 
   id=c3.fetchall()
   return id[0][0] 

@app.route('/add',methods=['POST'])
def addB():    
    if request.method=='POST':
      if 'imageInput' in request.files:
        f= request.files['imageInput']
        filenam = secure_filename(f.filename)
        extension = filenam.rsplit('.', 1)[1].lower()
        if extension in ALLOWED_EXTENSION:
             print('La extensión del archivo es permitida.')
        else:
             return 'extencion no permitido'
        if f:
         filename=f.filename
         f.save(os.path.join(app.config['UPLOAD_FOLDER'],filename))
         image_url=url_for('static', filename='archivos/' + filename, _external=True)
         descripcion=request.form['courseDescription']
         codCat=int(idCategoria(categoria))
         codNiv=int((idNivel(nivel)))
         cur=mysql.connection.cursor()
         cur.execute('insert into curso(CODCATEGORIA,CODNIVEL,NOMCURSO,CARGAHORARIAC,COSTOC,DESCRIPCIONC,PORTADAC) values (%s,%s,%s,%s,%s,%s,%s)',(codCat,codNiv,titulo,cargaHoraria,costo,descripcion,image_url,))
         mysql.connection.commit()  
         return jsonify({'status': 'success', 'message': 'Registrado exitosamente.'})
                  
if __name__=='__main__':
   app.run(port=3000,debug=True)