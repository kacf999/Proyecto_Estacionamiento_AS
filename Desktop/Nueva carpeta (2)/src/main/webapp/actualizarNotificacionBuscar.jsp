<%@ page import="modelo.Notificacion" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar y Actualizar Notificaciones</title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        td {
            padding-top: 12px;
            padding-bottom: 12px;
        }

        .mensaje {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            margin-bottom: 20px;
        }

        #reloj {
            position: fixed;
            top: 0;
            right: 0; /* Posiciona el reloj en la esquina superior derecha */
            padding: 10px;
            background-color: #f2f2f2;
        }

        #ubicacion {
            position: fixed;
            top: 30px;
            right: 0;
            padding: 10px;
            background-color: #f2f2f2;
        }
    </style>

    <script>
        function actualizarReloj() {
            var fecha = new Date();
            var horas = fecha.getHours();
            var minutos = fecha.getMinutes();
            var segundos = fecha.getSeconds();
            var dia = fecha.getDate();
            var mes = fecha.getMonth() + 1; // Los meses en JavaScript son de 0 a 11
            var anio = fecha.getFullYear();
            
            document.getElementById("reloj").innerText = "Fecha y hora: " + agregarCero(dia) + "/" + agregarCero(mes) + "/" + anio + " " + agregarCero(horas) + ":" + agregarCero(minutos) + ":" + agregarCero(segundos);
            setTimeout(actualizarReloj, 1000); // Actualizar cada segundo
        }

        function agregarCero(i) {
            return i < 10 ? "0" + i : i;
        }

        function obtenerUbicacion() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var latitud = position.coords.latitude.toFixed(6);
                    var longitud = position.coords.longitude.toFixed(6);

                    // Llamada a la API de geolocalizaci�n inversa
                    fetch(`https://api.opencagedata.com/geocode/v1/json?q=${latitud}+${longitud}&key=TU_CLAVE_API`)
                        .then(response => response.json())
                        .then(data => {
                            var ciudad = data.results[0].components.city;
                            var ubicacion = `Ubicaci�n: ${ciudad}, Latitud ${latitud}, Longitud ${longitud}`;
                            document.getElementById("ubicacion").innerText = ubicacion;
                        })
                        .catch(error => {
                            console.error('Error al obtener la ubicaci�n:', error);
                        });
                });
            } else {
                document.getElementById("ubicacion").innerText = "La geolocalizaci�n no est� disponible en este navegador.";
            }
        }

        window.onload = function() {
            actualizarReloj(); // Iniciar el reloj al cargar la p�gina
            obtenerUbicacion(); // Obtener la ubicaci�n al cargar la p�gina
        };
    </script>
</head>
<body>
    <!-- Reloj en la esquina superior derecha -->
    <div id="reloj"></div>

    <!-- Ubicaci�n en la esquina superior derecha -->
    <div id="ubicacion"></div>

    <h1>Buscar y Actualizar Notificaciones por Matr�cula</h1>
    
    <form action="BuscarNotificacionesActualizar" method="post">
        <!-- Campo para buscar notificaciones por matr�cula -->
        <label>Matr�cula del veh�culo:</label> <input type="text" name="matricula" required> <br>

        <br>

        <input type="submit" name="action" value="buscar">
    </form>

    <!-- Mensaje de datos actualizados -->
    <% if (request.getAttribute("datosActualizados") != null) { %>
        <div class="mensaje">
            <p>Datos actualizados</p>
        </div>
    <% } %>

    <!-- Si se encontraron notificaciones, mostrar formulario de gesti�n -->
    <% if (request.getAttribute("notificacionesEncontradas") != null) {
        boolean notificacionesEncontradas = (boolean) request.getAttribute("notificacionesEncontradas");
        if (notificacionesEncontradas) {
            List<Notificacion> notificaciones = (List<Notificacion>) request.getAttribute("notificaciones");
    %>
    <h2>Notificaciones Encontradas</h2>
    <table>
        <thead>
            <tr>
                <th>ID Notificaci�n</th>
                <th>ID Propietario</th>
                <th>Descripci�n</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Tipo</th>
                <th>Matr�cula</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <% for (Notificacion notificacion : notificaciones) { %>
            <tr>
                <td><%= notificacion.getId() %></td> 
                <td><%= notificacion.getIdPropietario() %></td>
                <td><%= notificacion.getDescripcion() %></td>
                <td><%= notificacion.getFecha() %></td>
                <td><%= notificacion.getHora() %></td>
                <td>
                    <% 
                        switch (notificacion.getTipo()) {
                            case 0:
                                out.println("Aviso");
                                break;
                            case 1:
                                out.println("Urgencia baja");
                                break;
                            case 2:
                                out.println("Urgencia media");
                                break;
                            case 3:
                                out.println("Urgencia alta");
                                break;
                            case 4:
                                out.println("Sanci�n");
                                break;
                            default:
                                out.println("Tipo desconocido");
                        }
                    %>
                </td>
                <td><%= notificacion.getMatriculaVehiculo() %></td>
                <td>
                    <!-- Bot�n para actualizar la notificaci�n individual -->
                    <form action="actualizarNotificacion.jsp" method="POST">
                        <input type="hidden" name="idNotificacion" value="<%= notificacion.getId() %>">
                        <button type="submit" name="action" value="actualizar">Actualizar</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } else { %>
    <h2>Notificaciones NO Encontradas</h2>
    <% } } %>
            <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atr�s">
        </form>
</body>
</html>
