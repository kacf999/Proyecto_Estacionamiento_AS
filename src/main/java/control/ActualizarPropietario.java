package control;


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
import java.sql.SQLException;

@WebServlet("/ActualizarPropietario")
public class ActualizarPropietario extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Obtener los datos del formulario
        int id = Integer.parseInt(request.getParameter("id"));
        String matricula = request.getParameter("matricula");
        boolean estudiante = request.getParameter("estudiante") != null;
        String nombre = request.getParameter("nombre");
        String numeroTelefono = request.getParameter("numeroTelefono");
        String calle = request.getParameter("calle");
        String colonia = request.getParameter("colonia");
        String delegacion = request.getParameter("delegacion");
        int numero = Integer.parseInt(request.getParameter("numero"));
        int cp = Integer.parseInt(request.getParameter("cp"));

        // Crear objeto Direccion
        Direccion direccion = new Direccion(calle, colonia, delegacion, numero, cp);

        // Crear objeto Propietario
        Propietario propietario = new Propietario(nombre, numeroTelefono, matricula, estudiante, direccion);

        // Actualizar el propietario en la base de datos
        boolean exito = actualizarPropietarioEnBD(id, propietario);

        if (exito) {
            // Redirigir a una página de éxito o mostrar un mensaje
            response.getWriter().println("Actualización exitosa");
        } else {
            // Redirigir a una página de error o mostrar un mensaje
            response.getWriter().println("Actualización con fallos");
        }
    }

    private boolean actualizarPropietarioEnBD(int id, Propietario propietario) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Actualizar el propietario en la base de datos
            String query = "UPDATE propietario SET nombre = ?, numero_telefono = ?, matricula = ?, estudiante = ?, calle = ?, colonia = ?, delegacion = ?, numero = ?, cp = ? WHERE id = ?";
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
            statement.setInt(10, id);

            int filasActualizadas = statement.executeUpdate();
            statement.close();
            connection.close();

            return filasActualizadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
