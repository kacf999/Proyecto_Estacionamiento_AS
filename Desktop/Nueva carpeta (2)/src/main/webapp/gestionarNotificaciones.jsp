<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú Principal de gestión de Notificaciones</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Menú Principal de gestión de Notificacion</h1>
    <form action="registrarNotificacion.jsp" method="post">
        <input type="submit" value="Registrar Notificacion">
    </form>
    <form action="buscarNotificacion.jsp" method="post">
        <input type="submit" value="Buscar Notificacion">
    </form>
    <form action="actualizarNotificacionBuscar.jsp" method="post">
        <input type="submit" value="Actualizar Notificacion">
    </form>
    <form action="eliminarNotificacion.jsp" method="post">
        <input type="submit" value="Eliminar Notificacion">
    </form>
    <form action="menuPrincipal.jsp" method="post">
        <input type="submit" value="Ir atrás">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
</body>
</html>
