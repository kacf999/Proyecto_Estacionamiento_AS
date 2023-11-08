<%@ page import="modelo.EspacioEstacionamiento" %>
<%@ page import="java.util.List" %>
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
            position: relative; /* Permite posicionar elementos hijos de forma absoluta */
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
            background-color: rgba(0, 0, 0, 0.5); /* Fondo semi-transparente para legibilidad */
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
            content: attr(data-matricula); /* Muestra la matrícula al pasar el cursor */
            position: absolute;
            bottom: 5px; /* Ajusta la posición vertical de la matrícula */
            left: 5px; /* Ajusta la posición horizontal de la matrícula */
            font-weight: bold;
            font-size: 16px;
            color: white;
            background-color: rgba(0, 0, 0, 0.7); /* Fondo semi-transparente para legibilidad */
            padding: 2px 4px;
            border-radius: 4px;
            z-index: 1;
            opacity: 0; /* Inicialmente oculto */
            transition: opacity 0.3s; /* Transición de opacidad */
        }

        .espacio:hover::after {
            opacity: 1; /* Mostrar la matrícula al pasar el cursor */
        }

        /* Resto de estilos igual que en el código anterior */

    </style>
</head>
<body>
    <h1>Ver estado de los espacios del estacionamiento</h1>
    <form action="BuscarEspaciosEstacionamiento" method="post">
        <br><br>
        <input type="submit" value="Buscar ahora">
    </form>
    <form action="menuPrincipal.jsp" method="post">
        <input type="submit" value="Menu Principal">
    </form>
    <%
        boolean espaciosEncontrados = (request.getAttribute("espaciosEncontrados") != null) ? (boolean) request.getAttribute("espaciosEncontrados") : false;
        if (espaciosEncontrados) {
            List<EspacioEstacionamiento> espacios = (List<EspacioEstacionamiento>) request.getAttribute("espacios");
    %>
    <h2>Espacios Encontrados </h2>
    <div class="matriz">
        <%
        for (int i = 0; i < espacios.size(); i++) {
        %>
            <div class="espacio <%= espacios.get(i).isEstado() ? "ocupado" : "libre" %>"
                 data-numero="<%= espacios.get(i).getNumero() %>"
                 data-matricula="<%= (espacios.get(i).getMatricula() != null) ? "Matrícula: " + espacios.get(i).getMatricula() : "NO HAY VEHÍCULO" %>">
                <img src="<%= espacios.get(i).isEstado() ? "imagenes/cajones/cajon-ocupado.png" : "imagenes/cajones/cajon-disponible.png" %>" alt="<%= espacios.get(i).isEstado() ? "Ocupado" : "Libre" %>">
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
        // Función para mostrar/ocultar información al hacer clic en el botón
        const mostrarInfo = document.querySelectorAll(".mostrar-info");
        mostrarInfo.forEach((boton, index) => {
            const infoOculta = document.querySelectorAll(".info-oculta")[index];
            boton.addEventListener("click", () => {
                const matricula = infoOculta.querySelector(".matricula");
                infoOculta.style.display = infoOculta.style.display === "none" ? "block" : "none";
                matricula.style.display = matricula.style.display === "none" ? "inline" : "none";
            });
        });
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