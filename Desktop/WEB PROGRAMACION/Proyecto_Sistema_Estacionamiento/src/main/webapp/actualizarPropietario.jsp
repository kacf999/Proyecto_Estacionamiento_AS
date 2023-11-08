<%@ page import="modelo.Propietario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar y Actualizar Propietario</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar y Actualizar Propietario (debes llegar alguno de los dos campos)</h1>
    <form action="BuscarPropietarioActualizar" method="post">
        <label>ID:</label>
        <input maxlenght = "9" type="text" name="id" pattern = "[0-9]+">
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
            <h3>Actualizar Propietario</h3>
            <form action="ActualizarPropietario" method="post">
                <input type="hidden" name="id" value="<%= propietario.getId() %>">
                <input type="hidden" name="matricula" value="<%= propietario.getMatricula() %>">
                <input type="hidden" name="estudiante" value="<%= propietario.isEstudiante() %>">
                <label>Nombre:</label>
                <input type="text" name="nombre" pattern = "[a-zA-Z]+" value="<%= propietario.getNombre() %>">
                <br><br>
                <label>Número de teléfono</label>
                <input minlenght = "10" maxlenght = "10" type="text" name="numeroTelefono" pattern = "[0-9]+" value="<%= propietario.getNumeroTelefono() %>">
                <br><br>
                <label>Calle:</label>
                <input type="text" name="calle" pattern = "[a-zA-Z]+" value="<%= propietario.getDireccion().getCalle() %>">
                <br><br>
                <label>Colonia:</label>
                <input type="text" name="colonia" pattern = "[a-zA-Z]+" value="<%= propietario.getDireccion().getColonia() %>">
                <br><br>
                <label>Delegación:</label>
                <input type="text" name="delegacion" pattern = "[a-zA-Z]+" value="<%= propietario.getDireccion().getDelegacion() %>">
                <br><br>
                <label>Número:</label>
                <input minlenght = "1" type="text" name="numero" pattern = "[0-9]+" value="<%= propietario.getDireccion().getNumero() %>">
                <br><br>
                <label>Código Postal:</label>
                <input minlenght = "1" type="text" name="cp" pattern = "[0-9]+" value="<%= propietario.getDireccion().getCp() %>">
                <br><br>
                <input type="submit" class="btn btn-primary btn-large" value="Actualizar">
            </form>
        </div>
        <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    	</div>
    <% } }%>
</body>
</html>
