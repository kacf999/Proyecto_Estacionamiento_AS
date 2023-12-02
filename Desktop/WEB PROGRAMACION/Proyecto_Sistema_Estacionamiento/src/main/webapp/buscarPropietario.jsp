<%@ page import="modelo.Propietario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Propietario</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar Propietario (debes llegar alguno de los dos campos)</h1>
    <form action="BuscarPropietario" method="post">
        <label>ID:</label>
        <input minlenght = "9" maxlenght = "9" type="text" name="id" pattern = "[0-9]+">
        <br><br>
        <label>Matrícula (si es estudiante):</label>
        <input minlenght = "9" maxlenght = "9" type="text" name="matricula" pattern = "[0-9]+">
        <br><br>
        <input type="submit" class="btn btn-primary btn-large" value="Buscar">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>

    <%-- Si se encontrï¿½ el propietario, mostrar formulario de actualizaciï¿½n --%>
    <% if (request.getAttribute("propietarioEncontrado") != null) {
           boolean propietarioEncontrado = (boolean) request.getAttribute("propietarioEncontrado");
           if (propietarioEncontrado) {
               Propietario propietario = (Propietario) request.getAttribute("propietario");
        %>
        <h2>Propietario Encontrado</h2>
        <div>
            <h3>Datos Actuales</h3>
            <p>ID: <%= propietario.getId() %></p>
            <p>Nombre: <%= propietario.getNombre() %></p>
            <p>Número de teléfono <%= propietario.getNumeroTelefono() %></p>
            <p>Matrícula: <%= propietario.getMatricula() %></p>
			<p>¿Es estudiante?: <%= propietario.isEstudiante() ? "Sí" : "No" %></p>
            <p>Calle: <%= propietario.getDireccion().getCalle() %></p>
            <p>Colonia: <%= propietario.getDireccion().getColonia() %></p>
            <p>Delegación: <%= propietario.getDireccion().getDelegacion() %></p>
            <p>Número: <%= propietario.getDireccion().getNumero() %></p>
            <p>Código Postal: <%= propietario.getDireccion().getCp() %></p>
        </div>
        <div>
	    	<form action="menuPrincipal.jsp" method="post">
	        	<input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    	</form>
    	</div>
    <% } else {%>
	        <h2>Propietario NO Encontrado</h2>
	        <div>
		    	<form action="menuPrincipal.jsp" method="post">
		        	<input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
		    	</form>
	    	</div>
	 		   <%}
           }%>
</body>
</html>
