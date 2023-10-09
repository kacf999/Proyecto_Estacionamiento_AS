package modelo;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class CodigoQR {
	String informacion = "";
	String nombreArchivo = "";
	
	public CodigoQR(String informacion) {
		this.informacion = informacion;
	}
	
	public void generarQr() {
		int size = 500;
		String fileType = "jpg";
		String codigo = informacion;
		//elegir la ruta del qr
		String filePath = "C:\\Users\\KEVIN\\eclipse-workspace\\Proyecto_Estacionamiento_AS\\src\\main\\webapp\\codigosQR";
		//generar el nombre
		UUID uuid = UUID.randomUUID();
		String randomName = uuid.toString();
		
		
		//generar el qr
		QRCodeWriter qrcode = new QRCodeWriter();
		try {
			BitMatrix matrix = qrcode.encode(codigo, BarcodeFormat.QR_CODE, size, size);
			int matrixWidth = matrix.getWidth();
			
			BufferedImage image = new BufferedImage(matrixWidth, matrixWidth, BufferedImage.TYPE_INT_RGB);
			image.createGraphics();
			
			Graphics2D gd = (Graphics2D) image.getGraphics(); 
			gd.setColor(Color.WHITE);
			gd.fillRect(0, 0, size, size);
			gd.setColor(Color.black);
			
			for(int b = 0; b < matrixWidth; b++) {
				for(int j = 0; j < matrixWidth; j++) {
					if(matrix.get(b, j)){
						gd.fillRect(b, j, 1, 1);
					}
				}
			}
			
			// Guardar la imagen en el archivo
            File f = new File(filePath + "/" + randomName + "." + fileType);
            nombreArchivo = filePath + "/" + randomName + "." + fileType;
            try {
                ImageIO.write(image, fileType, f);
                System.out.println("QR Code guardado en: " + f.getAbsolutePath());
            } catch (IOException e) {
                System.err.println("Error al guardar el QR Code: " + e.getMessage());
            }
            
		} catch (WriterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String getNombreArchivo() {
		return nombreArchivo;
	}
	
}
