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

import modelo.Vehiculo;
import almacen.ConexionBD;

@WebServlet("/RegistrarVehiculo")
public class RegistrarVehiculo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int propietario = Integer.parseInt(request.getParameter("propietario"));
        String modelo = request.getParameter("modelo");
        String marca = request.getParameter("marca");
        String color = request.getParameter("color");
        String matricula = request.getParameter("matricula");
        
        // Validar y procesar los datos recibidos
        if (propietario > 0 && modelo != null && !modelo.isEmpty()
                && marca != null && !marca.isEmpty() && color != null && !color.isEmpty()
                && matricula != null && !matricula.isEmpty()) {
            // Verificar si el propietario ya tiene 3 vehículos registrados
            if (verificarLimiteVehiculos(propietario)) {
                response.getWriter().println("El propietario ya tiene 3 vehículos registrados. No se puede agregar más.");
                return;
            }
        }
        
        // Validar y procesar los datos recibidos
        if (propietario > 0 && modelo != null && !modelo.isEmpty()
                && marca != null && !marca.isEmpty() && color != null && !color.isEmpty()
                && matricula != null && !matricula.isEmpty()) {
            // Crear una instancia del vehículo con los datos recibidos
            Vehiculo vehiculo = new Vehiculo(propietario, modelo, marca, color, matricula);

            // Guardar el vehículo en la base de datos
            boolean exito = guardarVehiculoEnBD(vehiculo);

            if (exito) {
                response.getWriter().println("Registro exitoso");
            } else {
                response.getWriter().println("Error al registrar el vehículo");
            }
        } else {
            response.getWriter().println("Todos los campos son requeridos");
        }
    }
    
    private boolean verificarLimiteVehiculos(int propietario) {
    	
        try {
            // Establecer la conexión con la base de datos
        	Connection connection = ConexionBD.obtenerConexion();

            // Consultar el número de vehículos registrados del propietario
            String query = "SELECT COUNT(*) FROM vehiculo WHERE id_propietario = ? and matricula != 'VEHICULO_ELIMINADO'";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, propietario);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                int cantidadVehiculos = resultSet.getInt(1);
                if (cantidadVehiculos >= 3) {
                    resultSet.close();
                    statement.close();
                    connection.close();
                    return true; // El propietario ya tiene 3 vehículos registrados
                }
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private boolean guardarVehiculoEnBD(Vehiculo vehiculo) {

        try {
            // Establecer la conexión con la base de datos
        	Connection connection = ConexionBD.obtenerConexion();

            // Insertar el vehículo en la base de datos
            String query = "INSERT INTO vehiculo (id_propietario, modelo, marca, color, matricula, estacionado) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, vehiculo.getPropietario());
            statement.setString(2, vehiculo.getModelo());
            statement.setString(3, vehiculo.getMarca());
            statement.setString(4, vehiculo.getColor());
            statement.setString(5, vehiculo.getMatricula());
            statement.setBoolean(6, false);

            int filasInsertadas = statement.executeUpdate();
            statement.close();
            connection.close();

            return filasInsertadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
