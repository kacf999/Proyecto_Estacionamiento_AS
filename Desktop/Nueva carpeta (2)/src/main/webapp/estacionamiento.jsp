<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Estacionamiento</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Bienvenido al estacionamiento</h1>
    <form action="Estacionamiento" method="post">
        <label for="idUsuario">Introduce tu ID de usuario:</label>
        <input maxlenght = "9" type="text" name="id_propietario" id="id_propietario" required pattern = "[0-9]+">
        <br>
        <label for="matricula">Introduce la Matrícula de tu auto:</label>
        <input type="text" name="matricula" id="matricula">
        <br>
        <input type="submit" class="btn btn-primary btn-large" value="Buscar">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
</body>
</html>
