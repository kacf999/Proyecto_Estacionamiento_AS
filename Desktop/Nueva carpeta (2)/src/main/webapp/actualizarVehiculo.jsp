<%@ page import="modelo.Vehiculo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar y Actualizar Vehículo</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar y Actualizar Vehículo</h1>
    <form action="BuscarVehiculoActualizar" method="post">
        <label>Matrícula:</label>
        <input type="text" name="matricula">
        <br><br>
        <input type="submit" class="btn btn-primary btn-large" value="Buscar">
    </form>
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
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
            <h3>Actualizar Vehículo</h3>
            <form action="ActualizarVehiculo" method="post">
			    <input type="hidden" name="matriculaAnterior" value="<%= vehiculo.getMatricula() %>">
                <label>ID del propietario:</label>
                <input type="text" name="id_propietario" value="<%= vehiculo.getPropietario() %>">
                <br><br>
                <label>Matrícula:</label>
                <input type="text" name="matricula" value="<%= vehiculo.getMatricula() %>">
                <br><br>
                <label>Modelo:</label>
                <input type="text" name="modelo" value="<%= vehiculo.getModelo() %>">
                <br><br>
                <label>Marca:</label>
                <input type="text" name="marca" value="<%= vehiculo.getMarca() %>">
                <br><br>
                <label>Color:</label>
                <input type="text" name="color" value="<%= vehiculo.getColor() %>">
                <br><br>
                <input type="submit" class="btn btn-primary btn-large" value="Actualizar">
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
