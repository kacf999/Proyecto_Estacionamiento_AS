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
    
    <!-- Formulario para buscar propietario por ID -->
    <form action="BuscarPropietarioRegistroVehiculo" method="post">
        <label for="busqueda">Buscar Propietario por ID:</label>
        <input type="text" name="identificador">
        <input type="submit" class="btn btn-primary btn-large" value="Buscar">
    </form>

    <!-- Mostrar el nombre e ID del propietario encontrado -->
    <c:if test="${propietarioEncontrado ne null}">
    <h2>Propietario Encontrado:</h2>
        <select name="propietario">
            <option value="${propietarioEncontrado.id}">${propietarioEncontrado.nombre} | ID: ${propietarioEncontrado.id}</option>
        </select>
    </c:if><br><br>

    <!-- Formulario para registrar vehículo -->
    <form action="RegistrarVehiculo" method="post">
        <input type="hidden" name="propietario" value="${propietarioEncontrado.id}">
        <label for="modelo">Modelo:</label>
        <input minlength="1" type="text" name="modelo"><br><br>
        <label for="marca">Marca:</label>
        <input minlength="1" type="text" name="marca"><br><br>
        <label for="color">Color:</label>
        <input minlength="1" type="text" name="color"><br><br>
        <label for="matricula">Matrícula:</label>
        <input type="text" name="matricula"><br><br>
        <input type="submit" class="btn btn-primary btn-large" value="Registrar">
    </form>

    <!-- Volver al menú principal -->
    <div>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
        </form>
    </div>
</body>
</html>
