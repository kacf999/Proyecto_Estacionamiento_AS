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
	<%@ page import="modelo.Ticket" %>
	<%@ page import="modelo.CobroEstacionamiento" %>
	<%
		Ticket ticket = (Ticket) request.getAttribute("ticket");
		CobroEstacionamiento cobro = new CobroEstacionamiento(ticket);
	%>
	
	<h1>Espacio Estacionamiento Liberado</h1>
	<p>Numero de cajon: <%=ticket.getCajon()%></p>
	<p>Matricula vehiculo: <%=ticket.getMatriculaVehiculo() %></p>
	<p>Fecha de ingreso: <%=ticket.getFecha() %></p>
	<p>Hora de ingreso: <%=ticket.getHora() %></p>
	<p>Tarifa de cobro: <%=cobro.calcularTarifa()%>

	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
</body>
</html>