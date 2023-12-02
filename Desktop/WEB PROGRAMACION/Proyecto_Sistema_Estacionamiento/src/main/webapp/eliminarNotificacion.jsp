<%@ page import="modelo.Notificacion"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar  Notificacion por matrícula</title>
    <link rel="stylesheet" href="estilo.css">
    <script>
        // Función para mostrar el cuadro de diálogo
        function mostrarDialogo() {
            alert("No se encontraron notificaciones.");
        }
    </script>
</head>
<body>
    <h1>Eliminar Notificacion por matrícula</h1>
    <form action="EliminarNotificaciones" method="post">
        <label>Matrícula del vehículo:</label> <input type="text" name="matricula"> <br>
        <br> <input type="submit" name="action" value="buscar">
    </form>
    <div>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Menu Principal">
        </form>
                <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atrás">
        </form>
    </div>

    <!-- Mensajes de éxito o error al eliminar -->
    <% if (request.getAttribute("mensajeEliminarUna") != null) {
        String mensajeEliminarUna = (String) request.getAttribute("mensajeEliminarUna");
        out.println("<p>" + mensajeEliminarUna + "</p>");
    } %>

    <% if (request.getAttribute("mensajeEliminarTodas") != null) {
        String mensajeEliminarTodas = (String) request.getAttribute("mensajeEliminarTodas");
        out.println("<p>" + mensajeEliminarTodas + "</p>");
    } %>

    <!-- Si se encontraron notificaciones, mostrar formulario de gestión -->
    <% if (request.getAttribute("notificacionesEncontradas") != null) {
        boolean notificacionesEncontradas = (boolean) request.getAttribute("notificacionesEncontradas");
        if (notificacionesEncontradas) {
            List<Notificacion> notificaciones = (List<Notificacion>) request.getAttribute("notificaciones");
    %>
    <h2>Notificaciones Encontradas</h2>
    <div>
        <h3>Notificaciones de esa matrícula:</h3>
        <!-- Botón para eliminar todas las notificaciones -->
        <form action="EliminarNotificaciones" method="POST">
            <button type="submit" name="action" value="eliminarTodas">Eliminar Todas</button>
        </form>

        <!-- Matriz para almacenar datos -->
        <table border="1">
            <tr>
                <th>ID Notificación</th>
                <th>ID Propietario</th>
                <th>Descripción</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Tipo</th>
                <th>Matrícula</th>
                <th>Acciones</th>
            </tr>
            <% for (Notificacion notificacion : notificaciones) { %>
            <tr>
                <td><%= notificacion.getId() %></td> 
                <td><%= notificacion.getIdPropietario() %></td>
                <td><%= notificacion.getDescripcion() %></td>
                <td><%= notificacion.getFecha() %></td>
                <td><%= notificacion.getHora() %></td>
                <td>
                    <% 
                    // Utilizar un switch para mostrar el tipo de notificación de manera descriptiva
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
                            out.println("Sanción");
                            break;
                        default:
                            out.println("Desconocido");
                    }
                    %>
                </td>
                <td><%= notificacion.getMatriculaVehiculo() %></td>
                <td>
                    <!-- Botón para eliminar la notificación individual -->
                    <form action="EliminarNotificaciones" method="POST">
                        <input type="hidden" name="idNotificacion" value="<%= notificacion.getId() %>"> 
                        <button type="submit" name="action" value="eliminarIndividual">Eliminar</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
    <div>
    </div>
    <% } else { %>
    <!-- Si no se encuentran notificaciones, mostrar cuadro de diálogo -->
    <script>
        mostrarDialogo();
    </script>
    <h2>Notificaciones NO Encontradas</h2>
    <div>
        <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atrás">
        </form>
        
    </div>
    <% }
       } %>
</body>
</html>
