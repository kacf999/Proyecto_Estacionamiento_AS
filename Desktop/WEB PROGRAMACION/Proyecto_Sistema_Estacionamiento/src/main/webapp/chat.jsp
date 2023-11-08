<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat del estacionamiento</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

<style>
.message {
	border: 1px solid #ccc;
	padding: 10px;
	margin: 10px;
	max-width: 70%;
}
</style>
</head>
<body>
	<%
	HttpSession sesion = request.getSession();
	String usuario = (String) sesion.getAttribute("usuario");
	String usuario2 = (String) sesion.getAttribute("usuario2");
	Integer propietarioId = (Integer) sesion.getAttribute("propietarioId");
	String nombrePropietario = (String) sesion.getAttribute("nombrePropietario");

	if (usuario == null && usuario2 == null) {
		// Si ninguno de los dos tipos de usuario ha iniciado sesión, redirige al inicio de sesión
		String url = "login.jsp";
		response.sendRedirect(url);
	} else {
	%>

	<div class="container mt-4">
		<header class="text-center">
			<form action="menuPrincipal.jsp" method="post">
				<input type="submit" class="btn btn-primary btn-large"
					value="Regresar al meú">
			</form>
			<h1>Chat en Tiempo Real</h1>
		</header>
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<center>
						<div class="card-header">
							Universidad Autónoma de la Ciudad de México | <strong>San
								Lorenzo Tezonco</strong>
						</div>
					</center>
					<div class="card">
						<center>
							<!-- ... Código anterior ... -->
							<div class="card-header">
								Estás logeado como
								<%
							if (nombrePropietario != null) {
							%>
								<%=nombrePropietario%>
								<%
								if (propietarioId == 0) {
								%>
								<span style="color: red;"><i class="fas fa-star"></i></span>
								<%
								}
								%>
								.
								<%
								}
								%>
								Recuerda mantener la compostura ante este chat virtual.</i>
							</div>
						</center>
					</div>
					<div class="card-body">
						<div class="messages-container mb-4"
							style="max-height: 500px; overflow-y: auto;">
							<!-- Recuadro para mensajes previos -->
							<div class="messages-previos">
								<div class="message"></div>
							</div>
						</div>
						<form id="message-form" method="post">
							<div class="input-group mb-3">
								<input type="text" id="mensaje" name="mensaje"
									class="form-control" placeholder="Escribe un mensaje..."
									required>
								<button type="submit" class="btn btn-primary">Enviar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							// Función para cargar mensajes desde el servidor
							function cargarMensajes() {
								$
										.ajax({
											type : "GET",
											url : "Chat",
											success : function(data) {
												// Procesar y mostrar los mensajes en el chat-box
												var chatBox = $(".messages-previos");
												chatBox.empty(); // Limpia el contenido actual

												for (var i = data.length - 1; i >= 0; i--) {
													var mensaje = data[i];
													var messageDiv = $("<div class='message mb-4 border p-3 rounded'>");
	<%if (propietarioId == 0) {%>
		messageDiv = $("<div class='message mb-4 border p-3 rounded text-right'>");
	<%}%>
		messageDiv
															.html("<p><strong>"
																	+ mensaje.usuario
																	+ ":</strong></p><p>"
																	+ mensaje.mensaje
																	+ "</p><p class='text-muted'>"
																	+ mensaje.fecha
																	+ "</p>");
													chatBox.append(messageDiv);
	<%if (propietarioId == 0) {%>
		var buttonsDiv = $("<div class='btn-group' role='group'><button type='button' class='btn btn-danger'>Borrar</button><button type='button' class='btn btn-warning'>Ocultar</button></div>");
													messageDiv
															.append(buttonsDiv);
	<%}%>
		}

												// Hacer scroll hacia abajo para mostrar los mensajes más recientes
												chatBox
														.scrollTop(chatBox[0].scrollHeight);
											},
											error : function() {
												console
														.error("Error al cargar mensajes");
											}
										});
							}

							// Cargar mensajes inicialmente y configurar la actualización automática
							cargarMensajes();
							setInterval(cargarMensajes, 1000); // Consulta al servidor cada 5 segundos

							$("#message-form")
									.submit(
											function(event) {
												event.preventDefault();

												// Obtener el mensaje del campo de entrada
												var mensaje = $("#mensaje")
														.val();

												// Enviar el mensaje al servidor
												$
														.ajax({
															type : "POST",
															url : "Chat",
															data : {
																mensaje : mensaje
															},
															success : function() {
																// Limpiar el formulario después de enviar el mensaje
																$("#message-form")[0]
																		.reset();
																cargarMensajes();

																// Agregar un distintivo temporal de color dorado claro durante 2 segundos
																var mensajeEnviado = $("<div class='message mb-4 border p-3 rounded' style='background-color: #ffeeba;'>");
																mensajeEnviado
																		.html("<p><strong>Tú:</strong></p><p>"
																				+ mensaje
																				+ "</p>");
																$(
																		".messages-previos")
																		.append(
																				mensajeEnviado);
																setTimeout(
																		function() {
																			mensajeEnviado
																					.remove();
																		}, 6000);
															},
															error : function() {
																console
																		.error("Error al enviar mensaje");
															}
														});
											});
						});
	</script>
</body>
</html>
<%
}
%>
