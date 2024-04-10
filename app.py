from flask import Flask,render_template,request,redirect,url_for,jsonify,flash,session
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename
import os
import re

UPLOAD_FOLDER = os.path.abspath(os.path.join(os.getcwd(), 'static', 'archivos'))
ALLOWED_EXTENSION = set(['png', 'jpg' ,'jpeg'])
MAX_FILE_SIZE = 2 * 1024 * 1024  # 2MB




app = Flask(__name__)
app.config['UPLOAD_FOLDER']=UPLOAD_FOLDER
#mysql conecction
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3310  # Asegúrate de especificar el puerto como un número, no como una cadena
app.config['MYSQL_USER'] = 'root'  # Asegúrate de que este es tu usuario correcto
app.config['MYSQL_PASSWORD'] = ''  # Asegúrate de ingresar tu con
app.config['MYSQL_DB'] = 'campus_alalay'
mysql=MySQL(app)

#setings
app.secret_key='mysecretkey'

@app.route('/')
def index():
    session.clear()
    return render_template('perfilDocente.html')

@app.route('/listar')
def listar_cursos():
     cur=mysql.connection.cursor()
     cur.execute("""SELEC*FROM curso,nivel,categoria 
                 WHERE curso.CODCATEGORIA=categoria.CODCATEGORIA 
                 and curso.CODNIVEL=nivel.CODNIVEL;""")
     return render_template('listarCurso.html')

@app.route('/registro',methods=['POST','GET'])
def add():
    if request.method=='POST':
       session['titulo']=request.form['titulo']
       session['categoria']=request.form['categoria']
       session['nivel']=request.form['nivel']
       session['cargaHoraria']=request.form['cargaHoraria']
       session['costo']=request.form['costo']
       return redirect(url_for('subir'))
    
    print(request.method)
    cur=mysql.connection.cursor()
    cir=cur
    cur.execute('select*from categoria')
    data1=cur.fetchall()
    cir.execute('select*from nivel')
    data2=cir.fetchall()
    return render_template('RegistroCurso.html',categorias=data1,niveles=data2,titulo=session.get('titulo',''),categoria=session.get('categoria'),nivel=session.get('nivel'),cargaHoraria=session.get('cargaHoraria'),costo=session.get('costo'))



@app.route('/subir',methods=['POST','GET'])
def subir():
    if request.method=='POST':
         session['categoria']=request.form['categoria']
         session['nivel']=request.form['nivel']
         session['cargaHoraria']=request.form['cargaHoraria']
         session['costo']=request.form['costo']
         session['titulo']=request.form['titulo']
         return render_template('subirfoto.html')
    

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
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSION

@app.route('/add',methods=['POST'])
def addB():    
    if request.method=='POST':
      titulo = session.get('titulo') 
      categoria=session.get('categoria')
      nivel=str(session.get('nivel'))
      cargaHoraria=str(session.get('cargaHoraria'))
      costo=session.get('costo')
      print(titulo,categoria,nivel,cargaHoraria,costo)
      if 'imageInput' in request.files:
         f= request.files['imageInput']
         filename=f.filename
         f.save(os.path.join(app.config['UPLOAD_FOLDER'],filename))
         image_url=url_for('static', filename='archivos/' + filename)
         descripcion=request.form['courseDescription']
         codCat=int(idCategoria(categoria))
         codNiv=int((idNivel(nivel)))
         cur=mysql.connection.cursor()
         cur.execute('insert into curso(CODCATEGORIA,CODNIVEL,NOMCURSO,CARGAHORARIAC,COSTOC,DESCRIPCIONC,PORTADAC) values (%s,%s,%s,%s,%s,%s,%s)',(codCat,codNiv,titulo,cargaHoraria,costo,descripcion,image_url,))
         mysql.connection.commit()
         return jsonify({'status': 'success', 'message': 'Registrado exitosamente.'})

                  
if __name__=='__main__':
   app.run(port=3000,debug=True)