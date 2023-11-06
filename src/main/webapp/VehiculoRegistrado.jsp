<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Vehiculo Registrado con exito</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
	<%@page import = "modelo.Vehiculo" %>
	<%Vehiculo vehiculo = (Vehiculo) request.getAttribute("vehiculo");%>
	
	<p>Modelo: <%=vehiculo.getModelo()%></p>
	<p>Marca: <%=vehiculo.getMarca()%></p>
	<p>Color: <%=vehiculo.getColor() %></p>
	<p>Matricula: <%=vehiculo.getMatricula() %></p>
	
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
	
</body>
</html>