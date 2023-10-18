package control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

        // Verificar si el propietario ya existe en la base de datos
        boolean existePropietario = verificarExistenciaPropietario(nombre, numeroTelefono, matricula);

        if (existePropietario) {
            // Propietario ya existe, mostrar mensaje de error
            String responseHTML = "<html><body>";
            responseHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"estilo.css\">";
            responseHTML += "<p>El propietario ya está registrado en la base de datos.</p>";
            responseHTML += "<button onclick=\"window.location.href='menuPrincipal.jsp'\">Regresar al Menú Principal</button>";
            responseHTML += "</body></html>";

            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(responseHTML);
        } else {
            // El propietario no existe, proceder con el registro
            // Generar la contraseña
            String contraseña = generarContraseña(nombre, numeroTelefono, matricula);

            // Crear objeto Propietario
            Propietario propietario = new Propietario(nombre, numeroTelefono, matricula, estudiante, direccion);
            propietario.setContraseña(contraseña);

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

                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(responseHTML);
            } else {
                // Crear una respuesta HTML con el mensaje de error y el botón de regresar
                String responseHTML = "<html><body>";
                responseHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"estilo.css\">";
                responseHTML += "<p>Registro con fallos</p>";
                responseHTML += "<button onclick=\"window.location.href='menuPrincipal.jsp'\">Regresar al Menú Principal</button>";
                responseHTML += "</body></html>";

                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(responseHTML);
            }
        }
    }

    private boolean verificarExistenciaPropietario(String nombre, String numeroTelefono, String matricula) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "SELECT id FROM propietario WHERE nombre = ? OR numero_telefono = ? OR matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, nombre);
            statement.setString(2, numeroTelefono);
            statement.setString(3, matricula);

            ResultSet resultSet = statement.executeQuery();
            boolean existe = resultSet.next();

            resultSet.close();
            statement.close();
            connection.close();

            return existe;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String generarContraseña(String nombre, String numeroTelefono, String matricula) {
        // Obtener las dos primeras letras del nombre
        String nombreAbreviado = nombre.substring(0, 4).toUpperCase();

        // Obtener las dos primeras letras del apellido (en este caso, usamos "XX" como marcador)
        String apellidoAbreviado = "UACM";

        // Obtener los últimos cuatro dígitos del número de teléfono o matrícula
        String ultimosDigitos = "";
        if (numeroTelefono != null && numeroTelefono.length() >= 4) {
            ultimosDigitos = numeroTelefono.substring(numeroTelefono.length() - 4);
        } else if (matricula != null && matricula.length() >= 4) {
            ultimosDigitos = matricula.substring(matricula.length() - 4);
        }

        // Combinar las partes para formar la contraseña
        return nombreAbreviado + apellidoAbreviado + ultimosDigitos;
    }

    private boolean guardarPropietarioEnBD(Propietario propietario) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "INSERT INTO propietario (nombre, numero_telefono, matricula, estudiante, calle, colonia, delegacion, numero, cp, contraseña) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            statement.setString(10, propietario.getContraseña());

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
            Connection connection = ConexionBD.obtenerConexion();

            String query = "SELECT id FROM propietario WHERE matricula = ? OR (nombre = ? AND numero_telefono = ?)";
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
