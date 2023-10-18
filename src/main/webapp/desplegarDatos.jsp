<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="almacen.ConexionBD" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fotografías Almacenadas</title>
</head>
<body>
    <h1>Fotografías Almacenadas</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Fecha</th>
            <th>Matrícula</th>
            <th>Foto</th>
        </tr>
        <%
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                connection = ConexionBD.obtenerConexion(); // Utiliza tu método personalizado para obtener la conexión

                String sql = "SELECT * FROM fotos"; // Ajusta la consulta SQL
                preparedStatement = connection.prepareStatement(sql);
                resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fecha = resultSet.getString("fecha");
                    String matricula = resultSet.getString("matricula");
                    byte[] fotoBytes = resultSet.getBytes("foto");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= fecha %></td>
                        <td><%= matricula %></td>
                        <td><img src="data:image/jpeg;base64,<%= new String(Base64.getEncoder().encode(fotoBytes)) %>" width="100" height="100"></td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            }
        %>
    </table>
</body>
</html>
