package control;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import almacen.ConexionBD;

@WebServlet("/EliminarPropietario")
public class EliminarPropietario extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los datos del formulario
        String id = request.getParameter("id");
        String matricula = request.getParameter("matricula");

        // Verificar si se proporcionó un ID o una matrícula
        if (id != null && !id.isEmpty()) {
            // Eliminar por ID
            eliminarPropietarioPorId(id, response);
        } else if (matricula != null && !matricula.isEmpty()) {
            // Eliminar por matrícula si es estudiante
            eliminarPropietarioPorMatricula(matricula, response);
        } else {
            // Mostrar alerta si no se proporcionó ID ni matrícula
            response.getWriter().println("Por favor, proporcione un ID o una matrícula");
        }
    }

    private void eliminarPropietarioPorId(String id, HttpServletResponse response) throws IOException {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();
            connection.setAutoCommit(false); // Desactivar el modo de autocommit

            // Verificar si existe un propietario con el ID proporcionado
            String verificacionQuery = "SELECT id FROM propietario WHERE id = ?";
            PreparedStatement verificacionStatement = connection.prepareStatement(verificacionQuery);
            verificacionStatement.setInt(1, Integer.parseInt(id));
            ResultSet resultSet = verificacionStatement.executeQuery();

            if (resultSet.next()) {
                // Obtener el ID del propietario
                int propietarioId = resultSet.getInt("id");

                // Verificar si hay vehículos relacionados con el propietario
                String vehiculoQuery = "SELECT id_propietario FROM vehiculo WHERE id_propietario = ?";
                PreparedStatement vehiculoStatement = connection.prepareStatement(vehiculoQuery);
                vehiculoStatement.setInt(1, propietarioId);
                ResultSet vehiculoResultSet = vehiculoStatement.executeQuery();

                if (vehiculoResultSet.next()) {
                    // Eliminar los vehículos relacionados con el propietario
                    String eliminarVehiculoQuery = "DELETE FROM vehiculo WHERE id_propietario = ?";
                    PreparedStatement eliminarVehiculoStatement = connection.prepareStatement(eliminarVehiculoQuery);
                    eliminarVehiculoStatement.setInt(1, propietarioId);
                    eliminarVehiculoStatement.executeUpdate();
                    eliminarVehiculoStatement.close();
                }

                // Eliminar el propietario por ID
                String eliminarPropietarioQuery = "DELETE FROM propietario WHERE id = ?";
                PreparedStatement eliminarPropietarioStatement = connection.prepareStatement(eliminarPropietarioQuery);
                eliminarPropietarioStatement.setInt(1, propietarioId);
                eliminarPropietarioStatement.executeUpdate();
                eliminarPropietarioStatement.close();

                // Crear una respuesta HTML con el mensaje de éxito y el botón de regresar
                String responseHTML = "<html><body>";
                responseHTML += "<p>Propietario y vehículos relacionados eliminados exitosamente</p>";            
                responseHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"estilo.css\">";     
                responseHTML += "<button onclick=\"window.location.href='menuPrincipal.jsp'\">Regresar al Menú Principal</button>";
                responseHTML += "</body></html>";

                // Establecer el tipo de contenido de la respuesta como HTML
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");

                // Enviar la respuesta HTML al navegador
                response.getWriter().write(responseHTML);        

                vehiculoResultSet.close();
                vehiculoStatement.close();
            } else {
                // Mostrar alerta si no se encuentra el propietario con el ID proporcionado
                // Crear una respuesta HTML con el mensaje de éxito y el botón de regresar
                String responseHTML = "<html><body>";
                responseHTML += "<p>No se encontró al propietario.</p>";            
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

    private void eliminarPropietarioPorMatricula(String matricula, HttpServletResponse response) throws IOException {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();
            connection.setAutoCommit(false); // Desactivar el modo de autocommit

            // Verificar si existe un propietario con la matrícula proporcionada si es estudiante
            String verificacionQuery = "SELECT id FROM propietario WHERE matricula = ? AND estudiante = true";
            PreparedStatement verificacionStatement = connection.prepareStatement(verificacionQuery);
            verificacionStatement.setString(1, matricula);
            ResultSet resultSet = verificacionStatement.executeQuery();

            if (resultSet.next()) {
                // Obtener el ID del propietario
                int propietarioId = resultSet.getInt("id");

                // Verificar si hay vehículos relacionados con el propietario
                String vehiculoQuery = "SELECT id_propietario FROM vehiculo WHERE id_propietario = ?";
                PreparedStatement vehiculoStatement = connection.prepareStatement(vehiculoQuery);
                vehiculoStatement.setInt(1, propietarioId);
                ResultSet vehiculoResultSet = vehiculoStatement.executeQuery();

                if (vehiculoResultSet.next()) {
                    // Eliminar los vehículos relacionados con el propietario
                    String eliminarVehiculoQuery = "DELETE FROM vehiculo WHERE id_propietario = ?";
                    PreparedStatement eliminarVehiculoStatement = connection.prepareStatement(eliminarVehiculoQuery);
                    eliminarVehiculoStatement.setInt(1, propietarioId);
                    eliminarVehiculoStatement.executeUpdate();
                    eliminarVehiculoStatement.close();
                }

                // Eliminar el propietario por matrícula si es estudiante
                String eliminarPropietarioQuery = "DELETE FROM propietario WHERE matricula = ? AND estudiante = true";
                PreparedStatement eliminarPropietarioStatement = connection.prepareStatement(eliminarPropietarioQuery);
                eliminarPropietarioStatement.setString(1, matricula);
                eliminarPropietarioStatement.executeUpdate();
                eliminarPropietarioStatement.close();

                response.getWriter().println("Propietario y vehículos relacionados eliminados exitosamente");

                vehiculoResultSet.close();
                vehiculoStatement.close();
            } else {
                // Mostrar alerta si no se encuentra el propietario con la matrícula especificada
                response.getWriter().println("No se encontró ningún propietario con la matrícula especificada");
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