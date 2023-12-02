package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import almacen.ConexionBD;
import modelo.Encuesta;

@WebServlet("/AlmacenarEncuesta")
public class AlmacenarEncuesta extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = ConexionBD.obtenerConexion()) {
            String sql = "SELECT e.id, e.idusuario AS idUsuario, p.nombre AS nombreUsuario, e.calificacion, e.comentarios, e.fecha " +
                         "FROM encuesta e " + 
                         "INNER JOIN propietario p ON e.idusuario = p.id " +
                         "ORDER BY e.fecha DESC";

            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {

                List<Encuesta> encuestas = new ArrayList<>();

                while (resultSet.next()) {
                    int idEncuesta = resultSet.getInt("id");
                    int idUsuario = resultSet.getInt("idUsuario");
                    String nombreUsuario = resultSet.getString("nombreUsuario");
                    String calificacion = resultSet.getString("calificacion");
                    String comentarios = resultSet.getString("comentarios");
                    String fecha = resultSet.getString("fecha");

                    Encuesta encuesta = new Encuesta(idEncuesta, idUsuario, nombreUsuario, comentarios, calificacion, fecha);
                    encuestas.add(encuesta);
                }

                // Construir la respuesta JSON manualmente
                StringBuilder jsonResponse = new StringBuilder();
                jsonResponse.append("[");
                
                for (Encuesta encuesta : encuestas) {
                    jsonResponse.append("{");
                    jsonResponse.append("\"id\":").append(encuesta.getId()).append(",");
                    jsonResponse.append("\"idUsuario\":").append(encuesta.getIdUsuario()).append(",");
                    jsonResponse.append("\"nombreUsuario\":\"").append(encuesta.getNombreUsuario()).append("\",");
                    jsonResponse.append("\"calificacion\":\"").append(encuesta.getCalificacion()).append("\",");
                    jsonResponse.append("\"comentarios\":\"").append(encuesta.getComentarios()).append("\",");
                    jsonResponse.append("\"fecha\":\"").append(encuesta.getFecha()).append("\"");
                    jsonResponse.append("},");
                }

                // Eliminar la última coma si hay elementos en la lista
                if (!encuestas.isEmpty()) {
                    jsonResponse.deleteCharAt(jsonResponse.length() - 1);
                }

                jsonResponse.append("]");

                // Configurar la respuesta
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Enviar la respuesta JSON al cliente
                response.getWriter().write(jsonResponse.toString());
            } 
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String comentarios = request.getParameter("comentarios");
        String calificacion = request.getParameter("calificacion");

        HttpSession sesion = request.getSession();
        Integer propietarioId = (Integer) sesion.getAttribute("propietarioId");
		// Obtener la fecha actual en el formato deseado
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		Date date = new Date();
		String fechaFormateada = dateFormat.format(date);

        // Puedes hacer algo con los datos, por ejemplo, imprimirlos en la consola del servidor
        System.out.println("Comentarios: " + comentarios);
        System.out.println("Calificación: " + calificacion);
        System.out.println("ID del que comentó: " + propietarioId);

        // Almacenar en la base de datos
        try (Connection connection = ConexionBD.obtenerConexion()) {
            String sql = "INSERT INTO encuesta (calificacion, comentarios, idUsuario, fecha) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer los valores de los parámetros en la consulta
            statement.setString(1, calificacion);
            statement.setString(2, comentarios);
            statement.setInt(3, propietarioId);
            statement.setString(4, fechaFormateada);

            // Ejecutar la consulta
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        String jsonResponse = "{\"mensaje\": \"Gracias por responder, tus comentarios fueron enviados.\"}";

        // Configurar la respuesta
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar la respuesta JSON al cliente
        response.getWriter().write(jsonResponse);
    }
}
