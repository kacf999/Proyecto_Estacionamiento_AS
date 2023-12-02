<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalles de la Imagen</title>
</head>
<body>
    <h1>Detalles de la Imagen</h1>
    <p>Fecha: ${requestScope.fecha}</p>
    <p>Matrícula: ${requestScope.matricula}</p>
    <p>Imagen:</p>
    <img src="data:image/jpeg;base64,${requestScope.imagenBase64}" />

    <form action="VerImagenes" method="get">
        <input type="submit" value="Ver Todas las Imágenes">
    </form>
    <form action="camara.jsp" method="get">
        <input type="submit" value="Subir Otra Imagen">
    </form>
</body>
</html>
