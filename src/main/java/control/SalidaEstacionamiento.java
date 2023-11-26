package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.EspacioEstacionamiento;
import modelo.Ticket;
import almacen.ConexionBD;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SalidaEstacionamiento")
public class SalidaEstacionamiento extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del propietario
        int identificacion = Integer.parseInt(request.getParameter("id"));

        // Obtener la lista de vehículos asociados al propietario
        List<String> vehiculos = obtenerVehiculosPropietario(identificacion);

        // Pasar la lista de vehículos a la página JSP
        request.setAttribute("vehiculos", vehiculos);
        request.getRequestDispatcher("seleccionarVehiculo.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del propietario
        int identificacion = Integer.parseInt(request.getParameter("id"));

        // Obtener la matrícula del vehículo seleccionado
        String matricula = request.getParameter("matricula");

        // Verificar si el propietario está registrado
        if (verificarPropietarioRegistrado(identificacion)) {
            // Verificar si el vehículo está estacionado
            if (verificarVehiculoEstacionado(matricula)) {
                // Obtener el espacio en el que está estacionado
                int espacioEstacionado = obtenerEspacioEstacionamiento(matricula);

                // Liberar el espacio de estacionamiento
                liberarEspacioEstacionamiento(espacioEstacionado);
                
                Ticket ticket = buscarTicketEnBD(matricula);
                System.out.println(matricula);

                // Mostrar mensaje de agradecimiento y espacio liberado
                request.setAttribute("ticket", ticket);
            	request.getRequestDispatcher("EspacioLiberado.jsp").forward(request, response);
            } else {
                response.getWriter().println("El vehículo no está estacionado en el estacionamiento.");
            }
        } else {
            response.getWriter().println("El propietario no está registrado. Por favor, regístrese primero.");
            response.getWriter().println("<a href='registrarPropietario.jsp'>Registrarse</a>");
        }
    }

    private boolean verificarPropietarioRegistrado(int id) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Verificar si el propietario está registrado
            String query = "SELECT * FROM propietario WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            boolean propietarioRegistrado = resultSet.next();

            resultSet.close();
            statement.close();
            connection.close();

            return propietarioRegistrado;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean verificarVehiculoEstacionado(String matricula) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Verificar si el vehículo está estacionado
            String query = "SELECT * FROM espacio_estacionamiento WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);
            ResultSet resultSet = statement.executeQuery();

            boolean vehiculoEstacionado = resultSet.next();

            resultSet.close();
            statement.close();
            connection.close();

            return vehiculoEstacionado;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private int obtenerEspacioEstacionamiento(String matricula) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Obtener el espacio en el que está estacionado el vehículo
            String query = "SELECT numero FROM espacio_estacionamiento WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);
            ResultSet resultSet = statement.executeQuery();

            int espacioEstacionamiento = -1;
            if (resultSet.next()) {
                espacioEstacionamiento = resultSet.getInt("numero");
            }

            resultSet.close();
            statement.close();
            connection.close();

            return espacioEstacionamiento;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private void liberarEspacioEstacionamiento(int espacioEstacionamiento) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Liberar el espacio de estacionamiento
            String query = "UPDATE espacio_estacionamiento SET estado = false, matricula = NULL WHERE numero = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, espacioEstacionamiento);
            statement.executeUpdate();

            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private List<String> obtenerVehiculosPropietario(int identificacion) {
        List<String> vehiculos = new ArrayList<>();

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Obtener los vehículos asociados al propietario
            String query = "SELECT matricula FROM vehiculo WHERE id_propietario = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, identificacion);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String matricula = resultSet.getString("matricula");
                vehiculos.add(matricula);
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehiculos;
    }
    
    private Ticket buscarTicketEnBD(String matriculaVehiculo) {
    	Ticket ticket = new Ticket();
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar los tickets
            String query = "SELECT * FROM ticket WHERE matricula_vehiculo = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matriculaVehiculo);      

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
            	// Recorrer los resultados y construir los objetos Ticket
                int id = resultSet.getInt("id");
                int cajon = resultSet.getInt("id_espacio_estacionamiento");
                String matricula = resultSet.getString("matricula_vehiculo");     
                String hora = resultSet.getString("hora");
                String fecha = resultSet.getString("fecha");

                ticket.setId(id);
                ticket.setCajon(cajon);
                ticket.setMatriculaVehiculo(matricula);
                ticket.setHora(hora);
                ticket.setFecha(fecha);
            }

            resultSet.close();
            statement.close();
            connection.close();
            return ticket;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
         return ticket;
        }
}
