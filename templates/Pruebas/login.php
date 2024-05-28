<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $usuario = $_POST['usuario'];
    $contrasena = $_POST['contrasena'];

    // Conexión a la base de datos MySQL
    $conexion = new mysqli("localhost", "usuario_db", "contrasena_db", "nombre_db");

    if ($conexion->connect_error) {
        die("Error de conexión: " . $conexion->connect_error);
    }

    $sql = "SELECT * FROM usuarios WHERE usuario = '$usuario' AND contrasena = '$contrasena'";
    $resultado = $conexion->query($sql);

    if ($resultado->num_rows == 1) {
        $_SESSION['usuario'] = $usuario;
        header("location: inicio.php"); // Redirigir a la página de inicio después del inicio de sesión exitoso
    } else {
        echo "Usuario o contraseña incorrectos";
    }

    $conexion->close();
}
?>
