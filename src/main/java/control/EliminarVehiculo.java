package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;

@WebServlet("/EliminarVehiculo")
public class EliminarVehiculo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los datos del formulario
        String matricula = request.getParameter("matricula");

        // Verificar si se proporcionó una matrícula
        if (matricula != null && !matricula.isEmpty()) {
            // Eliminar por matrícula si es estudiante
            eliminarVehiculo(matricula, response);
        } else {
            // Mostrar alerta si no se proporcionó matrícula
            response.getWriter().println("Por favor, proporcione una matrícula");
        }
    }

    private void eliminarVehiculo(String matricula, HttpServletResponse response) throws IOException {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();
            connection.setAutoCommit(false); // Desactivar el modo de autocommit
            System.out.println("Matrícula: " + matricula);

            // Verificar si el vehículo existe
            String verificacionQuery = "SELECT id_propietario FROM vehiculo WHERE matricula = ?";
            PreparedStatement verificacionStatement = connection.prepareStatement(verificacionQuery);
            verificacionStatement.setString(1, matricula);
            ResultSet resultSet = verificacionStatement.executeQuery();

            if (resultSet.next()) {
                // Actualizar el espacio de estacionamiento
                String actualizarEspacioQuery = "UPDATE espacio_estacionamiento SET estado = false, matricula = NULL WHERE matricula = ?";
                PreparedStatement actualizarEspacioStatement = connection.prepareStatement(actualizarEspacioQuery);
                actualizarEspacioStatement.setString(1, matricula);
                actualizarEspacioStatement.executeUpdate();
                actualizarEspacioStatement.close();

                // Actualizar la matrícula del vehículo a un valor especial
                String actualizarMatriculaQuery = "UPDATE vehiculo SET matricula = 'VEHICULO_ELIMINADO' WHERE matricula = ?";
                PreparedStatement actualizarMatriculaStatement = connection.prepareStatement(actualizarMatriculaQuery);
                actualizarMatriculaStatement.setString(1, matricula);
                actualizarMatriculaStatement.executeUpdate();
                actualizarMatriculaStatement.close();

                // Crear una respuesta HTML con el mensaje de éxito y el botón de regresar
                String responseHTML = "<html><body>";
                responseHTML += "<p>Vehículo eliminado exitosamente</p>";
                responseHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"estilo.css\">";
                responseHTML += "<button onclick=\"window.location.href='menuPrincipal.jsp'\">Regresar al Menú Principal</button>";
                responseHTML += "</body></html>";

                // Establecer el tipo de contenido de la respuesta como HTML
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");

                // Enviar la respuesta HTML al navegador
                response.getWriter().write(responseHTML);
            } else {
                // Mostrar alerta si no se encuentra el vehículo con la matrícula especificada
                // Crear una respuesta HTML con el mensaje de éxito y el botón de regresar
                String responseHTML = "<html><body>";
                responseHTML += "<p>No se encontró el vehículo indicado</p>";
                responseHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"estilo.css\">";
                responseHTML += "<button onclick=\"window.location.href='menuPrincipal.jsp'\">Regresar al Menú Principal</button>";
                responseHTML += "</body></html>";

                // Establecer el tipo de contenido de la respuesta como HTML
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");

                // Enviar la respuesta HTML al navegador
                response.getWriter().write(responseHTML);
            }

            resultSet.close();
            verificacionStatement.close();

            // Confirmar los cambios en la base de datos
            connection.commit();
            connection.setAutoCommit(true);
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
