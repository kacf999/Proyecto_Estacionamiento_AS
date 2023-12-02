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
        <label>Matr�cula (si es estudiante):</label>
        <input minlenght = "9" maxlenght = "9" type="text" name="matricula" pattern = "[0-9]+">
        <br><br>
        <input type="submit" value="Buscar">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>

    <%-- Si se encontr� el propietario, mostrar formulario de actualizaci�n --%>
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
            <p>N�mero de tel�fono <%= propietario.getNumeroTelefono() %></p>
            <p>Matr�cula: <%= propietario.getMatricula() %></p>
			<p>�Es estudiante?: <%= propietario.isEstudiante() ? "S�" : "No" %></p>
            <p>Calle: <%= propietario.getDireccion().getCalle() %></p>
            <p>Colonia: <%= propietario.getDireccion().getColonia() %></p>
            <p>Delegaci�n: <%= propietario.getDireccion().getDelegacion() %></p>
            <p>N�mero: <%= propietario.getDireccion().getNumero() %></p>
            <p>C�digo Postal: <%= propietario.getDireccion().getCp() %></p>
        </div>
        <div>
	    	<form action="menuPrincipal.jsp" method="post">
	        	<input type="submit" value="Menu Principal">
	    	</form>
    	</div>
    <% } else {%>
	        <h2>Propietario NO Encontrado</h2>
	        <div>
		    	<form action="menuPrincipal.jsp" method="post">
		        	<input type="submit" value="Menu Principal">
		    	</form>
	    	</div>
	 		   <%}
           }%>
</body>
</html>
