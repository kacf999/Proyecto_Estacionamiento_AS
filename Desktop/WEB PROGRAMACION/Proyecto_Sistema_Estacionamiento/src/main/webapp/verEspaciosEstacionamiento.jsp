<%@ page import="modelo.EspacioEstacionamiento"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ver estado de los espacios del estacionamiento</title>
<link rel="stylesheet" href="estilo.css">
<style>
/* Estilos para la matriz */
.matriz {
	display: grid;
	grid-template-columns: repeat(10, 1fr); /* Divide en 10 columnas */
	grid-gap: 10px;
	margin-top: 20px;
}

.espacio {
	text-align: center;
	font-weight: bold;
	position: relative;
	/* Permite posicionar elementos hijos de forma absoluta */
}

.espacio img {
	max-width: 100px;
	height: auto;
	position: relative;
}

.espacio::before {
	content: attr(data-numero); /* Muestra el número del cajón */
	position: absolute;
	top: 5px; /* Ajusta la posición vertical del número */
	left: 5px; /* Ajusta la posición horizontal del número */
	font-weight: bold;
	font-size: 16px;
	color: white;
	background-color: rgba(0, 0, 0, 0.5);
	/* Fondo semi-transparente para legibilidad */
	padding: 2px 4px;
	border-radius: 4px;
	z-index: 1;
	opacity: 0; /* Inicialmente oculto */
	transition: opacity 0.3s; /* Transición de opacidad */
}

.espacio:hover::before {
	opacity: 1; /* Mostrar el número al pasar el cursor */
}

.espacio::after {
	content: attr(data-matricula);
	/* Muestra la matrícula al pasar el cursor */
	position: absolute;
	bottom: 5px; /* Ajusta la posición vertical de la matrícula */
	left: 5px; /* Ajusta la posición horizontal de la matrícula */
	font-weight: bold;
	font-size: 16px;
	color: white;
	background-color: rgba(0, 0, 0, 0.7);
	/* Fondo semi-transparente para legibilidad */
	padding: 2px 4px;
	border-radius: 4px;
	z-index: 1;
	opacity: 0; /* Inicialmente oculto */
	transition: opacity 0.3s; /* Transición de opacidad */
}

.espacio:hover::after {
	opacity: 1; /* Mostrar la matrícula al pasar el cursor */
}

/* Estilos para la leyenda */
.leyenda {
	text-align: center;
	margin-top: 20px;
}

.leyenda-item {
	display: inline-block;
	margin: 0 20px;
}

/* Estilos para el reloj */
.reloj {
	position: fixed;
	top: 10px;
	right: 10px;
	background-color: rgba(0, 0, 0, 0.7);
	color: white;
	padding: 5px;
	border-radius: 5px;
	font-size: 16px;
}
</style>
</head>
<body>

	<!-- Agregar reloj en un recuadro bonito -->
	<div class="reloj">
		<span id="fechaHora"></span>
	</div>

	<h1>Ver estado de los espacios del estacionamiento</h1>
	<form action="BuscarEspaciosEstacionamiento" method="post">
		<br>
		<br> <input type="submit" value="Buscar ahora">
	</form>
	<form action="menuPrincipal.jsp" method="post">
		<input type="submit" value="Menu Principal">
	</form>
	<!-- Agregar leyenda -->
	<div class="leyenda">
		<div class="leyenda-item">
			<img src="imagenes/cajones/cajon-ocupado.png" alt="Ocupado" width="50" height="50">
			Ocupado
		</div>
		<div class="leyenda-item">
			<img src="imagenes/cajones/cajon-disponible.png" alt="Disponible" width="50" height="50">
			Disponible
		</div>
	</div>
	<div>
		<label for="espaciosSelector">Ver Espacios:</label> <select
			id="espaciosSelector" onchange="filtrarEspacios()">
			<option value="todos">Todos</option>
			<option value="libres">Espacios Libres</option>
			<option value="ocupados">Espacios Ocupados</option>
		</select>
	</div>
	<%
        boolean espaciosEncontrados = (request.getAttribute("espaciosEncontrados") != null) ? (boolean) request.getAttribute("espaciosEncontrados") : false;
        if (espaciosEncontrados) {
            List<EspacioEstacionamiento> espacios = (List<EspacioEstacionamiento>) request.getAttribute("espacios");
    %>
	<h2>Espacios Encontrados</h2>
	<div class="matriz">
		<%
        for (int i = 0; i < espacios.size(); i++) {
        %>
		<div
			class="espacio <%= espacios.get(i).isEstado() ? "ocupado" : "libre" %>"
			data-numero="<%= espacios.get(i).getNumero() %>"
			data-matricula="<%= (espacios.get(i).getMatricula() != null) ? "Matrícula: " + espacios.get(i).getMatricula() : "NO HAY VEHÍCULO" %>">
			<!-- Agregar imágenes según el estado -->
			<img
				src="<%= espacios.get(i).isEstado() ? "imagenes/cajones/cajon-ocupado.png" : "imagenes/cajones/cajon-disponible.png" %>"
				alt="<%= espacios.get(i).isEstado() ? "Ocupado" : "Libre" %>">
		</div>
		<%
        }
        %>
		<!-- Agregar áreas en blanco con bordes -->
		<%
        int espaciosFaltantes = 10 - (espacios.size() % 10);
        for (int j = 0; j < espaciosFaltantes; j++) {
        %>
		<div class="vacio"></div>
		<%
        }
        %>
	</div>
	<script>
        function filtrarEspacios() {
            const espacios = document.querySelectorAll(".espacio");
            const espaciosSelector = document.getElementById("espaciosSelector").value;

            espacios.forEach((espacio) => {
                if (espaciosSelector === "todos" || (espaciosSelector === "ocupados" && espacio.classList.contains("ocupado"))) {
                    espacio.style.display = "block";
                } else if (espaciosSelector === "libres" && !espacio.classList.contains("ocupado")) {
                    espacio.style.display = "block";
                } else {
                    espacio.style.display = "none";
                }
            });
        }

        function actualizarReloj() {
            const fechaHoraElement = document.getElementById("fechaHora");
            const ahora = new Date();
            const fechaHoraFormato = ahora.toLocaleString("es-ES", { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' });
            fechaHoraElement.innerText = fechaHoraFormato;
        }

        setInterval(actualizarReloj, 1000);
    </script>
	<%
    } else {
    %>
	<h2>Espacios NO Encontrados</h2>
	<div>
		<p>No se encontraron espacios de estacionamiento.</p>
	</div>
	<form action="menuPrincipal.jsp" method="post">
		<input type="submit" value="Menu Principal">
	</form>
	<%
    }
    %>
</body>
</html>
