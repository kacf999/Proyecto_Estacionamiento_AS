<%@ page import="modelo.Ticket" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Ticket</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar Ticket por matr�cula</h1>
    <form action="BuscarTicket" method="post">
        <label>Matr�cula del veh�culo:</label>
        <input type="text" name="matricula">
        <br><br>
        <input type="submit" value="Buscar">
    </form>
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
    <%-- Si se encontraron tickets, mostrar formulario de gesti�n de tickets --%>
    <% if (request.getAttribute("ticketsEncontrados") != null) {
           boolean ticketsEncontrados = (boolean) request.getAttribute("ticketsEncontrados");
           if (ticketsEncontrados) {
               List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
        %>
        <h2>Tickets Encontrados</h2>
        <div>
            <h3>Datos obtenidos por �ltima visita:</h3>
            <% for (Ticket ticket : tickets) { %>
            <p>ID del ticket: <%= ticket.getId() %></p>
            <p>N�mero de caj�n de estacionamiento: <%= ticket.getCajon() %></p>
            <p>Matr�cula del veh�culo: <%= ticket.getMatriculaVehiculo() %></p>
            <p>Fecha y hora: <%= ticket.getFecha() %> | <%= ticket.getHora() %></p>
            <hr>
            <% } %>
        </div>
        <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
    <% } else {%>
	        <h2>Tickets NO Encontrados</h2>
	        <div>
			    <form action="menuPrincipal.jsp" method="post">
			        <input type="submit" value="Menu Principal">
			    </form>
	    	</div>
	 		   <%}
           }%>
</body>
</html>