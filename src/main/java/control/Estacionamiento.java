package control;
import modelo.CodigoQR;
import modelo.TiempoTicket;
import modelo.Ticket;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import almacen.ConexionBD;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Estacionamiento")
public class Estacionamiento extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        int id_propietario = Integer.parseInt(request.getParameter("id_propietario"));
        String matricula = request.getParameter("matricula");

        // Verificar si el usuario está registrado
        if (verificarUsuarioRegistrado(id_propietario)) {
            // Verificar si la matrícula está registrada
            if (verificarMatriculaRegistrada(matricula)) {
                // Verificar si el vehículo ya está estacionado
                if (verificarVehiculoEstacionado(matricula)) {
                    // Obtener el espacio en el que está estacionado
                    int espacioEstacionado = obtenerEspacioEstacionado(matricula);

                    response.getWriter().println("Su vehículo ya está estacionado en el espacio " + espacioEstacionado + ".");
                } else {
                    // Buscar espacio libre en el estacionamiento
                    int espacio = buscarEspacioLibre();

                    if (espacio != -1) {
                        // Asignar el espacio al usuario y guardar la matrícula en la base de datos
                        asignarEspacioUsuario(id_propietario, matricula, espacio);

                        

                        // Obtener los datos del ticket
                        //String fechaEmision = obtenerFechaEmisionTicket(matricula);
                        //String horaEmision = obtenerHoraEmisionTicket(matricula);
                        TiempoTicket tiempo = new TiempoTicket();                 
                        String fechaEmision = tiempo.ObtenerFecha();
                        String horaEmision = tiempo.ObtenerHora();
                        
                        String informacion = "Propietario ID: "+id_propietario+
                        				"\nMatricula: "+matricula+
                        				 "\nEspacio Asignado "+espacio+
                        				 "\nFecha: "+fechaEmision+
                        				 "\nHora: "+horaEmision;
                     
                        System.out.println(informacion);
                        CodigoQR codigoQR = new CodigoQR(informacion);
                    	codigoQR.generarQr();
                    	
                    	String ruta = codigoQR.getNombreArchivo();
                        
                    	Ticket ticket = new Ticket(id_propietario, espacio, matricula, fechaEmision, horaEmision, ruta);
                    	
                    	// Generar ticket y guardar en la base de datos
                        generarTicket(espacio, matricula, id_propietario, horaEmision, fechaEmision);

                    	request.setAttribute("ticket", ticket);
                    	request.getRequestDispatcher("MostrarTicket.jsp").forward(request, response);
                    } else {
                        response.getWriter().println("Lo sentimos, no hay espacios disponibles en el estacionamiento.");
                    }
                }
            } else {
                response.getWriter().println("La matrícula del vehículo no está registrada. Por favor, regístrese primero.");
                response.getWriter().println("<a href='registrarVehiculo.jsp'>Registrarse</a>");
            }
        } else {
            response.getWriter().println("El usuario no está registrado. Por favor, regístrese primero.");
            response.getWriter().println("<a href='registrarPropietario.jsp'>Registrarse</a>");
        }
    }

    private boolean verificarUsuarioRegistrado(int id_propietario) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Verificar si el usuario está registrado
            String query = "SELECT * FROM propietario WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id_propietario);
            ResultSet resultSet = statement.executeQuery();

            boolean usuarioRegistrado = resultSet.next();

            resultSet.close();
            statement.close();
            connection.close();

            return usuarioRegistrado;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean verificarMatriculaRegistrada(String matricula) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Verificar si la matrícula está registrada
            String query = "SELECT * FROM vehiculo WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);
            ResultSet resultSet = statement.executeQuery();

            boolean matriculaRegistrada = resultSet.next();

            resultSet.close();
            statement.close();
            connection.close();

            return matriculaRegistrada;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean verificarVehiculoEstacionado(String matricula) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Verificar si el vehículo ya está estacionado
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

    private int obtenerEspacioEstacionado(String matricula) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Obtener el espacio en el que está estacionado el vehículo
            String query = "SELECT numero FROM espacio_estacionamiento WHERE matricula = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);
            ResultSet resultSet = statement.executeQuery();

            int espacioEstacionado = -1;
            if (resultSet.next()) {
                espacioEstacionado = resultSet.getInt("numero");
            }

            resultSet.close();
            statement.close();
            connection.close();

            return espacioEstacionado;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private int buscarEspacioLibre() {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Buscar espacio libre en el estacionamiento
            String query = "SELECT numero FROM espacio_estacionamiento WHERE estado = false ORDER BY numero ASC LIMIT 1";            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            int espacioLibre = -1;
            if (resultSet.next()) {
                espacioLibre = resultSet.getInt("numero");
            }

            resultSet.close();
            statement.close();
            connection.close();

            return espacioLibre;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private void asignarEspacioUsuario(int idUsuario, String matricula, int espacio) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Asignar el espacio al usuario y guardar la matrícula en la base de datos
            String query = "UPDATE espacio_estacionamiento SET estado = true, matricula = ? WHERE numero = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);
            statement.setInt(2, espacio);
            statement.executeUpdate();

            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void generarTicket(int espacio, String matricula, int id_propietario, String hora, String fecha) {
        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();
            
            // Generar ticket y guardar en la base de datos
            String query = "INSERT INTO ticket Values(?,?,?,?,?)";
            
            int id = espacio + id_propietario + Integer.valueOf(hora.substring(3));
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.setInt(2, espacio);
            statement.setString(3, matricula);
            statement.setString(4, hora);
            statement.setString(5, fecha);
            statement.executeQuery();

            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
