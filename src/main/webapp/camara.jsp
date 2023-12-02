<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Subir Foto</title>
<link href="estilo.css" type="text/css" rel="stylesheet" />
</head>
<body>
<form action="ProcesarFotografia" method="post" enctype="multipart/form-data">
    <label for="fecha">Fecha</label>
    <input type="date" name="fecha" required><br>
    <label for="matricula">Matrícula:</label>
    <input type="text" name="matricula" required><br>
    <label for="foto">Foto:</label>
    <input type="file" name="foto" required><br>
    <input type="submit" value="Subir Foto">
</form>
</body>
</html>
