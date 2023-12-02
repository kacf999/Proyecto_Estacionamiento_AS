package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.Notificacion;

@WebServlet("/EliminarNotificaciones")
public class EliminarNotificaciones extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String action = request.getParameter("action");
        String matricula = request.getParameter("matricula");

        int idPropietario = obtenerIdUsuarioPorMatricula(matricula);

        if ("buscar".equals(action)) {
            // Buscar notificaciones según la matrícula
            List<Notificacion> notificaciones = buscarNotificacionesEnBD(idPropietario);

            if (!notificaciones.isEmpty()) {
                // Notificaciones encontradas, redirigir al formulario con la lista
                request.setAttribute("notificacionesEncontradas", true);
                request.setAttribute("notificaciones", notificaciones);
                request.getRequestDispatcher("eliminarNotificacion.jsp").forward(request, response);
            } else {
                // Notificaciones no encontradas, mostrar mensaje de error
                request.setAttribute("notificacionesEncontradas", false);
                request.getRequestDispatcher("eliminarNotificacion.jsp").forward(request, response);
            }
        } else if ("eliminarIndividual".equals(action)) {
            // Obtener el ID de la notificación a eliminar
            int idNotificacion = Integer.parseInt(request.getParameter("idNotificacion"));

            // Eliminar la notificación individual
            boolean exito = eliminarNotificacionIndividual(idNotificacion);

            if (exito) {
                // Notificación eliminada con éxito, establecer mensaje y redirigir
                request.setAttribute("mensajeEliminarUna", "Notificación individual eliminada correctamente.");
            } else {
                // Error al eliminar, establecer mensaje y redirigir
                request.setAttribute("mensajeEliminarUna", "Error al eliminar la notificación individual.");
            }

            // Redirigir de vuelta al formulario de búsqueda
            request.getRequestDispatcher("eliminarNotificacion.jsp").forward(request, response);
        } else if ("eliminarTodas".equals(action)) {
            // Eliminar todas las notificaciones
            boolean exito = eliminarTodasLasNotificaciones(idPropietario);

            if (exito) {
                // Todas las notificaciones eliminadas con éxito, establecer mensaje y redirigir
                request.setAttribute("mensajeEliminarTodas", "Todas las notificaciones eliminadas correctamente.");
            } else {
                // Error al eliminar, establecer mensaje y redirigir
                request.setAttribute("mensajeEliminarTodas", "Error al eliminar todas las notificaciones.");
            }

            // Redirigir de vuelta al formulario de búsqueda
            request.getRequestDispatcher("eliminarNotificacion.jsp").forward(request, response);
        }
    }

    private int obtenerIdUsuarioPorMatricula(String matricula) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "SELECT id_propietario FROM vehiculo WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);

            int idPropietario = -1;

            try (var resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    idPropietario = resultSet.getInt("id_propietario");
                }
            }

            statement.close();
            connection.close();
            return idPropietario;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private List<Notificacion> buscarNotificacionesEnBD(int idUsuario) {
        List<Notificacion> notificaciones = new ArrayList<>();

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar las notificaciones
            String query = "SELECT * FROM notificaciones WHERE id_propietario = ? ORDER BY fecha DESC, hora DESC";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, idUsuario);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Recorrer los resultados y construir los objetos Notificacion
            while (resultSet.next()) {
                int id = resultSet.getInt("id_notificacion");
                int idUsuariox = resultSet.getInt("id_propietario");
                String descripcion = resultSet.getString("descripcion");
                LocalDate fecha = resultSet.getDate("fecha").toLocalDate();
                String hora = resultSet.getString("hora");
                String matricula = resultSet.getString("matricula_vehiculo");
                int tipo = resultSet.getInt("tipo");

                Notificacion notificacion = new Notificacion(idUsuariox, descripcion, fecha, hora, matricula, tipo);
                notificacion.setId(id);
                notificaciones.add(notificacion);
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notificaciones;
    }

    private boolean eliminarNotificacionIndividual(int idNotificacion) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "DELETE FROM notificaciones WHERE id_notificacion = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, idNotificacion);

            int filasEliminadas = statement.executeUpdate();

            statement.close();
            connection.close();

            return filasEliminadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean eliminarTodasLasNotificaciones(int idUsuario) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "DELETE FROM notificaciones WHERE id_propietario = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, idUsuario);

            int filasEliminadas = statement.executeUpdate();

            statement.close();
            connection.close();

            return filasEliminadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
