<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="estilo.css" type="text/css" rel="stylesheet" />
<title>Menú de inicio (login)</title>
</head>
<body>
	<%
	HttpSession sesion = request.getSession();

	if (sesion.getAttribute("usuario") != null) {
		String url = "login.jsp";
		response.sendRedirect(url);
	}
	%>

	<b></b>
	<div class="login">
		<h1>¡Bienvenido, ${sessionScope.usuario}!</h1>
		<form action="index.jsp" method="post">
			<button type="submit" class="btn btn-primary btn-block btn-large">Gestionar estacionamiento</button>
		</form>
		<br>
		<form action="CerrarSesion" method="post">
			<button type="submit" class="btn btn-primary btn-block btn-large">Cerrar
				sesión</button>
		</form>
		<b></b>
	</div>
</body>
</html>