<!DOCTYPE html>
<html>
<head>
    <title>Salida de Estacionamiento</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Salida de Estacionamiento</h1>
    <form action="SalidaEstacionamiento" method="get">
        <label>Por favor introduce tu ID:</label>
        <input maxlenght = "9" type="text" name="id" required pattern = "[0-9]+">
        <br>
        <input type="submit" class="btn btn-primary btn-large" value="Salir del Estacionamiento">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
</body>
</html>
