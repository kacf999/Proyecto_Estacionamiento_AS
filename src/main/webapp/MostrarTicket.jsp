<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ticked Generado</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
	<%@ page import="modelo.Ticket" %>
	<%
		Ticket ticket = (Ticket) request.getAttribute("ticket");
	%>
	
	<p>ID: <%=ticket.getId()%></p>
	<p>Matricula: <%=ticket.getMatriculaVehiculo()%></p>
	<p>Cajon: <%=ticket.getCajon()%></p>
	<p>Fecha: <%=ticket.getFecha() %></p>
	<p>Hora: <%=ticket.getHora() %></p>
	<p>Ruta Imagen: <%=ticket.getRuta()%></p>
	<img src=<%=ticket.getRutaRecortada()%> alt="ImagenQR">
	
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
</body>
</html>