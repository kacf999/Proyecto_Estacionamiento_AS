package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.binary.Base64; 

import almacen.ConexionBD;
import modelo.Camara;

@WebServlet(name = "VerImagenes", urlPatterns = { "/VerImagenes" })
public class VerImagenes extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public VerImagenes() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Camara> imagenes = new ArrayList<>();
        ArrayList<String> imagenesBase64 = new ArrayList<>(); // Lista de representaciones Base64 de imágenes

        try {
            Connection connection = ConexionBD.obtenerConexion();
            if (connection != null) {
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    statement = connection.createStatement();
                    resultSet = statement.executeQuery("SELECT * FROM fotos");
                    int contador = 0;
                    while (resultSet.next()) {
                    	int id = resultSet.getInt("id");
                        Date fecha = resultSet.getDate("fecha");
                        String matricula = resultSet.getString("matricula");
                        byte[] foto = resultSet.getBytes("foto");

                        Camara imagen = new Camara(id, fecha, matricula, foto);

                        if (foto != null && foto.length > 0) {
                            String imagenBase64 = new String(Base64.encodeBase64(foto));
                            imagenesBase64.add(imagenBase64); // Agrega la representación Base64 a la lista
                        }

                        imagenes.add(imagen);
                        contador++;
                        System.out.println("van : " + contador + " | " + fecha);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (resultSet != null) {
                        try {
                            resultSet.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (statement != null) {
                        try {
                            statement.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (connection != null) {
                        try {
                            connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } else {
                System.out.println("Error en BD");
            }

            // Configurar la lista completa en la solicitud
            request.setAttribute("imagenes", imagenes);
            request.setAttribute("imagenesBase64", imagenesBase64); // Agrega la lista Base64 a la solicitud

            request.getRequestDispatcher("verImagenes.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
