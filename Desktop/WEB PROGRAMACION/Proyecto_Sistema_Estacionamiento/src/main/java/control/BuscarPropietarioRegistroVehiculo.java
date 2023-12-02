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
import modelo.Propietario;

@WebServlet("/BuscarPropietarioRegistroVehiculo")
public class BuscarPropietarioRegistroVehiculo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el identificador de búsqueda (ID)
        int identificador = Integer.parseInt(request.getParameter("identificador"));

        // Buscar el propietario según el ID
        Propietario propietarioEncontrado = buscarPropietarioEnBD(identificador);

        // Enviar el propietario encontrado a la vista
        request.setAttribute("propietarioEncontrado", propietarioEncontrado);

        // Redirigir a la página JSP
        request.getRequestDispatcher("registrarVehiculo.jsp").forward(request, response);
    }

    private Propietario buscarPropietarioEnBD(int identificador) {
        Propietario propietario = null;

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Modificar la consulta SQL para buscar por ID
            String query = "SELECT * FROM propietario WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, identificador);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Si se encuentra el propietario, construir un objeto Propietario
            if (resultSet.next()) {
                int propietarioId = resultSet.getInt("id");
                String nombre = resultSet.getString("nombre");

                propietario = new Propietario(nombre, null, null, false, null);
                propietario.setId(propietarioId);
                propietario.setNombre(nombre);
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return propietario;
    }
}
