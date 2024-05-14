@app.route('/upload_photo', methods=['POST'])
def upload_photo():
    if 'photo' not in request.files:
        return jsonify({"error": "No se ha proporcionado ninguna foto"}), 400

    photo = request.files['photo']

    if photo.filename == '':
        return jsonify({"error": "No se ha seleccionado ninguna foto"}), 400

    if photo:
        # Guardar la foto en el servidor
        photo.save(os.path.join("uploads", photo.filename))
        return jsonify({"message": "Foto subida correctamente"}), 200

if __name__ == '__main__':
    app.run(debug=True)
