<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="control.ProcesarFotografia" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Camara</title>

<style>

  body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: aquamarine;
        }
        
        .container {
            position: fixed;
            left: 50px;
            top: 100px;
        }
  
  .posicioncampos{
  position: fixed;
    left: 900px;
    top: 170px;
  }
  
  #clock {
            position: absolute;
            top: 10px;
            left: 10px;
            color: white;
            font-size: 24px;
        }

</style>

</head>

<body>

 <div class="container">
        <video id="webcam" width="640" height="480" autoplay></video>
        <canvas id="canvas" width="640" height="480" style="display:none;"></canvas>
        <button id="capturar">Capturar</button>
        <div id="clock"></div>
 </div>


<form action="ProcesarFotografia" method="post">
<div class="posicioncampos" id="posicioncampos">
  <label for="fecha">Fecha:</label>
  <input type="text" id="fecha"><br><br>
  
  <label for="matricula">Matricula:</label>
  <input type="text" id="matricula"><br><br>
  
  <input type="file" id="foto"><br><br>
  <input type="submit" value="GUARDAR"> 

</div>
  </form>
  
<script>
  
  const clock = document.getElementById("clock");
  const video = document.getElementById('webcam');
    const canvas = document.getElementById('canvas');
    const context = canvas.getContext('2d');
    const capturarBtn = document.getElementById('capturar');

    async function iniciarWebcam() {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ video: {} });
            video.srcObject = stream;
        } catch (error) {
            console.error('Error al iniciar la webcam:', error);
        }
    }

    capturarBtn.addEventListener('click', () => {
        context.drawImage(video, 0, 0, canvas.width, canvas.height);

        // Obtén la hora actual
        const ahora = new Date();
        const hora = ahora.toLocaleTimeString();

        // Dibuja la hora en el canvas
        context.font = '20px Arial';
        context.fillStyle = 'white';
        context.fillText(hora, 20, 30);

        // Convierte el canvas a una imagen
        const imagenDataUrl = canvas.toDataURL('image/png');

        // Crea un enlace de descarga para la imagen
        const enlaceDescarga = document.createElement('a');
        enlaceDescarga.href = imagenDataUrl;
        enlaceDescarga.download = 'foto_con_hora.png';
        enlaceDescarga.click();
    });

  
  function updateClock() {
        const now = new Date();
        const hours = now.getHours().toString().padStart(2, "0");
        const minutes = now.getMinutes().toString().padStart(2, "0");
        const seconds = now.getSeconds().toString().padStart(2, "0");
        clock.textContent = hours + ':' + minutes + ':' + seconds;
    }
  
  iniciarWebcam();
    setInterval(updateClock, 1000);
</script>

</body>
</html>