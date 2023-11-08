<%@ page import="modelo.Vehiculo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar y Eliminar Veh�culo</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar y Eliminar Veh�culo</h1>
    <form action="BuscarVehiculoEliminar" method="post">
        <label>Matr�cula:</label>
        <input type="text" name="matricula" pattern = "[a-zA-Z][0-9]{2}[a-zA-Z]">
        <br><br>
        <input type="submit" class="btn btn-primary btn-large" value="Buscar">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
<%-- Si se encontr� el propietario, mostrar formulario de actualizaci�n --%>
    <% if (request.getAttribute("vehiculoEncontrado") != null) {
           boolean vehiculoEncontrado = (boolean) request.getAttribute("vehiculoEncontrado");
           if (vehiculoEncontrado) {
               Vehiculo vehiculo = (Vehiculo) request.getAttribute("vehiculo");
        %>
        <h2>Veh�culo Encontrado</h2>
        <div>
            <h3>Datos Actuales</h3>
            <p>ID del propietario: <%= vehiculo.getPropietario() %></p>
            <p>Matr�cula: <%= vehiculo.getMatricula() %></p>
            <p>Modelo y marca: <%= vehiculo.getModelo() %> <%= vehiculo.getMarca() %></p>
            <p>Color: <%= vehiculo.getColor() %></p>
        </div>
        <div>
            <h3>Eliminar Veh�culo</h3>
            <form action="EliminarVehiculo" method="post">
            	<h3>�Est�s seguro que quieres eliminar el registro de Veh�culo?</h3> 
                <%-- Campo oculto para enviar la Matr�cula del Veh�culo al servlet --%>
                <input type="hidden" name="matricula" value="<%= vehiculo.getMatricula() %>">
                <input type="submit" class="btn btn-primary btn-large" value="S�, eliminar">
            </form>        
        </div>
        <div>
	    	<form action="menuPrincipal.jsp" method="post">
	        	<input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    	</form>
    	</div>
    <% } }%>
</body>
</html>
