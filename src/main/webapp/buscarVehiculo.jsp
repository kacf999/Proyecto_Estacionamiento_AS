<%@ page import="modelo.Vehiculo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Vehículo</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar Vehículo</h1>
    <form action="BuscarVehiculo" method="post">
        <label>Matrícula:</label>
        <input type="text" name="matricula">
        <br><br>
        <input type="submit" value="Buscar">
    </form>
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
    <%-- Si se encontrï¿½ el propietario, mostrar formulario de actualizaciï¿½n --%>
    <% if (request.getAttribute("vehiculoEncontrado") != null) {
           boolean vehiculoEncontrado = (boolean) request.getAttribute("vehiculoEncontrado");
           if (vehiculoEncontrado) {
               Vehiculo vehiculo = (Vehiculo) request.getAttribute("vehiculo");
        %>
        <h2>Vehículo Encontrado</h2>
        <div>
            <h3>Datos Actuales</h3>
            <p>ID del propietario: <%= vehiculo.getPropietario() %></p>
            <p>Matrícula: <%= vehiculo.getMatricula() %></p>
            <p>Modelo y marca: <%= vehiculo.getModelo() %> <%= vehiculo.getMarca() %></p>
            <p>Color: <%= vehiculo.getColor() %></p>
        </div>
        <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
    <% } else {%>
	        <h2>Vehículo NO Encontrado</h2>
	        <div>
			    <form action="menuPrincipal.jsp" method="post">
			        <input type="submit" value="Menu Principal">
			    </form>
	    	</div>
	 		   <%}
           }%>
</body>
</html>
