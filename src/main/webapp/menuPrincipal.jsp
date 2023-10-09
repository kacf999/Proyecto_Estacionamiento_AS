<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú Principal</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
	<%
	HttpSession sesion = request.getSession();

	if (sesion.getAttribute("usuario") == null) {
		String url = "login.jsp";
		response.sendRedirect(url);
	}
	%>
	
	<form action="CerrarSesion" method="post">
	<h1>¡Bienvenido, ${sessionScope.usuario}!
	<button type="submit" class="btn btn-primary btn-large">Cerrar sesión</button>
	</h1>
	
	</form>
    <h2>Menú Principal</h2>
    <form action="gestionarPropietario.jsp" method="post">
        <input type="submit" value="Gestionar Propietario">
    </form>
    <form action="gestionarVehiculo.jsp" method="post">
        <input type="submit" value="Gestionar Vehículo">
    </form>
    <form action="estacionamiento.jsp" method="post">
        <input type="submit" value="Entrar al estacionamiento">
    </form>
    <form action="salidaEstacionamiento.jsp" method="post">
        <input type="submit" value="Salir del estacionamiento">
    </form>
    <form action="verEspaciosEstacionamiento.jsp" method="post">
        <input type="submit" value="Ver espacios">
    </form>
    <form action="gestionarTickets.jsp" method="post">
        <input type="submit" value="Buscar Tickets">
    </form>
	<div class="image-container">
		  <img src="imagenes/logo.png" alt="Logo Estacionamiento">
	</div>
</body>
</html>
	