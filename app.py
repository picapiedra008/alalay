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
#app.config['MYSQL_PORT'] = 3310  # Asegúrate de especificar el puerto como un número, no como una cadena
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

@app.route('/curso/<int:curso_id>')
def ver_curso(curso_id):
    # Obtener el curso de la base de datos
    cursor =mysql.connection.cursor()
    query = 'select*from curso,nivel,categoria WHERE curso.CODCATEGORIA=categoria.CODCATEGORIA and curso.CODNIVEL=nivel.CODNIVEL and curso.IDCURSO = %s'
    cursor.execute(query, (curso_id,))
    curso = cursor.fetchall()
    
    if curso:
        return render_template('detalles_curso.html', curso=curso)
    else:
        return "Curso no encontrado", 404
@app.route('/subir1', methods=['POST'])
def Buscar():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        
        # Obtener los cursos con sus respectivos niveles y categorías
        query = """
            SELECT c.IDCURSO, c.NOMCURSO, ca.NOMCATEGORIA, n.NOMNIVEL, c.CARGAHORARIAC, c.COSTOC
            FROM curso c
            INNER JOIN categoria ca ON c.CODCATEGORIA = ca.CODCATEGORIA
            INNER JOIN nivel n ON c.CODNIVEL = n.CODNIVEL
        """
        
        # Aplicar filtros si se han seleccionado categoría, nivel o búsqueda
        categoria = request.form.get('categoria')
        nivel = request.form.get('nivel')
        busqueda = request.form.get('busqueda')
        params = []
        
        if categoria:
            query += " WHERE ca.NOMCATEGORIA = %s"
            params.append(categoria)
        
        if nivel:
            if categoria:
                query += " AND n.NOMNIVEL = %s"
            else:
                query += " WHERE n.NOMNIVEL = %s"
            params.append(nivel)
        
        if busqueda:
            if categoria or nivel:
                query += " AND (c.NOMCURSO LIKE %s OR ca.NOMCATEGORIA LIKE %s OR n.NOMNIVEL LIKE %s)"
            else:
                query += " WHERE c.NOMCURSO LIKE %s OR ca.NOMCATEGORIA LIKE %s OR n.NOMNIVEL LIKE %s"
            params.extend(['%' + busqueda + '%'] * 3)
        
        cursor.execute(query, params)
        cursos = cursor.fetchall()
        
        return render_template('index.html', cursos=cursos, categorias=categoria, niveles=nivel)
@app.route('/listar')
def listar_cursos():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM categoria')
    categorias = cur.fetchall()
    
    cir = mysql.connection.cursor()
    cir.execute('SELECT * FROM nivel')
    niveles = cir.fetchall()
    
    # Obtener parámetros de búsqueda
    categoria_seleccionada = request.args.get('categoria', '')
    nivel_seleccionado = request.args.get('nivel', '')
    busqueda = request.args.get('busqueda', '')

    # Construir consulta SQL con filtros
    query = """
        SELECT c.IDCURSO, c.NOMCURSO, ca.NOMCATEGORIA, n.NOMNIVEL, c.CARGAHORARIAC, c.COSTOC, c.PORTADAC
        FROM curso c
        INNER JOIN categoria ca ON c.CODCATEGORIA = ca.CODCATEGORIA
        INNER JOIN nivel n ON c.CODNIVEL = n.CODNIVEL
        WHERE 1=1
    """
    params = []

    if categoria_seleccionada:
        query += " AND ca.NOMCATEGORIA = %s"
        params.append(categoria_seleccionada)
    
    if nivel_seleccionado:
        query += " AND n.NOMNIVEL = %s"
        params.append(nivel_seleccionado)
    
    if busqueda:
        query += " AND (c.NOMCURSO LIKE %s OR ca.NOMCATEGORIA LIKE %s OR n.NOMNIVEL LIKE %s)"
        params.extend(['%' + busqueda + '%'] * 3)
    
    cur.execute(query, params)
    cursos = cur.fetchall()
    
    return render_template('index.html', cursos=cursos, categorias=categorias, niveles=niveles)



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