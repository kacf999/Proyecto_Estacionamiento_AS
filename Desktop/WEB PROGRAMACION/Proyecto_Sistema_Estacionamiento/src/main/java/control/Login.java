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
import javax.servlet.http.HttpSession;

import almacen.ConexionBD;

@WebServlet(name = "login", urlPatterns = { "/login" })
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String usuario, contrasena;
        usuario = request.getParameter("usuario");
        contrasena = request.getParameter("contrasena");

        // Verificar si el usuario y contraseña coinciden con el usuario por defecto
        if (usuario.equals("admin") && contrasena.equals("admin")) {
            // Establecer la sesión y redirigir a la página de inicio
            session.setAttribute("usuario", usuario);
            response.sendRedirect("menuPrincipal.jsp");
        } else {
            // Intentar verificar el usuario y contraseña en la base de datos
            if (verificarUsuarioBD(usuario, contrasena, session)) {
                // Si se encuentra en la base de datos, establecer la sesión y redirigir a la página de inicio
                session.setAttribute("usuario2", usuario);
                response.sendRedirect("menuPrincipal.jsp");
            } else {
                // Usuario y contraseña no reconocidos
                request.setAttribute("error", "Usuario y contraseña no reconocidos, por favor, inténtalo de nuevo.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }

    private boolean verificarUsuarioBD(String usuario, String contrasena, HttpSession session) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Obtener una conexión a la base de datos
            connection = ConexionBD.obtenerConexion();

            // Verificar si el usuario y contraseña existen en la tabla propietario
            String query = "SELECT id, nombre FROM propietario WHERE (matricula = ? OR numero_telefono = ?) AND contraseña = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, usuario);
            statement.setString(2, usuario);
            statement.setString(3, contrasena);

            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Usuario y contraseña válidos
                int propietarioId = resultSet.getInt("id");
                String nombrePropietario = resultSet.getString("nombre");
                session.setAttribute("propietarioId", propietarioId);
                session.setAttribute("nombrePropietario", nombrePropietario);

                // Configurar la sesión para que expire después de 2 horas de inactividad (en segundos)
                session.setMaxInactiveInterval(2 * 60 * 60);

                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }
}
