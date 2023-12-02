<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Registro Notificación</title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        /* Estilos para el cuadro emergente */
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background: #fff;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 9999;
        }
    </style>
    <script>
        // Función para mostrar el cuadro emergente
        function mostrarNotificacion() {
            var popup = document.getElementById("popup");
            popup.style.display = "block";
            setTimeout(function () {
                popup.style.display = "none";
            }, 3000); // Oculta el cuadro emergente después de 3 segundos
        }
    </script>
</head>

<body>
    <h1>Registro de Notificación</h1>
    <form action="RegistrarNotificacion" method="POST">
        <label for="tipo">Tipo de Notificación:</label>
        <select name="tipo">
            <option value="0">Aviso</option>
            <option value="1">Urgencia baja</option>
            <option value="2">Urgencia media</option>
            <option value="3">Urgencia alta</option>
            <option value="4">Sanción</option>
        </select><br>
        <br>
        <br>
        <label for="matricula">Ingrese la Matrícula del Vehículo:</label>
        <input minlength="5" maxlength="12" type="text" id="matricula" name="matricula"><br>
        <br>
        <label for="descripcion">Ingrese la Descripción:</label>
        <textarea id="descripcion" name="descripcion"></textarea>
        <br>
        <br>
        <input type="submit" value="Registrar Notificación">
    </form>

    <!-- Cuadro emergente de notificación -->
    <div id="popup" class="popup">
        Notificación enviada
    </div>

    <div>
        <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atrás">
        </form>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Menú Principal">
        </form>
    </div>

    <script>
        // Llama a la función mostrarNotificacion() cuando la página carga
        window.onload = function () {
            mostrarNotificacion();
        };
    </script>
</body>

</html>
