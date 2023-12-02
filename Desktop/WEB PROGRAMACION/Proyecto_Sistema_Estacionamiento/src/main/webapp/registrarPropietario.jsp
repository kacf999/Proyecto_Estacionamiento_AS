<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro de Propietario</title>
	<link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Registro de Propietario</h1>
    <form action="RegistrarPropietario" method="POST">
		<label for="nombre">Nombre (formato: mayúscúlas y minúsculas):</label>
		<input type="text" id="nombre" name="nombre" required pattern="[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+\s([A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+\s?){0,3}[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+"><br><br>
        
        <label for="numeroTelefono">Número de Teléfono [10 dígitos]:</label>
        <input minlength = "10" maxlength = "10" type="text" id="numeroTelefono" name="numeroTelefono" required pattern = "[0-9]+"><br><br>
        
		<label for="estudiante">¿Es estudiante? Clickear en caso de que sí lo sea</label>
		<input type="checkbox" id="estudianteCheckbox" name="estudiante"><br><br>

		<label for="matricula">Matrícula (formato: XXXXXXXXX):</label>
		<input type="text" id="matricula" name="matricula" disabled><br><br>
		
		<label for="calle">Calle:</label>
		<input type="text" id="calle" name="calle" required pattern="[A-Za-záéíóúüñÁÉÍÓÚÜÑ\s]+"><br><br>

		<label for="numero">Número:</label>
		<input minlength="1" type="number" id="numero" name="numero" required pattern="[0-9]+"><br><br>
		
		<label for="colonia">Colonia:</label>
		<input type="text" id="colonia" name="colonia" required pattern="[A-Za-záéíóúüñÁÉÍÓÚÜÑ\s]+"><br><br>
		
		<label for="delegacion">Delegación:</label>
		<input type="text" id="delegacion" name="delegacion" required pattern="[A-Za-záéíóúüñÁÉÍÓÚÜÑ\s]+"><br><br>
				
		<label for="cp">Código Postal:</label>
		<input minlength="1" type="number" id="cp" name="cp" required pattern="[0-9]+"><br><br>
        
        <input type="submit" class="btn btn-primary btn-large" value="Registrar Propietario">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" class="btn btn-primary btn-large" value="Menu Principal">
	    </form>
    </div>
</body>
<script>
    // Obtener referencias a los elementos HTML
    var estudianteCheckbox = document.getElementById("estudianteCheckbox");
    var matriculaInput = document.getElementById("matricula");

    // Agregar un evento de cambio al checkbox
    estudianteCheckbox.addEventListener("change", function () {
        // Habilitar o deshabilitar el campo de matrícula según el estado del checkbox
        if (estudianteCheckbox.checked) {
            matriculaInput.disabled = false; // Habilitar el campo
        } else {
            matriculaInput.disabled = true; // Deshabilitar el campo
        }
    });
</script>
</html>
