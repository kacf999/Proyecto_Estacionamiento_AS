<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Panel de encuesta de satisfacción de servicio de
	estacionamiento - UACM</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- Custom CSS -->
<style>
body {
	padding-top: 56px;
}

.encuesta-table {
	margin-top: 20px;
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
	<div class="container">
		<h2 class="mt-4 mb-4">Panel de Encuestas</h2>

		<div class="table-responsive encuesta-table">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>ID Encuesta</th>
						<th>ID Usuario</th>
						<th>Nombre Usuario</th>
						<th>Calificación</th>
						<th>Comentarios</th>
						<th>Fecha</th>
					</tr>
				</thead>
				<tbody id="encuesta-table-body">
					<!-- Aquí se insertarán los registros de las encuestas con AJAX -->
				</tbody>
			</table>
		</div>

		<!-- Botón para exportar a Excel -->
		<!--  <button onclick="exportarExcel()">Exportar a Excel</button>-->
	</div>

	<!-- Bootstrap JS y Popper.js -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

	<!-- Script para exportar a Excel -->
	<script>
        function exportarExcel() {
            // Obtener los datos de la tabla
            var data = [];
            $('#encuesta-table-body tr').each(function(row, tr) {
                data[row] = [
                    $(tr).find('td:eq(0)').text(),
                    $(tr).find('td:eq(1)').text(),
                    $(tr).find('td:eq(2)').text(),
                    $(tr).find('td:eq(3)').text(),
                    $(tr).find('td:eq(4)').text(),
                    $(tr).find('td:eq(5)').text()
                ];
            });

            // Crear un objeto de libro
            var ws_name = "Encuestas";
            var wb = XLSX.utils.book_new();
            var ws = XLSX.utils.aoa_to_sheet([["ID Encuesta", "ID Usuario", "Nombre Usuario", "Calificación", "Comentarios", "Fecha"]].concat(data));
            XLSX.utils.book_append_sheet(wb, ws, ws_name);

            // Descargar el archivo Excel
            XLSX.writeFile(wb, 'encuestas.xlsx');
        }

        // Función para obtener y mostrar las encuestas en tiempo real con AJAX
        function obtenerEncuestas() {
            $.ajax({
                type: 'GET',
                url: 'AlmacenarEncuesta',
                dataType: 'json',
                success: function (data) {
                    // Limpiar la tabla
                    $('#encuesta-table-body').empty();

                    // Agregar filas a la tabla con los datos obtenidos
                    $.each(data, function (index, encuesta) {
                        var row = '<tr>' +
                            '<td>' + encuesta.id + '</td>' +
                            '<td>' + encuesta.idUsuario + '</td>' +
                            '<td>' + encuesta.nombreUsuario + '</td>' +
                            '<td>' + encuesta.calificacion + '</td>' +
                            '<td>' + encuesta.comentarios + '</td>' +
                            '<td>' + encuesta.fecha + '</td>' +
                            '</tr>';

                        $('#encuesta-table-body').append(row);
                    });
                },
                error: function () {
                    console.error('Error al obtener las encuestas.');
                }
            });
        }

        // Llamar a la función al cargar la página y cada cierto intervalo de tiempo (por ejemplo, cada 5 segundos)
        $(document).ready(function () {
            obtenerEncuestas();
            setInterval(obtenerEncuestas, 2000); // Actualizar cada 2 segundos
        });
    </script>
	<!-- Agrega el botón para regresar al menú principal -->
	<div class="text-center mt-3">
		<a href="menuPrincipal.jsp" class="btn btn-secondary">Regresar al
			Menú Principal</a>
	</div>
</body>
</html>
	<%
	}
	%>
