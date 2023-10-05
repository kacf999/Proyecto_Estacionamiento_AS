package control;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class AlmacenarEstudiante
 */
@WebServlet(name = "login ", urlPatterns = { "/login" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession sesion = request.getSession();
		String usuario, contrasena;
		usuario = request.getParameter("usuario");
		contrasena = request.getParameter("contrasena");

		if (usuario.equals("admin") && contrasena.equals("admin") && sesion.getAttribute("usuario") == null) {
			sesion.setAttribute("usuario", usuario);
			response.sendRedirect("loginExito.jsp");
			request.setAttribute("error", null);

		} else {
			request.setAttribute("error", "Usuario y contraseña no reconocidos, por favor, inténtalo de nuevo.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
