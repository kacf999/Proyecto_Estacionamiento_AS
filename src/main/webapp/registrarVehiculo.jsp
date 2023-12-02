<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro de Vehículo</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Registro de Vehículo</h1>
    <form action="RegistrarVehiculo" method="post">
        <label for="propietario">ID del Propietario:</label>
        <input minlenght = "1" type="text" name="propietario" required patterne = "[0-9]"><br><br>
        <label for="modelo">Modelo:</label>
        <input minlenght = "1" type="text" name="modelo" required patterne = "[a-zA-Z]+"><br><br>
        <label for="marca">Marca:</label>
        <input minlenght = "1" type="text" name="marca" required patterne = "[a-zA-Z]+"><br><br>
        <label for="color">Color:</label>
        <input minlenght = "1" type="text" name="color" required patterne = "[a-zA-Z]+"><br><br>
        <label for="matricula">Matrícula:</label>
        <input type="text" name="matricula" required patterne = "[a-zA-Z][0-9]{2}[a-zA-Z]"><br><br>
        <input type="submit" value="Registrar">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
</body>
</html>
