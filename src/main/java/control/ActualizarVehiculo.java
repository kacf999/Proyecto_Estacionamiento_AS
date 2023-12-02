package control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.Vehiculo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ActualizarVehiculo")
public class ActualizarVehiculo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        int idPropietario = Integer.parseInt(request.getParameter("id_propietario"));
        String matriculaAnterior = request.getParameter("matriculaAnterior");
        String matricula = request.getParameter("matricula");
        String modelo = request.getParameter("modelo");
        String marca = request.getParameter("marca");
        String color = request.getParameter("color");

        // Crear objeto Vehiculo
        Vehiculo vehiculo = new Vehiculo(idPropietario, modelo, marca, color, matricula);

        // Actualizar el vehículo en la base de datos
        boolean exito = actualizarVehiculoEnBD(matriculaAnterior, vehiculo);

        if (exito) {
            // Redirigir a una página de éxito o mostrar un mensaje
            response.getWriter().println("Actualización exitosa");
        } else {
            // Redirigir a una página de error o mostrar un mensaje
            response.getWriter().println("Actualización con fallos");
        }
    }

    private boolean actualizarVehiculoEnBD(String matriculaAnterior, Vehiculo vehiculo) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Actualizar el vehículo en la base de datos
            String query = "UPDATE vehiculo SET matricula = ?, id_propietario = ?, modelo = ?, marca = ?, color = ? WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, vehiculo.getMatricula());
            statement.setInt(2, vehiculo.getPropietario());
            statement.setString(3, vehiculo.getModelo());
            statement.setString(4, vehiculo.getMarca());
            statement.setString(5, vehiculo.getColor());
            statement.setString(6, matriculaAnterior);

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
