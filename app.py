
from flask import Flask,render_template,request,redirect,url_for,jsonify,flash,session
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename
from google.oauth2 import id_token
from google_auth_oauthlib.flow import Flow
from pip._vendor import cachecontrol
import google.auth.transport.requests
import requests
import pathlib
import os
import smtplib
import email
from email.mime.text import MIMEText

UPLOAD_FOLDER = os.path.abspath(os.path.join(os.getcwd(), 'static', 'archivos'))
ALLOWED_EXTENSION = set(['png', 'jpg' ,'jpeg'])
MAX_FILE_SIZE = 2 * 1024 * 1024  # 2MB


app = Flask(__name__)
app.secret_key='mysecretkey'

app.config['UPLOAD_FOLDER']=UPLOAD_FOLDER
#mysql conecction
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3306  # Asegúrate de especificar el puerto como un número, no como una cadena
app.config['MYSQL_USER'] = 'root'  # Asegúrate de que este es tu usuario correcto
app.config['MYSQL_PASSWORD'] = ''  # Asegúrate de ingresar tu con
app.config['MYSQL_DB'] = 'campus_alalay'
mysql=MySQL(app)


@app.route('/')
def landing():
    session.clear()
    return render_template('Landing.html')
#temporal
@app.route('/tablaContenido')
def contenido():
    cursor = mysql.connection.cursor()
    cursor.execute("""
    SELECT contenido.codContenido, contenido.videoC, contenido.archivo, contenido.descripcion, unidad.nombreU
    FROM contenido
    JOIN unidad ON contenido.codUnidad = unidad.codUnidad
     """)
    datos_contenido = cursor.fetchall()
    cursor.close()
    return render_template('tablacontenido.html', datos_contenido=datos_contenido)

@app.route('/carrito')
def abrir_carrito():
    cursor = mysql.connection.cursor()
    # Consulta SQL para obtener todos los cursos en el carrito
    query = """
    SELECT curso.IDCURSO, curso.NOMCURSO, curso.CARGAHORARIAC, curso.COSTOC, nivel.NOMNIVEL
    FROM carrito
    JOIN curso ON carrito.IDCURSO = curso.IDCURSO
    JOIN nivel ON curso.CODNIVEL = nivel.CODNIVEL
    """
    cursor.execute(query)
    cursos = cursor.fetchall()
    
    # Convertir precios a números y calcular el total
    cursos_converted = []
    total = 0
    for curso in cursos:
        idCurso, nombre, duracion, costo, nivel = curso
        costo = float(costo)
        cursos_converted.append((idCurso, nombre, duracion, costo, nivel))
        total += costo
    
    cursor.close()
    return render_template('carrito_cursos.html', cursos=cursos_converted, total=total)



@app.route('/agregar_al_carrito', methods=['POST'])
def agregar_al_carrito():
    curso_id = request.form.get('curso_id')

    if curso_id:
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO carrito (id, IDCURSO) VALUES (NULL, %s)", (curso_id,))
        mysql.connection.commit()
        cursor.close()
        return jsonify({'success': True})
    else:
        return jsonify({'success': False, 'message': 'Faltan datos'}), 400
    
@app.route('/registrar_docente')
def registrar_docente():
    return render_template('registro_docente.html')

@app.route('/addMaterial/<int:section_id>')
def addmat(section_id):
    # Consulta para obtener el nombre de la unidad
    cur = mysql.connection.cursor()
    cur.execute("SELECT codUnidad, nombreU FROM unidad WHERE codUnidad = %s", (section_id,))
    unidad = cur.fetchone()
    cur.close()

    return render_template('añadirArchivo.html', unidad=unidad)
# Editar Perfil
@app.route('/editar_perfil')
def editar_perfil():
    usuario=session.get('usuario')    
    conn = mysql.connection.cursor()
    cur=mysql.connection.cursor()
    cur.execute("select*from registro_docentes where nombre_completo=%s",(usuario,))
    docente=cur.fetchone()
    return render_template('editar_perfil.html',docente=docente)

