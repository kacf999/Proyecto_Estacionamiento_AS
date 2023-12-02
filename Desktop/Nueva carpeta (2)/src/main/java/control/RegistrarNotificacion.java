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

import almacen.ConexionBD;

@WebServlet("/RegistrarNotificacion")
public class RegistrarNotificacion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los datos del formulario
        int tipoNotificacion = Integer.parseInt(request.getParameter("tipo"));
        String matricula = request.getParameter("matricula");
        String descripcion = request.getParameter("descripcion");

        // Obtener la fecha y hora actual
        Date fechaHoraActual = new Date();
        Timestamp timestamp = new Timestamp(fechaHoraActual.getTime());

        // Obtener el ID del usuario dueño del vehículo a través de la matrícula
        int idUsuario = obtenerIdUsuarioPorMatricula(matricula);

        // Formatear la fecha y la hora
        String fechaFormateada = new SimpleDateFormat("dd-MM-yyyy").format(fechaHoraActual);
        String horaFormateada = new SimpleDateFormat("HH:mm").format(fechaHoraActual);

        // Insertar la notificación en la tabla encuesta
        boolean exito = insertarNotificacionEnBD(idUsuario, tipoNotificacion, matricula,descripcion, fechaFormateada, horaFormateada);

        if (exito) {
            // La inserción fue exitosa, puedes redirigir a una página de éxito
            request.setAttribute("registroNotificacion", "Se envió la notificación.");
        } else {
            // La inserción falló, puedes redirigir a una página de error
            request.setAttribute("registroNotificacion", "NO se envió la notificación (error).");
        }
        request.getRequestDispatcher("registrarNotificacion.jsp").forward(request, response);

    }

    private int obtenerIdUsuarioPorMatricula(String matricula) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "SELECT id_propietario FROM vehiculo WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);

            ResultSet resultSet = statement.executeQuery();
            int idPropietario = -1;

            if (resultSet.next()) {
                idPropietario = resultSet.getInt("id_propietario");
            }

            resultSet.close();
            statement.close();
            connection.close();

            return idPropietario;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private boolean insertarNotificacionEnBD(int idUsuario, int tipoNotificacion, String matricula, String descripcion, String fecha, String hora) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            // Utilizar la función TO_DATE para convertir la cadena a un tipo de fecha
            String query = "INSERT INTO notificaciones (id_propietario, tipo,matricula_vehiculo, descripcion, fecha, hora) VALUES (?, ?, ?, ?, TO_DATE(?, 'DD-MM-YYYY'), ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, idUsuario);
            statement.setInt(2, tipoNotificacion);
            statement.setString(3, matricula);
            statement.setString(4,  descripcion);
            statement.setString(5, fecha);
            statement.setString(6, hora);

            int filasInsertadas = statement.executeUpdate();

            statement.close();
            connection.close();

            return filasInsertadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
