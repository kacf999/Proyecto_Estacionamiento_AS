package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.Direccion;
import modelo.Propietario;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/RegistrarPropietario")
public class RegistrarPropietario extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        String nombre = request.getParameter("nombre");
        String numeroTelefono = request.getParameter("numeroTelefono");
        String matricula = request.getParameter("matricula");
        boolean estudiante = request.getParameter("estudiante") != null;
        String calle = request.getParameter("calle");
        String colonia = request.getParameter("colonia");
        String delegacion = request.getParameter("delegacion");
        int numero = Integer.parseInt(request.getParameter("numero"));
        int cp = Integer.parseInt(request.getParameter("cp"));

        // Crear objeto Direccion
        Direccion direccion = new Direccion(calle, colonia, delegacion, numero, cp);

        // Crear objeto Propietario
        Propietario propietario = new Propietario(nombre, numeroTelefono, matricula, estudiante, direccion);

        // Guardar el propietario en la base de datos
        boolean exito = guardarPropietarioEnBD(propietario);

        if (exito) {
            // Obtener el ID del nuevo registro
            int idPropietario = obtenerIdPropietario(propietario);

            // Crear una respuesta HTML con el mensaje de éxito y el botón de regresar
            String responseHTML = "<html><body>";
            responseHTML += "<p>Registro exitoso. ID del propietario: " + idPropietario + "</p>";            
            responseHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"estilo.css\">";     
            responseHTML += "<button onclick=\"window.location.href='menuPrincipal.jsp'\">Regresar al Menú Principal</button>";
            responseHTML += "</body></html>";

            // Establecer el tipo de contenido de la respuesta como HTML
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");

            // Enviar la respuesta HTML al navegador
            response.getWriter().write(responseHTML);        
            } else {
                // Crear una respuesta HTML con el mensaje de error y el botón de regresar
                String responseHTML = "<html><body>";
                responseHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"estilo.css\">";     
                responseHTML += "<p>Registro con fallos</p>";
                responseHTML += "<button onclick=\"window.location.href='menuPrincipal.jsp'\">Regresar al Menú Principal</button>";
                responseHTML += "</body></html>";

                // Establecer el tipo de contenido de la respuesta como HTML
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");

                // Enviar la respuesta HTML al navegador
                response.getWriter().write(responseHTML);        }
    }

    private boolean guardarPropietarioEnBD(Propietario propietario) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Insertar el propietario en la base de datos
            String query = "INSERT INTO propietario (nombre, numero_telefono, matricula, estudiante, calle, colonia, delegacion, numero, cp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, propietario.getNombre());
            statement.setString(2, propietario.getNumeroTelefono());
            statement.setString(3, propietario.getMatricula());
            statement.setBoolean(4, propietario.isEstudiante());
            statement.setString(5, propietario.getDireccion().getCalle());
            statement.setString(6, propietario.getDireccion().getColonia());
            statement.setString(7, propietario.getDireccion().getDelegacion());
            statement.setInt(8, propietario.getDireccion().getNumero());
            statement.setInt(9, propietario.getDireccion().getCp());

            int filasInsertadas = statement.executeUpdate();
            statement.close();
            connection.close();

            return filasInsertadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private int obtenerIdPropietario(Propietario propietario) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Consultar el ID del propietario insertado
            String query = "SELECT id FROM propietario WHERE matricula = ? or (nombre = ? AND numero_telefono = ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, propietario.getMatricula());
            statement.setString(2, propietario.getNombre());
            statement.setString(3, propietario.getNumeroTelefono());

            ResultSet resultSet = statement.executeQuery();
            int idPropietario = -1;
            if (resultSet.next()) {
                idPropietario = resultSet.getInt("id");
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
}