@app.route('/upload', methods=['POST', 'GET'])
def upload_file():
    if request.method == 'POST':
        # Obtener los datos del formulario
        nombre_completo = request.form['nombre']
        correo_electronico = request.form['email']
        contrasena = request.form['contrasena']
        especialidad = request.form['especialidad']
        nacionalidad = request.form['nacionalidad']
        descripcion = request.form['descripcion']

        foto = request.files.get('file')
        archivo = request.files.get('customFile')

        # Guardar la foto y el archivo si se proporcionan
        image_url = None
        image_url2 = None

        if foto:
            filename = foto.filename
            foto.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            image_url = url_for('static', filename='archivos/' + filename)

        if archivo:
            filename2 = archivo.filename
            archivo.save(os.path.join(app.config['UPLOAD_FOLDER'], filename2))
            image_url2 = url_for('static', filename='archivos/' + filename2)

        # Insertar los datos en la base de datos
        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO registro_docentes (
                nombre_completo, correo_electronico, contrasena, especialidad, nacionalidad, foto, descripcion, curiculum
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (nombre_completo, correo_electronico, contrasena, especialidad, nacionalidad, image_url, descripcion, image_url2))

        mysql.connection.commit()
        cur.close()
        print("se registro con exito")
        return jsonify({'status': 'success', 'message': 'Registrado exitosamente.'})


@app.route('/home')
def index():
    session.clear()
    return render_template('perfilDocente.html')

@app.route('/curso/<int:curso_id>')
def ver_curso(curso_id):
    # Obtener el curso de la base de datos
    cursor = mysql.connection.cursor()
    query = 'SELECT * FROM curso, nivel, categoria WHERE curso.CODCATEGORIA=categoria.CODCATEGORIA AND curso.CODNIVEL=nivel.CODNIVEL AND curso.IDCURSO = %s'
    cursor.execute(query, (curso_id,))
    curso = cursor.fetchall()

    # Obtener el ID del curso anterior y siguiente
    query = 'SELECT IDCURSO FROM curso ORDER BY IDCURSO'
    cursor.execute(query)
    cursos = cursor.fetchall()
    curso_index = cursos.index((curso_id,))
    curso_anterior_id = cursos[curso_index - 1][0] if curso_index > 0 else None
    curso_siguiente_id = cursos[curso_index + 1][0] if curso_index < len(cursos) - 1 else None

    if curso:
        return render_template('detalles_curso.html', curso=curso, curso_anterior_id=curso_anterior_id, curso_siguiente_id=curso_siguiente_id)
    else:
        return "Curso no encontrado", 404

@app.route('/ver_curso/<int:curso_id>')
def ver_curso_docente(curso_id):
    # Obtener el curso de la base de datos
    cursor = mysql.connection.cursor()
    query = 'SELECT * FROM curso, nivel, categoria WHERE curso.CODCATEGORIA=categoria.CODCATEGORIA AND curso.CODNIVEL=nivel.CODNIVEL AND curso.IDCURSO = %s'
    cursor.execute(query, (curso_id,))
    curso = cursor.fetchall()
    if curso:
        return render_template('ver_curso.html', curso=curso)
    else:
        return "Curso no encontrado", 404
    
@app.route('/listar' , methods=['POST','GET'])
def listar_cursos():
    conn = mysql.connection
    cur = conn.cursor()
    cur.execute('SELECT * FROM categoria')
    categorias = cur.fetchall()
    
    cir = conn.cursor()  # Cambiado aquí
    cir.execute('SELECT * FROM nivel')
    niveles = cir.fetchall()
    
    # Obtener parámetros de búsqueda
    categoria_seleccionada = request.args.get('categoria', None)
    nivel_seleccionado = request.args.get('nivel', None)
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
    
    return render_template('index.html', cursos=cursos, categorias=categorias, niveles=niveles, 
                        categoria_seleccionada=categoria_seleccionada, nivel_seleccionado=nivel_seleccionado,
                        busqueda=busqueda)

@app.route('/addseccion/<int:curso_id>', methods=['GET', 'POST'])
def addseccion(curso_id):
    if request.method == 'POST':
        name = request.form['section-name']
        description = request.form['section-description']
        cur = mysql.connection.cursor()
        try:
            cur.execute("INSERT INTO unidad (nombreU, descripcion, IDCURSO) VALUES (%s, %s, %s)", (name, description, curso_id))
            mysql.connection.commit()
            flash('Sección añadida exitosamente', 'success')
        except Exception as e:
            mysql.connection.rollback()
            flash(f'Error al añadir la sección: {str(e)}', 'danger')
        finally:
            cur.close()
        return redirect(url_for('addseccion', curso_id=curso_id))

    # Recuperar todas las secciones
    cur = mysql.connection.cursor()
    conn = mysql.connection.cursor()
    cur.execute("SELECT * FROM unidad WHERE IDCURSO = %s", (curso_id,))
    conn.execute("SELECT co.* FROM curso c, unidad u, contenido co WHERE c.IDCURSO = u.IDCURSO AND u.codUnidad = co.codUnidad AND c.IDCURSO = %s", (curso_id,))
    sections = cur.fetchall()
    contenido = conn.fetchall()
    cur.close()
    conn.close()
    return render_template('addUnit.html', sections=sections, curso_id=curso_id, contenido=contenido)

