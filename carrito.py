@app.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    data = request.get_json()
    product_name = data['product_name']
    mycursor = mydb.cursor()
    sql = "INSERT INTO carrito (product_name) VALUES (%s)"
    val = (product_name,)
    mycursor.execute(sql, val)
    mydb.commit()
    return jsonify({"message": "Producto añadido al carrito correctamente"})

if __name__ == '__main__':
    app.run(debug=True)
