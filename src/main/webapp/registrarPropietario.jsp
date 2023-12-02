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
		<label for="nombre">Nombre:</label>
		<input type="text" id="nombre" name="nombre" required pattern="[A-Za-z��������������]+\s([A-Za-z��������������]+\s?){0,3}[A-Za-z��������������]+"><br><br>
        
        <label for="numeroTelefono">N�mero de Tel�fono [10 d�gitos]:</label>
        <input minlength = "10" maxlength = "10" type="text" id="numeroTelefono" name="numeroTelefono" required pattern = "[0-9]+"><br><br>
        
		<label for="matricula">Matr�cula (opcional) [solo n�meros]:</label>
		<input minlength="9" maxlength="9" type="text" id="matricula" name="matricula" pattern="[0-9]{9}"><br><br>
		
		<label for="estudiante">�Es estudiante? Clickear en caso de que s� lo sea</label>
		<input type="checkbox" id="estudiante" name="estudiante"><br><br>
		
		<label for="calle">Calle:</label>
		<input type="text" id="calle" name="calle" required pattern="[A-Za-z��������������\s]+"><br><br>

		<label for="numero">N�mero:</label>
		<input minlength="1" type="number" id="numero" name="numero" required pattern="[0-9]+"><br><br>
		
		<label for="colonia">Colonia:</label>
		<input type="text" id="colonia" name="colonia" required pattern="[A-Za-z��������������\s]+"><br><br>
		
		<label for="delegacion">Delegaci�n:</label>
		<input type="text" id="delegacion" name="delegacion" required pattern="[A-Za-z��������������\s]+"><br><br>
				
		<label for="cp">C�digo Postal:</label>
		<input minlength="1" type="number" id="cp" name="cp" required pattern="[0-9]+"><br><br>
        
        <input type="submit" value="Registrar Propietario">
    </form>
    <div>
	    <form action="menuPrincipal.jsp" method="post">
	        <input type="submit" value="Menu Principal">
	    </form>
    </div>
</body>
</html>
