<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Espacio Liberado</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
	<%@ page import="modelo.EspacioEstacionamiento" %>
	<%
		EspacioEstacionamiento espacioEstacionamiento = (EspacioEstacionamiento) request.getAttribute("espacioEstacionamiento");
	%>
	
	<h1>Espacio Estacionamiento Liberado</h1>
	<p>Numero de cajon: <%=espacioEstacionamiento.getNumero()%></p>
	<p>Matricula vehiculo: <%=espacioEstacionamiento.getMatricula() %></p>

	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
</body>
</html>