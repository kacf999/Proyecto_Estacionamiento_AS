<%@ page import="modelo.EspacioEstacionamiento" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ver estado de los espacios del estacionamiento</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Ver estado de los espacios del estacionamiento</h1>
    <form action="BuscarEspaciosEstacionamiento" method="post">
        <br><br>
        <input type="submit" value="Buscar ahora">
    </form>
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
    <%-- Si se encontraron tickets, mostrar formulario de gestión de tickets --%>
    <% if (request.getAttribute("espaciosEncontrados") != null) {
           boolean espaciosEncontrados = (boolean) request.getAttribute("espaciosEncontrados");
           if (espaciosEncontrados) {
               List<EspacioEstacionamiento> espacio = (List<EspacioEstacionamiento>) request.getAttribute("espacios");
        %>
        <h2>Espacios Encontrados</h2>
        <div>
            <h3>Estado de espacios encontrados en el estacionamiento:</h3>
<h1><% for (EspacioEstacionamiento espacioEstacionamiento : espacio) { %>
    <p>Numero de espacio: <%= espacioEstacionamiento.getNumero() %></p>
    <% if (espacioEstacionamiento.isEstado()) { %>
        <p>Estado actual: Ocupado</p>
        <% if (espacioEstacionamiento.getMatricula() == null) { %>
            <p>Matrícula asignada al espacio: NO HAY VEHÍCULO</p>
        <% } else { %>
            <p>Matrícula asignada al espacio: <%= espacioEstacionamiento.getMatricula() %></p>
        <% } %>
    <% } else { %>
        <p>Estado actual: Disponible</p>
        <p>Matrícula asignada al espacio: NO HAY VEHÍCULO</p>
    <% } %>
    <hr>
<% } %>
</h1>
        </div>
        <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
    <% } else {%>
	        <h2>Espacios NO Encontrados</h2>
	        <div>
			    <form action="menuPrincipal.jsp" method="post">
			        <input type="submit" value="Menu Principal">
			    </form>
	    	</div>
	 		   <%}
           }%>
</body>
</html>