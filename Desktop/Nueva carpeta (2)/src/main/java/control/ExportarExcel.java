package control;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import modelo.Ticket;

@WebServlet("/ExportarExcel")
public class ExportarExcel extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtiene la lista real de registros desde el JSP
        List<Ticket> registros = (List<Ticket>) request.getAttribute("tickets");

        // Crea un nuevo libro de trabajo de Excel
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Registros");

        // Crea una fila de encabezado
        XSSFRow headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("ID del Ticket");
        headerRow.createCell(1).setCellValue("Cajón de Estacionamiento");
        headerRow.createCell(2).setCellValue("Matrícula del Vehículo");
        headerRow.createCell(3).setCellValue("Fecha");
        headerRow.createCell(4).setCellValue("Hora");

        // Agrega los datos de tus registros al libro de trabajo
        int rowNum = 1;
        for (Ticket ticket : registros) {
            XSSFRow row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(ticket.getId());
            row.createCell(1).setCellValue(ticket.getCajon());
            row.createCell(2).setCellValue(ticket.getMatriculaVehiculo());
            row.createCell(3).setCellValue(ticket.getFecha());
            row.createCell(4).setCellValue(ticket.getHora());
        }

        // Genera el archivo Excel y envíalo al navegador
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=registros.xlsx");

        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.close();
    }
}
