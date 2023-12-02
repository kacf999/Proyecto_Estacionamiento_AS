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
import modelo.Vehiculo;

@WebServlet("/BuscarVehiculo")
public class BuscarVehiculo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        String matricula = request.getParameter("matricula");

        // Buscar el propietario según el ID o la matrícula (si es estudiante)
        Vehiculo vehiculo = buscarVehiculoEnBD(matricula);

        if (vehiculo != null) {
            // Propietario encontrado, redirigir al formulario de actualización
            request.setAttribute("vehiculoEncontrado", true);
            request.setAttribute("vehiculo", vehiculo);
            request.getRequestDispatcher("buscarVehiculo.jsp").forward(request, response);
        } else {
            // Propietario no encontrado, mostrar mensaje de error
            request.setAttribute("vehiculoEncontrado", false);
            request.getRequestDispatcher("buscarVehiculo.jsp").forward(request, response);
        }
    }

    private Vehiculo buscarVehiculoEnBD(String matricula) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar el propietario
            String query = "SELECT * FROM vehiculo WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Verificar si se encontró el propietario
            if (resultSet.next()) {
                // Construir el objeto Propietario con los datos obtenidos de la base de datos
                String matriculaVehiculo = resultSet.getString("matricula");
                int idPropietario = resultSet.getInt("id_propietario");
                String modelo = resultSet.getString("modelo");
                String marca = resultSet.getString("marca");
                String color = resultSet.getString("color");
                Vehiculo vehiculo = new Vehiculo(idPropietario, modelo, marca, color, matriculaVehiculo);

                // Cerrar recursos
                resultSet.close();
                statement.close();
                connection.close();

                return vehiculo;
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
