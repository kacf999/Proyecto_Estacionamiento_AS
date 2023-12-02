<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Encuesta</title>

<link rel="stylesheet" href="estilo.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- FontAwesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<style>
/* Estilo para la barra de calificación */
.rating-bar {
	background-color: #e0e0e0;
	height: 20px;
	position: relative;
	margin-top: 10px;
}

.rating-fill {
	height: 100%;
	transition: width 0.5s;
}

/* Colores para la barra de calificación */
.rating-fill.positive {
	width: 100%;
	background-color: #28a745; /* Verde para calificaciones positivas */
}

.rating-fill.neutral {
	width: 50%;
	background-color: #ffc107; /* Amarillo para calificaciones neutras */
}

.rating-fill.negative {
	width: 20%;
	background-color: #dc3545; /* Rojo para calificaciones negativas */
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
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<h5>¡Bienvenido, <%= nombrePropietario %>!<br>Por favor, ¿podrías aportar tu opinión acerca del
					estacionamiento de la UACM?</h5>
				<form action="AlmacenarEncuesta" method="post">
					<!-- Campo de calificación -->
					<div class="form-group">
						<label for="calificacion">Calificación (selecciona un
							círculo con tu preferencia):</label>
						<div class="rating">
							<%
							for (int i = 5; i >= 1; i--) {
							%>
							<input type="radio" name="calificacion" value="<%=i%>"
								id="star<%=i%>" required> <label for="star<%=i%>">
								<%
								for (int j = 0; j < i; j++) {
								%> <i class="fas fa-star"></i> <%
 }
 %>
							</label>
							<%
							}
							%>
						</div>
						<div class="rating-bar">
							<div class="rating-fill"></div>
						</div>
					</div>
					<!-- Campo de comentarios -->
					<div class="form-group">
						<label for="comentarios">Comentarios (este campo es
							requerido si deseas llenar la encuesta):</label>
						<textarea class="form-control" id="comentarios" name="comentarios"
							rows="3" required></textarea>
					</div>

					<center>
						<button type="submit" class="btn btn-primary">Enviar
							Encuesta</button>
					</center>
					<!-- Agrega el botón para regresar al menú principal -->
					<div class="text-center mt-3">
						<a href="menuPrincipal.jsp" class="btn btn-secondary">Regresar
							al Menú Principal</a>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS y Popper.js -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- Script para actualizar la barra de calificación -->
	<script>
		$(document)
				.ready(
						function() {
							$('input[type=radio][name=calificacion]')
									.change(
											function() {
												var ratingValue = $(this).val();
												var fillWidth = (ratingValue / 5) * 100;
												$('.rating-fill').css('width',
														fillWidth + '%');
												// Agrega clases para cambiar el color de la barra según la calificación
												if (ratingValue >= 4) {
													$('.rating-fill')
															.removeClass(
																	'neutral negative')
															.addClass(
																	'positive');
												} else if (ratingValue == 3) {
													$('.rating-fill')
															.removeClass(
																	'positive negative')
															.addClass('neutral');
												} else {
													$('.rating-fill')
															.removeClass(
																	'positive neutral')
															.addClass(
																	'negative');
												}
											});
						});

		$(document).ready(function() {
			$('form').submit(function(e) {
				e.preventDefault();

				// Obtener los datos del formulario
				var formData = $(this).serialize();

				// Realizar la petición Ajax al servlet
				$.ajax({
					type : 'POST',
					url : 'AlmacenarEncuesta',
					data : formData,
					success : function(response) {
						// Manejar la respuesta del servidor
						alert(response.mensaje); // Puedes mostrar el mensaje de agradecimiento en un modal o en algún otro lugar
						// Limpiar el formulario
						$('form')[0].reset();
					},
					error : function() {
						alert('Error al enviar la encuesta.');
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