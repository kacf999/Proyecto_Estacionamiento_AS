<%@ page import="modelo.Propietario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar y Eliminar Propietario</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar y Eliminar Propietario (debes llegar alguno de los dos campos)</h1>
    <form action="BuscarPropietarioEliminar" method="post">
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
            <h3>Eliminar Propietario</h3>
            <form action="EliminarPropietario" method="post">
            	<h3>�Est�s seguro que quieres eliminar el registro de propietario?</h3> 
                <%-- Campo oculto para enviar el ID o la Matr�cula del propietario al servlet --%>
                <input type="hidden" name="id" value="<%= propietario.getId() %>">
                <input type="hidden" name="matricula" value="<%= propietario.getMatricula() %>">
                <input type="submit" value="S�, eliminar">
            </form>        
         </div>
         <div>
	    	<form action="menuPrincipal.jsp" method="post">
		        <input type="submit" value="Menu Principal">
		    </form>
	    </div>
    <% } }%>
</body>
</html>
