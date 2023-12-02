<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cámaras de vigilancia</title>
<link href="estilo.css" type="text/css" rel="stylesheet" />
<style>
/* Estilos CSS para el diseño de la página */
.container {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

.camera-container {
	width: 50%;
	padding: 20px;
}

.form-container {
	width: 50%;
	padding: 20px;
}

.camera-box {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center;
}

.form-box {
	border: 1px solid #ccc;
	padding: 10px;
}

.capture-button {
	display: block;
	margin: 10px auto;
	background-color: #007bff;
	color: white;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
}

.capture-button:hover {
	background-color: #0056b3;
}
</style>
<script type="text/javascript"
	src="https://unpkg.com/webcam-easy/dist/webcam-easy.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="camera-container">
			<div class="camera-box">
				<h2>Cámara de Vigilancia</h2>
				<div id="fechaHoraServidor">
					<%
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
					String fechaHoraActual = sdf.format(new java.util.Date());
					%>
					<strong><%=fechaHoraActual%></strong>
				</div>
				<br>
				<video autoplay="true" id="webCam"></video>
				<canvas id="canvas"></canvas>
				<a download class="capture-button" onClick="takePhoto()">Capturar
					Foto</a>
			</div>
		</div>
		<div class="form-container">
			<div class="form-box">
				<h2>Subir fotografía de vehículo</h2>
				<form action="ProcesarFotografia" method="post"
					enctype="multipart/form-data">
					<label for="fecha">Fecha</label> <input type="date" name="fecha"
						required><br> <label for="matricula">Matrícula
						del vehículo</label> <input type="text" name="matricula" required><br>
					<label for="foto">Foto</label> <input type="file" name="foto"
						required><br> <input type="submit" value="Subir Foto">
				</form>
				<form action="menuPrincipal.jsp" method="post">
					<input type="submit" class="btn btn-primary btn-large"
						value="Menú principal">
				</form>
			</div>
		</div>
	</div>
	<script>
		const webCamElement = document.getElementById("webCam");
		const canvasElement = document.getElementById("canvas");
		const camara = new Webcam(webCamElement, "user", canvasElement);
		camara.start();

		function takePhoto() {
			let photo = camara.snap();

			// Agregar la fecha y hora a la imagen.
			const sdf = new Intl.DateTimeFormat('es-ES', {
				year : 'numeric',
				month : '2-digit',
				day : '2-digit',
				hour : '2-digit',
				minute : '2-digit',
				second : '2-digit'
			});
			const fechaHoraActual = sdf.format(new Date());

			// Crear un nuevo elemento de imagen para mostrar la imagen con el texto.
			const imageWithText = new Image();
			imageWithText.src = photo;

			// Cuando la imagen cargue, agregamos el texto y la mostramos en un nuevo canvas.
			imageWithText.onload = function() {
				const newCanvas = document.createElement('canvas');
				newCanvas.width = imageWithText.width;
				newCanvas.height = imageWithText.height + 30; // Añade 30 píxeles para el texto.
				const ctx = newCanvas.getContext('2d');

				// Dibuja la imagen en el nuevo canvas.
				ctx.drawImage(imageWithText, 0, 30); // Comienza desde 30 píxeles abajo para dar espacio al texto.

				// Agrega el texto con la fecha y hora en la parte superior.
				ctx.font = '18px Arial';
				ctx.fillStyle = 'white';
				ctx.fillText(fechaHoraActual, 10, 20); // Coordenadas x, y para el texto.

				// Puedes guardar o mostrar esta nueva imagen como desees.
				const newPhoto = newCanvas.toDataURL('image/jpeg');
				document.querySelector("a").href = newPhoto;
			};
		}
	</script>
</body>
</html>
