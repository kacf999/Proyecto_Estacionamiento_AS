<%@ page import="modelo.Ticket"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Exportar a Excel</title>
<link rel="stylesheet" href="estilo.css">

<script>
        var tableToExcel = (function () {
            var uri = 'data:application/vnd.ms-excel;base64,'
                , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
                , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
                , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
            return function (table, name) {
                if (!table.nodeType) table = document.getElementById(table)
                var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
                window.location.href = uri + base64(format(template, ctx))
            }
        })()
    </script>
</head>
<body>
	<h1>Exportar a Excel</h1>

	<p>Registro detallado de tickets.</p>
	<div>
		<form action="menuPrincipal.jsp" method="post">
			<input type="submit" class="btn btn-primary btn-large"
				value="Menu Principal">
		</form>
	</div>

	<input type="button"
		onclick="tableToExcel('ticketsTable', 'RegistrosTickets')"
		value="Exportar a Excel">

	<table id="ticketsTable" summary="Registros de Tickets" border="1">
		<thead>
			<tr>
				<th>ID del ticket</th>
				<th>Cajón utilizado</th>
				<th>Matricula del vehículo</th>
				<th>Fecha</th>
				<th>Hora</th>
				<th>Visitas</th>
			</tr>
		</thead>
		<tbody>
			<%
            Object ticketsData = session.getAttribute("tickets");
            if (ticketsData != null) {
                List<Ticket> tickets = (List<Ticket>) ticketsData;

                // Crear un mapa para realizar un seguimiento de las matrículas y contar sus visitas
                Map<String, Integer> matriculaVisitas = new HashMap<String, Integer>();
                Map<String, Integer> fechaCount = new HashMap<String, Integer>();
                Map<String, Integer> horaCount = new HashMap<String, Integer>();
                
                for (Ticket ticket : tickets) {
            %>
			<tr>
				<td><%= ticket.getId() %></td>
				<td><%= ticket.getCajon() %></td>
				<td><%= ticket.getMatriculaVehiculo() %></td>
				<td><%= ticket.getFecha() %></td>
				<td><%= ticket.getHora() %></td>
				<%
                    String matricula = ticket.getMatriculaVehiculo();
                    String fecha = ticket.getFecha();
                    String hora = ticket.getHora();
                    if (matriculaVisitas.containsKey(matricula)) {
                        matriculaVisitas.put(matricula, matriculaVisitas.get(matricula) + 1);
                    } else {
                        matriculaVisitas.put(matricula, 1);
                    }
                    int visitas = matriculaVisitas.get(matricula);
                    
                    if (fechaCount.containsKey(fecha)) {
                        fechaCount.put(fecha, fechaCount.get(fecha) + 1);
                    } else {
                        fechaCount.put(fecha, 1);
                    }
                    int visitasFecha = fechaCount.get(fecha);
                    
                    if (horaCount.containsKey(hora)) {
                        horaCount.put(hora, horaCount.get(hora) + 1);
                    } else {
                        horaCount.put(hora, 1);
                    }
                    int visitasHora = horaCount.get(hora);
                    %>
				<td <% if (visitas > 1) { %> style="color: red;" <% } %>><%= visitas %></td>
			</tr>
			<%
                }
                
                // Determinar la fecha más visitada
                String fechaMasVisitada = null;
                int maxVisitasFecha = 0;
                for (Map.Entry<String, Integer> entry : fechaCount.entrySet()) {
                    if (entry.getValue() > maxVisitasFecha) {
                        fechaMasVisitada = entry.getKey();
                        maxVisitasFecha = entry.getValue();
                    }
                }

                // Determinar la hora más concurrida
                String horaMasConcurrida = null;
                int maxVisitasHora = 0;
                for (Map.Entry<String, Integer> entry : horaCount.entrySet()) {
                    if (entry.getValue() > maxVisitasHora) {
                        horaMasConcurrida = entry.getKey();
                        maxVisitasHora = entry.getValue();
                    }
                }
                %>
			<% if (fechaMasVisitada != null){%>
			<tr>
				<td colspan="5">Fecha más visitada: <%= fechaMasVisitada %>
					(Visitas: <%= maxVisitasFecha %>)
				</td>
			</tr>
			<%
                }
            %>
			<% if (horaMasConcurrida != null) {%>
			<tr>
				<td colspan="5">Hora más concurrida: <%= horaMasConcurrida %>
					(Visitas: <%= maxVisitasHora %>)
				</td>
			</tr>
			<%
                }
            %>
			<%
                } else {
            %>
			<th>No hay registros.</th>
			<%
                }
            %>
		</tbody>
	</table>
</body>
</html>
