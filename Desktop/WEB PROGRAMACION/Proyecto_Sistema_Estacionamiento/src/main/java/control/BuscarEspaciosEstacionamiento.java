package control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.EspacioEstacionamiento;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BuscarEspaciosEstacionamiento")
public class BuscarEspaciosEstacionamiento extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Buscar los tickets según la matrícula
        List<EspacioEstacionamiento> espacios = buscarEspaciosEstacionamientoEnBD();

        if (!espacios.isEmpty()) {
            // Tickets encontrados, redirigir al formulario de gestión de tickets
            request.setAttribute("espaciosEncontrados", true);
            request.setAttribute("espacios", espacios);
            request.getRequestDispatcher("verEspaciosEstacionamiento.jsp").forward(request, response);
        } else {
            // Tickets no encontrados, mostrar mensaje de error
            request.setAttribute("espaciosEncontrados", false);
            request.getRequestDispatcher("verEspaciosEstacionamiento.jsp").forward(request, response);
        }
    }

    private List<EspacioEstacionamiento> buscarEspaciosEstacionamientoEnBD() {
        List<EspacioEstacionamiento> espacios = new ArrayList<>();

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar los tickets
            String query = "SELECT * FROM espacio_estacionamiento ORDER BY numero ASC;";
            PreparedStatement statement = connection.prepareStatement(query);

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Recorrer los resultados y construir los objetos Ticket
            while (resultSet.next()) {
                int numero = resultSet.getInt("numero");
                boolean estado = resultSet.getBoolean("estado");
                String matricula = resultSet.getString("matricula");
                if(matricula != null)
                System.out.println("Estado del espacio de estacionamiento " + numero + ": " + estado + ". Matrícula del coche que lo ocupa: " + matricula);
                else System.out.println("Estado del espacio de estacionamiento " + numero + ": " + estado);
                EspacioEstacionamiento EspacioEstacionamiento = new EspacioEstacionamiento(numero, estado, matricula);
                espacios.add(EspacioEstacionamiento);
                
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
}