@app.route('/delete_section/<int:id_section>/<int:curso_id>')
def delete_section(id_section,curso_id):
    cur=mysql.connection.cursor()
    conn=cur
    cur.execute("delete from contenido where codUnidad=%s",(id_section,))
    conn.execute("delete from unidad where codUnidad=%s",(id_section,))
    cur.connection.commit()
    conn.connection.commit()
    return redirect(url_for('addseccion',curso_id=curso_id))
    
@app.route('/add1', methods=['POST'])
def addfile():
    if request.method == 'POST':
        video = request.files.get('videoFile')
        archivo = request.files.get('presentationFile')
        contenido_html = request.form.get('contenidoHTML', '') # Asegúrate de proporcionar un valor por defecto si no se envía
        cod_unidad = request.form.get('codUnidad')

        if video or archivo or contenido_html.strip() != '':
            filename = video.filename if video else None
            filename2 = archivo.filename if archivo else None

            if filename:
                video.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                video_url = url_for('static', filename='archivos/' + filename)
            else:
                video_url = None

            if filename2:
                archivo.save(os.path.join(app.config['UPLOAD_FOLDER'], filename2))
                archivo_url2 = url_for('static', filename='archivos/' + filename2)
            else:
                archivo_url2 = None

            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO contenido (videoC, archivo, descripcion, codUnidad) VALUES (%s, %s, %s, %s)", (video_url, archivo_url2, contenido_html, cod_unidad))
            mysql.connection.commit()
            cur.close()
            print("Se registró con éxito")
            return jsonify({'status': 'success', 'message': 'Registrado exitosamente.'})
        else:
            return jsonify({'status': 'error', 'message': 'Debe proporcionar al menos un campo de contenido.'})
      
@app.route('/perfil',methods=['POST','GET'])
def perfildocente():
    if request.method == 'POST':
        usuario=request.form['usuario']
        session['usuario']=usuario    
        conn = mysql.connection.cursor()
        cur=mysql.connection.cursor()
        cur.execute("select*from registro_docentes where nombre_completo=%s",(usuario,))
        docentes=cur.fetchone()
        session['id']=docentes[0]
        # Construir consulta SQL con filtros
        query = """
         SELECT c.IDCURSO, c.NOMCURSO, ca.NOMCATEGORIA, n.NOMNIVEL, c.CARGAHORARIAC, c.COSTOC, c.PORTADAC ,d.id
         FROM curso c
         INNER JOIN categoria ca ON c.CODCATEGORIA = ca.CODCATEGORIA
         INNER JOIN nivel n ON c.CODNIVEL = n.CODNIVEL
         INNER JOIN registro_docentes d ON d.id=c.id
         WHERE d.nombre_completo=%s or d.correo_electronico=%s
         """          
        conn.execute(query,(usuario,usuario,))
        cursos = conn.fetchall()
        return render_template('inicioDocente.html', cursos=cursos,docentes=docentes)
    else:
        usuario=session.get('usuario')
        session.clear() 
        session['usuario']=usuario  
        conn = mysql.connection.cursor()
        cur=mysql.connection.cursor()
        cur.execute("select*from registro_docentes where nombre_completo=%s",(usuario,))
        docentes=cur.fetchone()
        session['id']=docentes[0]
        # Construir consulta SQL con filtros
        query = """
          SELECT c.IDCURSO, c.NOMCURSO, ca.NOMCATEGORIA, n.NOMNIVEL, c.CARGAHORARIAC, c.COSTOC, c.PORTADAC ,d.id
         FROM curso c
         INNER JOIN categoria ca ON c.CODCATEGORIA = ca.CODCATEGORIA
         INNER JOIN nivel n ON c.CODNIVEL = n.CODNIVEL
         INNER JOIN registro_docentes d ON d.id=c.id
         WHERE d.nombre_completo=%s or d.correo_electronico=%s
         """           
        conn.execute(query,(usuario,usuario))
        cursos = conn.fetchall()
        return render_template('inicioDocente.html', cursos=cursos,docentes=docentes)
        
 
