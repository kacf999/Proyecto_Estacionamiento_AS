<%@ page import="modelo.Ticket" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Todos los Tickets</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar todos los tickets</h1>
    <form action="BuscarTicketTodos" method="post">
        <br><br>
        <input type="submit" class="btn btn-primary btn-large" value="Buscar ahora">
    </form>
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
    <%-- Si se encontraron tickets, mostrar formulario de gestión de tickets --%>
    <% if (request.getAttribute("ticketsEncontrados") != null) {
           boolean ticketsEncontrados = (boolean) request.getAttribute("ticketsEncontrados");
           if (ticketsEncontrados) {
               List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
        %>
        <h2>Tickets Encontrados</h2>
        <div>
            <h3>Datos obtenidos por última visita:</h3>
            <% for (Ticket ticket : tickets) { %>
            <p>ID del ticket: <%= ticket.getId() %></p>
            <p>Número de cajón de estacionamiento: <%= ticket.getCajon() %></p>
            <p>Matrícula del vehículo: <%= ticket.getMatriculaVehiculo() %></p>
            <p>Fecha y hora: <%= ticket.getFecha() %> | <%= ticket.getHora() %></p>
            <hr>
            <% } %>
        </div>
        <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
    <% } else {%>
	        <h2>Tickets NO Encontrados</h2>
	        <div>
			    <form action="menuPrincipal.jsp" method="post">
			        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
			    </form>
	    	</div>
	 		   <%}
           }%>
</body>
</html>