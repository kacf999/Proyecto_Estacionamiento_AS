<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ver Todas las Imágenes</title>
    <link href="estilo.css" type="text/css" rel="stylesheet" />
   
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        img {
            display: block;
            margin: 0 auto;
        }

        .no-images {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Ver Todas las Imágenes</h1>

    <table>
        <tr>
            <th>#</th>
            <th>Fecha</th>
            <th>Matrícula</th>
            <th>Imagen</th>
        </tr>
        <% 
        ArrayList<modelo.Camara> imagenes = (ArrayList<modelo.Camara>) request.getAttribute("imagenes");
        ArrayList<String> imagenesBase64 = (ArrayList<String>) request.getAttribute("imagenesBase64");
        if (imagenes != null && !imagenes.isEmpty()) {
            for (int i = 0; i < imagenes.size(); i++) {
                modelo.Camara imagen = imagenes.get(i);
                String imagenBase64 = imagenesBase64.get(i);
        %>
            <tr>
                <td><%= imagen.getId() %></td>
                <td><%= imagen.getFecha() %></td>
                <td><%= imagen.getMatricula() %></td>
                <td>
                    <img src="data:image/jpeg;base64, <%= imagenBase64 %>" width="100" height="100">
                </td>
            </tr>
        <%
            }
        } else {
        %>
            <tr>
                <td colspan="3" class="no-images">No se encontraron imágenes.</td>
            </tr>
        <%
        }
        %>
    </table>
</body>
</html>
