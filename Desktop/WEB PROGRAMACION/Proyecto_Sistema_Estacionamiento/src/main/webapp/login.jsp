<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="estilo.css" type="text/css" rel="stylesheet" />
<title>Inicio de sesión</title>
</head>
<%
HttpSession sesion = request.getSession();

if (sesion.getAttribute("usuario") != null) {
	String url = "menuPrincipal.jsp";
	response.sendRedirect(url);
}
%>

<body>
	<div class="login">
		<form action="login" method="POST">
			<h1>Iniciar sesión en el sistema de estacionamiento UACM</h1>
			<input type="text" class="btn btn-primary btn-large" name="usuario"
				value="Usuario" placeholder= "Usuario" /> <br> <br> <input
				type="password" class="btn btn-primary btn-large" name="contrasena"
				value="Contraseña" placeholder= "Contraseña" /> <br> <br> <input
				type="submit" class="btn btn-primary btn-large" value="Entrar" />
		</form>
		<%
		if (request.getAttribute("error") != null) {
		%>
		<div style="color: red">${error}</div>
		<%
		}
		%>
		<%
		if (request.getAttribute("info") != null) {
		%>
		<div style="color: green">${info}</div>
		<%
		}
		%>
	</div>
	<br> <br> <br>
</body>
</html>