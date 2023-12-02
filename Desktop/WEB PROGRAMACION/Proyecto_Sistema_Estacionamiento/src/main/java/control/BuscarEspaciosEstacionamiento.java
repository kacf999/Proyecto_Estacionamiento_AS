package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.EspacioEstacionamiento;
import modelo.Vehiculo; // Asumiendo que tienes una clase Vehiculo en el paquete "modelo"

@WebServlet("/BuscarEspaciosEstacionamiento")
public class BuscarEspaciosEstacionamiento extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la matrícula de la solicitud
        String matricula = request.getParameter("matricula");  // Ajusta esto según cómo obtienes la matrícula desde la solicitud

        // Buscar los espacios de estacionamiento
        List<EspacioEstacionamiento> espacios = buscarEspaciosEstacionamientoEnBD();

        // Buscar los vehículos relacionados con la matrícula
        List<Vehiculo> vehiculos = buscarVehiculosEnBD(matricula);

        if (!espacios.isEmpty()) {
            // Espacios de estacionamiento encontrados, redirigir al formulario de gestión
            request.setAttribute("espaciosEncontrados", true);
            request.setAttribute("espacios", espacios);
        } else {
            // Espacios de estacionamiento no encontrados, mostrar mensaje de error
            request.setAttribute("espaciosEncontrados", false);
        }

        if (!vehiculos.isEmpty()) {
            // Vehículos encontrados, agregarlos como un atributo
            request.setAttribute("vehiculos", vehiculos);
        }

        // Redirigir a la página JSP
        request.getRequestDispatcher("verEspaciosEstacionamiento.jsp").forward(request, response);
    }

    private List<EspacioEstacionamiento> buscarEspaciosEstacionamientoEnBD() {
        List<EspacioEstacionamiento> espacios = new ArrayList<>();

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar los espacios de estacionamiento
            String query = "SELECT * FROM espacio_estacionamiento ORDER BY numero ASC;";
            PreparedStatement statement = connection.prepareStatement(query);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Recorrer los resultados y construir los objetos EspacioEstacionamiento
            while (resultSet.next()) {
                int numero = resultSet.getInt("numero");
                boolean estado = resultSet.getBoolean("estado");
                String matricula = resultSet.getString("matricula");

                EspacioEstacionamiento espacio = new EspacioEstacionamiento(numero, estado, matricula);
                espacios.add(espacio);
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return espacios;
    }

    private List<Vehiculo> buscarVehiculosEnBD(String matricula) {
        List<Vehiculo> vehiculos = new ArrayList<>();

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para obtener los vehículos registrados
            String query = "SELECT v.id_propietario, v.modelo, v.marca, v.color, v.matricula " +
                           "FROM Vehiculo v " +
                           "WHERE v.matricula = ?;";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Recorrer los resultados y construir los objetos Vehiculo
            while (resultSet.next()) {
                int propietario = resultSet.getInt("id_propietario");
                String modelo = resultSet.getString("modelo");
                String marca = resultSet.getString("marca");
                String color = resultSet.getString("color");
                String matriculaResult = resultSet.getString("matricula");

                Vehiculo vehiculo = new Vehiculo(propietario, modelo, marca, color, matriculaResult);
                vehiculos.add(vehiculo);
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehiculos;
    }
}
