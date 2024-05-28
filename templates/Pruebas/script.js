document.addEventListener('DOMContentLoaded', function() {
    // Activar el botón de ayuda con la tecla F1
    document.addEventListener('keydown', function(event) {
        if (event.key === 'F1') {
            // Cargar archivo de ayuda
            window.location.href = 'ayuda.chm';
        }
    });

    // Obtener fecha actual y actualizarla dinámicamente
    function actualizarFecha() {
        var fechaActual = new Date();
        var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        document.getElementById('fechaActual').innerText = fechaActual.toLocaleDateString('es-ES', options);
    }

    actualizarFecha();
    setInterval(actualizarFecha, 60000); // Actualizar cada minuto
});
