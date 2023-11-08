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

@WebServlet("/BuscarPropietario")
public class BuscarPropietario extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario 
        int id = Integer.parseInt(request.getParameter("id"));
        String matricula = request.getParameter("matricula");
 
        // Buscar el propietario según el ID o la matrícula (si es estudiante)
        Propietario propietario = buscarPropietarioEnBD(id, matricula);

        if (propietario != null) {
            // Propietario encontrado, redirigir al formulario de actualización
            request.setAttribute("propietarioEncontrado", true);
            request.setAttribute("propietario", propietario);
            request.getRequestDispatcher("buscarPropietario.jsp").forward(request, response);
        } else {
            // Propietario no encontrado, mostrar mensaje de error
            request.setAttribute("propietarioEncontrado", false);
            request.getRequestDispatcher("buscarPropietario.jsp").forward(request, response);
        }
    }

    private Propietario buscarPropietarioEnBD(int id, String matricula) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar el propietario
            String query = "SELECT * FROM propietario WHERE id = ? OR (estudiante = true AND matricula = ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.setString(2, matricula);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Verificar si se encontró el propietario
            if (resultSet.next()) {
                // Construir el objeto Propietario con los datos obtenidos de la base de datos
                int propietarioId = resultSet.getInt("id");
                String nombre = resultSet.getString("nombre");
                String numeroTelefono = resultSet.getString("numero_telefono");
                String propietarioMatricula = resultSet.getString("matricula");
                boolean estudiante = resultSet.getBoolean("estudiante");
                String calle = resultSet.getString("calle");
                String colonia = resultSet.getString("colonia");
                String delegacion = resultSet.getString("delegacion");
                int numero = resultSet.getInt("numero");
                int cp = resultSet.getInt("cp");

                Propietario propietario = new Propietario(nombre, numeroTelefono, propietarioMatricula, estudiante,
                        new Direccion(calle, colonia, delegacion, numero, cp));
                propietario.setId(propietarioId);

                // Cerrar recursos
                resultSet.close();
                statement.close();
                connection.close();

                return propietario;
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Propietario no encontrado
    }
}
