<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Registro Exitoso</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
	<%@ page import="modelo.Propietario" %>
	<%
		Propietario propietario = (Propietario) request.getAttribute("propietario");
	%>
	
	<p>ID: <%=propietario.getId() %></p>
	<p>Nombre: <%=propietario.getNombre() %></p>
	<p>Matricula: <%=propietario.getMatricula() %></p>
	<p>Numero: <%=propietario.getNumeroTelefono() %></p>
	<p>Estudiante: <%
		if(propietario.isEstudiante() == true){
			out.println("Si");
		}else{
			out.println("No");
		}
	%></p>
	<p>Direccion</p>
	<P>Calle: <%= propietario.getDireccion().getCalle()%></P>
	<P>Colinia: <%= propietario.getDireccion().getColonia()%></P>
	<P>Delegacion: <%= propietario.getDireccion().getDelegacion()%></P>
	<P>Numero: <%= propietario.getDireccion().getNumero()%></P>
	<p>CP: <%= propietario.getDireccion().getCp()%></p>
	
	<div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
	
</body>
</html>