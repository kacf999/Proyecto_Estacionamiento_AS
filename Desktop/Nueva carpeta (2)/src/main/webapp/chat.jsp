<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat del estacionamiento - Universidad Autónoma de la Ciudad de México</title>
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
					value="Regresar al menú">
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
								Recuerda mantener la compostura ante este chat virtual.
							</div>
						</center>
					</div>
					<div class="card-body">
						<div class="messages-container mb-4"
							style="max-height: 500px; overflow-y: auto;">
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
        $(document).ready(function() {
            function resaltarEnlaces() {
                $(".message p").each(function() {
                    var texto = $(this).html();
                    var enlaceRegex = /(https?:\/\/[^\s]+)/g;
                    var textoResaltado = texto.replace(enlaceRegex, '<a href="$1" target="_blank" style="color: blue;">$1</a>');
                    $(this).html(textoResaltado);
                });
            }

            function hacerScroll() {
                var chatBox = $(".messages-previos");
                chatBox.scrollTop(chatBox[0].scrollHeight);
            }

            function cargarMensajes() {
                $.ajax({
                    type: "GET",
                    url: "Chat",
                    success: function(data) {
                        var chatBox = $(".messages-previos");
                        chatBox.empty();

                        for (var i = data.length - 1; i >= 0; i--) {
                            var mensaje = data[i];
                            var messageDiv = $("<div class='message mb-4 border p-3 rounded'>");

                            <%
                                if (propietarioId == 0) {
                            %>
                                messageDiv = $("<div class='message mb-4 border p-3 rounded text-right'>");
                            <%
                                }
                            %>


                            if (mensaje.estado == 1) {
                                <% 
                                if (propietarioId != 0) {
                                %>
						        messageDiv = $("<div class='message mb-4 border p-3 rounded text-right' style='background-color: #ffeeba;'>");
						        messageDiv.html("<p><i class='fas fa-eye-slash'></i> Mensaje oculto por el administrador.</p>");
						        chatBox.append(messageDiv);
		        				<%
                                } else if (propietarioId == 0) {
                                	

	                            %> 
	                            messageDiv.html("Mensaje ocultado" + "<p><strong>" + mensaje.usuario + ":</strong></p><p>" + mensaje.mensaje + "</p><p class='text-muted'>" + mensaje.fecha + "</p>");
	                            chatBox.append(messageDiv);
		        				<%
                                }
                                %> 
	                            
                                }
                            else if (mensaje.estado != 1) {
	                            messageDiv.html("<p><strong>" + mensaje.usuario + ":</strong></p><p>" + mensaje.mensaje + "</p><p class='text-muted'>" + mensaje.fecha + "</p>");
	                            chatBox.append(messageDiv);
                            }                                	

                            <%
                                if (propietarioId == 0) {
                                	
                            %>
                                var buttonsDiv = $("<div class='btn-group' role='group'><button type='button' class='btn btn-danger' data-mensaje-id='" + mensaje.id + "'>Borrar</button><button type='button' class='btn btn-warning' data-mensaje-id='" + mensaje.id + "'>Ocultar</button><button type='button' class='btn btn-success' data-mensaje-id='" + mensaje.id + "'>Mostrar</button></div>");
                                messageDiv.append(buttonsDiv);
                            <%
                                }
                            %>
                            <%
                            if (propietarioId != 0) {
                            	
                        %>
	                        if (mensaje.estado != 2) {
                            var buttonsDiv = $("<div class='btn-group' role='group'><button type='button' class='btn btn-secondary' data-mensaje-id='" + mensaje.id + "'>Reportar</button></div>");
                            messageDiv.append(buttonsDiv); 
	                        } else {
	                        	var buttonsDiv = $("<div class='btn-group' role='group'><span style='color: red; font-style: italic; font-weight: bold;'>Reportaste este mensaje</span></div><div class='btn-group' role='group'><button type='button' class='btn btn-link' data-mensaje-id='" + mensaje.id + "'>Quitar reporte</button></div>");
	                        	messageDiv.append(buttonsDiv);	                        	
	                        }
                        <%
                            } 
                        %>

                        
                        }

                        hacerScroll();
                        resaltarEnlaces();
                    },
                    error: function() {
                        console.error("Error al cargar mensajes");
                    }
                });
            }

            cargarMensajes();
            setInterval(cargarMensajes, 1000);

            $("#message-form").submit(function(event) {
                event.preventDefault();

                var mensaje = $("#mensaje").val();

                $.ajax({
                    type: "POST",
                    url: "Chat",
                    data: { mensaje: mensaje },
                    success: function() {
                        $("#message-form")[0].reset();
                        cargarMensajes();

                        var mensajeEnviado = $("<div class='message mb-4 border p-3 rounded' style='background-color: #ffeeba;'>");
                        mensajeEnviado.html("<p><strong>Tú:</strong></p><p>" + mensaje + "</p>");
                        $(".messages-previos").append(mensajeEnviado);

                        setTimeout(function() {
                            mensajeEnviado.remove();
                        }, 6000);

                        hacerScroll();
                        resaltarEnlaces();
                    },
                    error: function() {
                        console.error("Error al enviar mensaje");
                    }
                });
            });

            // Evento de clic en el botón "Borrar"
            $(".messages-previos").on("click", ".btn-danger", function() {
                var mensajeId = $(this).data('mensaje-id');
                borrarMensaje(mensajeId);
            });

            // Evento de clic en el botón "Ocultar"
            $(".messages-previos").on("click", ".btn-warning", function() {
                var mensajeId = $(this).data('mensaje-id');
                ocultarMensaje(mensajeId);
            });

            // Evento de clic en el botón "Mostrar"
            $(".messages-previos").on("click", ".btn-success", function() {
                var mensajeId = $(this).data('mensaje-id');
                mostrarMensaje(mensajeId);
            });

            // Evento de clic en el botón "Reportar"
            $(".messages-previos").on("click", ".btn-secondary", function() {
                var mensajeId = $(this).data('mensaje-id');
                reportarMensaje(mensajeId);
            });

            // Evento de clic en el botón "Quitar reporte"
            $(".messages-previos").on("click", ".btn-link", function() {
                var mensajeId = $(this).data('mensaje-id');
                quitarReporteMensaje(mensajeId);
            });
            
            
        });
        
        // Función para enviar una solicitud al servlet para borrar un mensaje
        function borrarMensaje(mensajeId) {
            $.ajax({
                type: "POST",
                url: "Chat",
                data: { accion: "borrar", mensajeId: mensajeId },
                success: function() {
                    cargarMensajes();
                },
                error: function() {
                    console.error("Error al borrar mensaje");
                }
            });
        }

        // Función para enviar una solicitud al servlet para ocultar un mensaje
        function ocultarMensaje(mensajeId) {
            $.ajax({
                type: "POST",
                url: "Chat",
                data: { accion: "ocultar", mensajeId: mensajeId },
                success: function() {
                    cargarMensajes();
                },
                error: function() {
                    console.error("Error al ocultar mensaje");
                }
            });
        }

        // Función para enviar una solicitud al servlet para mostrar un mensaje
        function mostrarMensaje(mensajeId) {
            $.ajax({
                type: "POST",
                url: "Chat",
                data: { accion: "mostrar", mensajeId: mensajeId },
                success: function() {
                    cargarMensajes();
                },
                error: function() {
                    console.error("Error al mostrar mensaje");
                }
            });
        }
        
        // Función para enviar una solicitud al servlet para reportar un mensaje
        function reportarMensaje(mensajeId) {
            $.ajax({
                type: "POST",
                url: "Chat",
                data: { accion: "reportar", mensajeId: mensajeId },
                success: function() {
					alert('Reportaste el mensaje.');
                    cargarMensajes();
                },
                error: function() {
                    console.error("Error al reportar mensaje");
                }
            });
        }

        // Función para enviar una solicitud al servlet para quitar reportar a un mensaje
        function quitarReporteMensaje(mensajeId) {
            $.ajax({
                type: "POST",
                url: "Chat",
                data: { accion: "quitar-reporte", mensajeId: mensajeId },
                success: function() {
					alert('Quitaste el reporte al mensaje.');
                    cargarMensajes();
                },
                error: function() {
                    console.error("Error al quitar el reporte del mensaje");
                }
            });
        }

        
        </script>
</body>
</html>
<%
    }
%>