@app.route('/registro',methods=['POST','GET'])
def add():
    print(request.method)
    cur=mysql.connection.cursor()
    cir=cur
    nom=cir
    nom.execute('select NOMCURSO from curso')
    data3=nom.fetchall()
    cur.execute('select*from categoria')
    data1=cur.fetchall()
    cir.execute('select*from nivel')
    data2=cir.fetchall()
    nombres=[titulo[0] for titulo in data3]
    
    return render_template('RegistroCurso.html',titulos=nombres ,categorias=data1,niveles=data2,titulo=session.get('titulo',''),cat=session.get('categoria'),niv=session.get('nivel'),cargaHoraria=session.get('cargaHoraria'),costo=session.get('costo'))

@app.route('/subir',methods=['POST','GET'])
def subir():
    if request.method=='POST':
         session['categoria']=request.form['categoria']
         session['nivel']=request.form['nivel']
         session['cargaHoraria']=request.form['cargaHoraria']
         session['costo']=request.form['costo']
         session['titulo']=request.form['titulo']
         return render_template('subirfoto.html',id=id)
    
def idCategoria(tit):
     c3=mysql.connection.cursor()
     c3.execute('select CODCATEGORIA from categoria where NOMCATEGORIA = %s',(tit,)) 
     id=c3.fetchall()
     print(id[0][0])
     return id[0][0] 
def idNivel(niv):
   c3=mysql.connection.cursor()
   c3.execute('SELECT CODNIVEL FROM nivel WHERE NOMNIVEL = %s',(niv,)) 
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
         cur.execute('insert into curso(CODCATEGORIA,CODNIVEL,NOMCURSO,CARGAHORARIAC,COSTOC,DESCRIPCIONC,PORTADAC,id) values (%s,%s,%s,%s,%s,%s,%s,%s)',(codCat,codNiv,titulo,cargaHoraria,costo,descripcion,image_url,session.get('id')))
         mysql.connection.commit()
         return jsonify({'status': 'success', 'message': 'Registrado exitosamente.'})
      


@app.route('/login')
def login():
    conn= mysql.connection.cursor()
    cur=conn
    conn.execute("select*from estudiante")
    estudiantes=conn.fetchall()
    cur.execute("select*from registro_docentes")
    docentes=cur.fetchall()
    return render_template('login.html',docentes=docentes,estudiantes=estudiantes)

def send_welcome_email(email, name):
    try:
        # Configurar los detalles del servidor SMTP y el remitente
        smtp_server = 'smtp.gmail.com'
        smtp_port = 587
        smtp_username = 'campusalalay2024@gmail.com'
        smtp_password = 'cqgt pcqq xbwa ovzl'
        sender_email = smtp_username
        # Configurar el contenido del correo electrónico
        recipient_email = email
        subject = '¡Bienvenido a Campus Alalay!' + name
        body = 'Bienvenido a la plataforma Campus Alalay. ¡Gracias por registrarte!'
        # Crear el mensaje
        msg = MIMEText(body, 'plain', 'utf-8')
        msg['Subject'] = subject
        msg['From'] = sender_email
        msg['To'] = recipient_email

        # Iniciar la conexión SMTP
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(smtp_username, smtp_password)

        # Enviar el correo electrónico
        server.sendmail(sender_email, recipient_email, msg.as_string())

        # Cerrar la conexión
        server.quit()
        print('Correo electrónico enviado correctamente')
    except Exception as e:
        print(f'Error al enviar el correo electrónico: {str(e)}')

@app.route('/check_email', methods=['POST'])
def check_email():
    email = request.json['email']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM estudiante WHERE correo = %s", (email,))
    account = cur.fetchone()
    cur.close()
    if account:
        return jsonify({'exists': True})
    else:
        return jsonify({'exists': False})

@app.route('/register', methods=['POST'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        
        # Verificar si el correo ya está registrado
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM estudiante WHERE correo = %s", (email,))
        account = cur.fetchone()
        if account:
            flash('El correo electrónico ya se encuentra registrado.', 'error')
            return redirect(url_for('login', form='register') + '#registro')
        
        # Insertar los datos del usuario en la base de datos
        cur.execute("INSERT INTO estudiante (nombre,correo, Contrasena) VALUES (%s, %s, %s)", (name, email, password))
        mysql.connection.commit()
        cur.close()
        
        # Enviar el correo electrónico de bienvenida
        send_welcome_email(email, name)
        
        return jsonify({'status': 'success', 'message': 'Registrado exitosamente.'})


if __name__=='__main__':
   app.run(port=5000,debug=True)