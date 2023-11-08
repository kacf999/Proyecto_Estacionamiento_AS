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
						required><br> <label for="matricula">Matrícula del vehículo</label>
						<input type="text" name="matricula" required><br> <label
							for="foto">Foto</label> <input type="file" name="foto" required><br>
						<input type="submit" value="Subir Foto">
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
			document.querySelector("a").href = photo;
		}
	</script>
</body>
</html>
