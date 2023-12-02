<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú Principal de gestión de Vehículo</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Menú Principal de gestión de Vehículo</h1>
    <form action="registrarVehiculo.jsp" method="post">
        <input type="submit" class="btn btn-primary btn-large" value="Registrar Vehículo">
    </form>
    <form action="buscarVehiculo.jsp" method="post">
        <input type="submit" class="btn btn-primary btn-large" value="Buscar Vehículo">
    </form>
    <form action="actualizarVehiculo.jsp" method="post">
        <input type="submit" class="btn btn-primary btn-large" value="Actualizar Vehículo">
    </form>
    <form action="eliminarVehiculo.jsp" method="post">
        <input type="submit" class="btn btn-primary btn-large" value="Eliminar Vehículo">
    </form>
    <form action="menuPrincipal.jsp" method="post">
        <input type="submit" class="btn btn-primary btn-large" value="Ir atrás">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
</body>
</html>
