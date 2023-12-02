package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import almacen.ConexionBD;

@WebServlet("/Chata")
public class Chata extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = ConexionBD.obtenerConexion()) {
            String sql = "SELECT c.id, c.mensaje, c.fecha, c.estado, p.nombre AS usuario FROM chat c "
                    + "INNER JOIN propietario p ON c.propietario_id = p.id " + "ORDER BY c.fecha DESC";

            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            StringBuilder chatMessages = new StringBuilder();
            chatMessages.append("["); // Inicio del array JSON

            boolean first = true;
            while (resultSet.next()) {
                if (!first) {
                    chatMessages.append(",");
                } else {
                    first = false;
                }

                int messageId = resultSet.getInt("id");
                String usuario = resultSet.getString("usuario");
                String mensaje = resultSet.getString("mensaje");
                Timestamp fecha = resultSet.getTimestamp("fecha");
                int estado = resultSet.getInt("estado");

                chatMessages.append("{");
                chatMessages.append("\"id\":\"" + messageId + "\",");
                chatMessages.append("\"usuario\":\"" + usuario + "\",");
                chatMessages.append("\"mensaje\":\"" + mensaje + "\",");
                chatMessages.append("\"fecha\":\"" + fecha + "\",");
                chatMessages.append("\"estado\":\"" + estado + "\"");
                chatMessages.append("}");
            }

            chatMessages.append("]"); // Fin del array JSON

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(chatMessages.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = ConexionBD.obtenerConexion()) {
            String mensaje = request.getParameter("mensaje");
            String accion = request.getParameter("accion");
            int mensajeId = Integer.parseInt(request.getParameter("mensajeId"));

            HttpSession sesion = request.getSession();
            Integer propietarioId = (Integer) sesion.getAttribute("propietarioId");

            // Obtener la fecha actual en el formato deseado
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            Date date = new Date();
            String fechaFormateada = dateFormat.format(date);

            if ("borrar".equals(accion)) {
                borrarMensaje(connection, mensajeId);
            } else if ("ocultar".equals(accion)) {
                ocultarMensaje(connection, mensajeId);
            } else {
                System.out.println(propietarioId + " envia!! mensaje: " + mensaje);
                String sql = "INSERT INTO chat (propietario_id, mensaje, fecha, estado) VALUES (?, ?, ?::timestamp, 0)";
                PreparedStatement statement = connection.prepareStatement(sql);

                if (propietarioId != null) {
                    statement.setInt(1, propietarioId);
                } else {
                    statement.setNull(1, 0);
                }

                statement.setString(2, mensaje);
                statement.setString(3, fechaFormateada); // Asignar la fecha formateada

                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void borrarMensaje(Connection connection, int messageId) throws SQLException {
    	System.out.println("Se ha borrado un mensaje de id: " + messageId);
    	String sql = "DELETE FROM chat WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, messageId);
            statement.executeUpdate();
        }
    }

    private void ocultarMensaje(Connection connection, int messageId) throws SQLException {
    	System.out.println("Se ha ocultado un mensaje de id: " + messageId);
        String sql = "UPDATE chat SET estado = 1 WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, messageId);
            statement.executeUpdate();
        }
    }
}
