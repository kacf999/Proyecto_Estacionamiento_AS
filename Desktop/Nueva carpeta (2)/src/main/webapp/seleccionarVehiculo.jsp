<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seleccionar Vehículo</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Seleccionar Vehículo</h1>

    <form action="SalidaEstacionamiento" method="post">
        <label for="matricula">Seleccione el vehículo a sacar:</label>
        <select name="matricula">
            <% 
                List<String> vehiculos = (List<String>) request.getAttribute("vehiculos");
                for (String vehiculo : vehiculos) {
                    out.println("<option value=\"" + vehiculo + "\">" + vehiculo + "</option>");
                }
            %>
        </select>
        <br><br>
        <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
        <input type="submit" class="btn btn-primary btn-large" value="Sacar del estacionamiento">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
</body>
</html>
