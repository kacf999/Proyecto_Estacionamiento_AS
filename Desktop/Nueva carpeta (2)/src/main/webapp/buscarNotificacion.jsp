<%@ page import="modelo.Notificacion" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Notificaci�n</title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        /* Estilos espec�ficos para la tabla de datos */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white; /* Fondo blanco para la tabla */
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Estilo para las filas con clase 'aviso' */
        tr.aviso {
            background-color: #d3d3d3; /* Gris claro */
        }
    </style>
</head>
<body>
    <h1>Buscar Notificaci�n por Matr�cula</h1>
    <form action="BuscarNotificaciones" method="post">
        <label>Matr�cula del veh�culo:</label> <input type="text" name="matricula"> <br>
        <br> <input type="submit" name="action" value="buscar">
    </form>
          <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atr�s">
        </form>

    <!-- Si se encontraron notificaciones, mostrar formulario de gesti�n -->
    <% if (request.getAttribute("notificacionesEncontradas") != null) {
        boolean notificacionesEncontradas = (boolean) request.getAttribute("notificacionesEncontradas");
        if (notificacionesEncontradas) {
            List<Notificacion> notificaciones = (List<Notificacion>) request.getAttribute("notificaciones");
    %>
    <h2>Notificaciones Encontradas</h2>
    <div>
        <table>
            <tr>
                <th>ID Notificaci�n</th>
                <th>ID Propietario</th>
                <th>Descripci�n</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Tipo</th>
                <th>Matr�cula</th>
            </tr>
            <% for (Notificacion notificacion : notificaciones) { %>
                <td><%= notificacion.getId() %></td> 
                <td><%= notificacion.getIdPropietario() %></td>
                <td><%= notificacion.getDescripcion() %></td>
                <td><%= notificacion.getFecha() %></td>
                <td><%= notificacion.getHora() %></td>
                <td>
                    <% switch (notificacion.getTipo()) {
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
                            out.println("Desconocido");
                    } %>
                </td>
                <td><%= notificacion.getMatriculaVehiculo() %></td>
            </tr>
            <% } %>
        </table>
    </div>
    <div>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Men� Principal">
        </form>
    </div>
    <% } else { %>
    <h2>Notificaciones NO Encontradas</h2>
    <div>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Men� Principal">
        </form>
    </div>
    <% }
       } %>
</body>
</html>
