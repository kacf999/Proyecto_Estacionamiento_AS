<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="almacen.ConexionBD" %>
<%@ page import="modelo.Notificacion" %>
<%@ page import="modelo.Vehiculo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notificaciones</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            background-color: #007BFF;
            color: #fff;
            padding: 20px;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .notification-type {
            font-weight: bold;
        }

        .notification-type-1 {
            color: blue;
        }

        .notification-type-2 {
            color: orange;
        }

        .notification-type-3 {
            color: red;
        }

        .notification-type-0 {
            color: light-blue;
        }
        
        .btn {
  display: inline-block;
  padding: 10px 20px; /* Aumenté el espaciado para hacerlo más atractivo */
  margin-bottom: 10px;
  font-size: 16px; /* Aumenté el tamaño de fuente */
  font-weight: 600; /* Aumenté el peso de la fuente */
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  touch-action: manipulation;
  cursor: pointer;
  user-select: none;
  background-image: none;
  border: 2px solid #337ab7; /* Hice el borde más prominente */
  border-radius: 25px; /* Aumenté el radio del borde para que se vea más suave */
  color: #337ab7; /* Cambié el color del botón */
  transition: background-color 0.3s, color 0.3s;
}

.btn:hover {
  background-color: #337ab7; /* Cambié el color de fondo al pasar el ratón */
  color: #fff; /* Cambié el color del texto al pasar el ratón */
}

.btn-block {
  display: block;
  width: 100%;
}
        
    </style>
</head>
<body>
<%
HttpSession sesion = request.getSession();
Integer propietarioId = (Integer) sesion.getAttribute("propietarioId");

if (propietarioId == null) {
    // Si el propietarioId no está disponible, redirige al usuario al inicio de sesión
    String url = "login.jsp";
    response.sendRedirect(url);
} else {
    // Realiza la consulta SQL para obtener las notificaciones del usuario
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        // Obtener una conexión a la base de datos
        connection = ConexionBD.obtenerConexion();

        // Consulta SQL para obtener las notificaciones del usuario
        String query = "SELECT tipo, descripcion, fecha, hora, matricula_vehiculo FROM notificaciones WHERE id_propietario = ?";
        statement = connection.prepareStatement(query);
        statement.setInt(1, propietarioId);

        resultSet = statement.executeQuery();

        // Crear un mapa para almacenar modelos y marcas de vehículos
        Map<String, Vehiculo> vehiculosMap = new HashMap<>();
        List<Notificacion> notificacionesList = new ArrayList<>();

        while (resultSet.next()) {
            // Obtener los datos de la notificación desde el resultado de la consulta
            int tipo = resultSet.getInt("tipo");
            String descripcion = resultSet.getString("descripcion");
            java.sql.Date fecha = resultSet.getDate("fecha");
            String hora = resultSet.getString("hora");
            String matricula_vehiculo = resultSet.getString("matricula_vehiculo");

            // Consulta SQL para obtener el modelo y marca del vehículo según la matrícula
            String modeloVehiculo = "";
            String marcaVehiculo = "";
            String modeloQuery = "SELECT modelo, marca FROM vehiculo WHERE matricula = ?";
            PreparedStatement modeloStatement = connection.prepareStatement(modeloQuery);
            modeloStatement.setString(1, matricula_vehiculo);
            ResultSet modeloResultSet = modeloStatement.executeQuery();

            if (modeloResultSet.next()) {
                modeloVehiculo = modeloResultSet.getString("modelo");
                marcaVehiculo = modeloResultSet.getString("marca");
            }

            // Crear un objeto Vehiculo y asignarle los valores de modelo y marca
            Vehiculo vehiculo = new Vehiculo(propietarioId, modeloVehiculo, marcaVehiculo, "", "");
            vehiculosMap.put(matricula_vehiculo, vehiculo);

            // Crear un objeto Notificacion y agregarlo a la lista
            Notificacion notificacion = new Notificacion(propietarioId, descripcion, fecha.toLocalDate(), hora, matricula_vehiculo, tipo);
            notificacionesList.add(notificacion);
        }

        // Ordenar las notificaciones en Java por fecha y hora de manera descendente
        notificacionesList.sort((n1, n2) -> {
            int dateComparison = n2.getFecha().compareTo(n1.getFecha());
            if (dateComparison != 0) {
                return dateComparison;
            }
            return n2.getHora().compareTo(n1.getHora());
        });

%>
	    <form action="menuPrincipal.jsp" method="post">
			<h1>Notificaciones <input type="submit" class="btn btn-primary btn-large" value="Menu Principal"></h1>	        
	    </form>
<table>
    <tr>
        <th>Tipo</th>
        <th>Descripción</th>
        <th>Fecha</th>
        <th>Hora</th>
        <th>Matrícula del Vehículo</th>
        <th>Modelo del Vehículo</th>
        <th>Marca del Vehículo</th>
    </tr>
    <%
    if (notificacionesList.isEmpty()) {
        System.out.println("La lista de notificaciones está vacía");
    } else {
        for (Notificacion notificacion : notificacionesList) {
            // Obtener el vehículo correspondiente desde el mapa
            Vehiculo vehiculo = vehiculosMap.get(notificacion.getMatriculaVehiculo());
    %>
    <tr>
        <td class="notification-type notification-type-<%= notificacion.getTipo() %>">
            <%
            if (notificacion.getTipo() == 0) {
            %>
            Aviso
            <%
            } else if (notificacion.getTipo() == 1) {
            %>
            [1] Urgencia Baja
	            <%
            } else if (notificacion.getTipo() == 2) {
            %>
            [2] Urgencia Media
            <%
            } else if (notificacion.getTipo() == 3) {
            %>
            [3] Urgencia Alta
            <%
            } else {
            %>
            Tipo Desconocido
            <%
        	}
            %>
        </td>
        <td><%= notificacion.getDescripcion() %></td>
        <td><%= notificacion.getFecha() %></td>
        <td><%= notificacion.getHora() %></td>
        <td><%= notificacion.getMatriculaVehiculo() %></td>
        <td><%= vehiculo.getModelo() %></td>
        <td><%= vehiculo.getMarca() %></td>
    </tr>
    <%
        }
    }
    %>
</table>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Cerrar recursos
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
</body>
</html>
