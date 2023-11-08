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

@WebServlet("/Chat")
public class Chat extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConexionBD.obtenerConexion()) {
            String sql = "SELECT c.mensaje, c.fecha, p.nombre AS usuario FROM chat c " +
                         "INNER JOIN propietario p ON c.propietario_id = p.id " +
                         "ORDER BY c.fecha DESC";

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

                String usuario = resultSet.getString("usuario");
                String mensaje = resultSet.getString("mensaje");
                Timestamp fecha = resultSet.getTimestamp("fecha");

                chatMessages.append("{");
                chatMessages.append("\"usuario\":\"" + usuario + "\",");
                chatMessages.append("\"mensaje\":\"" + mensaje + "\",");
                chatMessages.append("\"fecha\":\"" + fecha + "\"");
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConexionBD.obtenerConexion()) {
            String mensaje = request.getParameter("mensaje");
            HttpSession sesion = request.getSession();
            Integer propietarioId = (Integer) sesion.getAttribute("propietarioId");

            // Obtener la fecha actual en el formato deseado
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            Date date = new Date();
            String fechaFormateada = dateFormat.format(date);

            System.out.println(propietarioId + " envió mensaje: " + mensaje);
            String sql = "INSERT INTO chat (propietario_id, mensaje, fecha) VALUES (?, ?, ?::timestamp)";
            PreparedStatement statement = connection.prepareStatement(sql);

            if (propietarioId != null) {
                statement.setInt(1, propietarioId);
            } else {
                statement.setNull(1, 0);
            }

            statement.setString(2, mensaje);
            statement.setString(3, fechaFormateada); // Asignar la fecha formateada

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
