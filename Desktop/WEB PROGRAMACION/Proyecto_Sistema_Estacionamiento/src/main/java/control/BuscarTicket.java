package control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.Ticket;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BuscarTicket")
public class BuscarTicket extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        String matricula = request.getParameter("matricula");

        // Buscar los tickets según la matrícula
        List<Ticket> tickets = buscarTicketsEnBD(matricula);

        if (!tickets.isEmpty()) {
            // Tickets encontrados, redirigir al formulario de gestión de tickets
            request.setAttribute("ticketsEncontrados", true);
            request.setAttribute("tickets", tickets);
            request.getRequestDispatcher("gestionarTicket.jsp").forward(request, response);
        } else {
            // Tickets no encontrados, mostrar mensaje de error
            request.setAttribute("ticketsEncontrados", false);
            request.getRequestDispatcher("gestionarTicket.jsp").forward(request, response);
        }
    }

    private List<Ticket> buscarTicketsEnBD(String matricula) {
        List<Ticket> tickets = new ArrayList<>();

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar los tickets
            String query = "SELECT * FROM ticket WHERE matricula_vehiculo = ? ORDER BY fecha_emision DESC, hora DESC";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, matricula);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Recorrer los resultados y construir los objetos Ticket
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int cajon = resultSet.getInt("id_espacio_estacionamiento");
                String fecha = resultSet.getString("fecha_emision");
                String hora = resultSet.getString("hora");

                Ticket ticket = new Ticket(id, cajon, matricula, fecha, hora);
                tickets.add(ticket);
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }
}
