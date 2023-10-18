<%@ page import="modelo.Ticket" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Estadísticas</title>
    <link rel="stylesheet" href="estilo.css">
    <!-- Biblioteca Chart.js para insertar gráficos -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
    <style>
        /* Estilo para ajustar el tamaño de la gráfica */
        canvas {
            max-width: 800px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <h1>Buscar Ticket</h1>
    <form action="EstadisticasTicket" method="post">
        <label>Matrícula del vehículo:</label>
        <input type="text" name="matricula">
        <br><br>
        <label>Fecha:</label>
        <input type="date" name="fechaInicio" placeholder="Fecha Inicial">
        <input type="date" name="fechaFin" placeholder="Fecha Final">
        <br><br>
        <label>Hora:</label>
        <input type="time" name="hora">
        <br><br>
        <input type="submit" class="btn btn-primary btn-large" value="Buscar">
    </form>
    <!-- Si se encontraron tickets, mostrar formulario de gestión de tickets -->
    <% if (request.getAttribute("ticketsEncontrados") != null) {
        boolean ticketsEncontrados = (boolean) request.getAttribute("ticketsEncontrados");
        if (ticketsEncontrados) {
            List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
    %>
    <h2>Gráfico de Estadísticas de Estacionamiento</h2>
    <canvas id="miGrafico" height="300"></canvas>

    <script>
        var ticketsData = [];
        var backgroundColors = [];

        <% for (Ticket ticket : tickets) { %>
            var ticketData = {
                id: <%= ticket.getId() %>,
                cajon: <%= ticket.getCajon() %>,
                matriculaVehiculo: '<%= ticket.getMatriculaVehiculo() %>',
                fecha: '<%= ticket.getFecha() %>',
                hora: '<%= ticket.getHora() %>'
            };
            ticketsData.push(ticketData);

            // Generar un color aleatorio
            var randomColor = 'rgba(' + Math.floor(Math.random() * 256) + ',' + Math.floor(Math.random() * 256) + ',' + Math.floor(Math.random() * 256) + ', 0.2)';
            backgroundColors.push(randomColor);
        <% } %>

        var ctx = document.getElementById('miGrafico').getContext('2d');
        var labels = ticketsData.map(function(ticket) {
            return 'Cajón: ' + ticket.cajon + '\n' + ticket.fecha + ' | ' + ticket.hora + '\nMatrícula: ' + ticket.matriculaVehiculo;
        });
        var data = ticketsData.map(function(ticket) { return ticket.id; });

        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    label: 'ID del ticket',
                    data: data,
                    backgroundColor: backgroundColors,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    </script>

    <%
        // Agrega la lista de tickets como un atributo en la sesión
        session.setAttribute("tickets", tickets);
    %>

    <form action="exportarExcel.jsp" method="get">
        <input type="hidden" name="export" value="true">
        <input type="submit" class="btn btn-primary" value="Exportar a Excel">
    </form>

    <h2>Tickets Encontrados</h2>
    <h1>Cantidad de Registros: <%= tickets.size() %> </h1>
    <div>
        <h3>Datos obtenidos por última visita:</h3>
        <ul>
            <% for (Ticket ticket : tickets) { %>
            <li>ID del ticket: <%= ticket.getId() %></li>
            <li>Número de cajón de estacionamiento: <%= ticket.getCajon() %></li>
            <li>Matrícula del vehículo: <%= ticket.getMatriculaVehiculo() %></li>
            <li>Fecha y hora: <%= ticket.getFecha() %> | <%= ticket.getHora() %></li>
            <hr>
            <% } %>
        </ul>
    </div>
    <% } else { %>
    <h2>Sin resultados.</h2>
    <% } }
    %>

    <script>
        function exportToExcel() {
            // Redirigir al JSP de exportación
            location.href = "exportarExcel.jsp?export=true";
        }
    </script>
</body>
</html>
