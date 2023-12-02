   package control;

  import java.io.ByteArrayOutputStream;
  import java.io.IOException;
  import java.io.InputStream;
  import java.sql.SQLException;
  import java.sql.Date;
  import java.text.ParseException;
  import java.text.SimpleDateFormat;

  import javax.servlet.ServletException;
  import javax.servlet.annotation.WebServlet;
  import javax.servlet.annotation.MultipartConfig;
  import javax.servlet.http.HttpServlet;
  import javax.servlet.http.HttpServletRequest;
  import javax.servlet.http.HttpServletResponse;
  import javax.servlet.http.Part;
  import modelo.Camara;
  import java.util.Base64;

  @WebServlet(name = "ProcesarFotografia", urlPatterns = { "/ProcesarFotografia" })
  @MultipartConfig
  public class ProcesarFotografia extends HttpServlet {
	  private GuardarFotografia insertardatos;

      private static final long serialVersionUID = 1L;

      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          insertardatos = new GuardarFotografia();

          try {
              Part fechaPart = request.getPart("fecha");
              String fechaStr = convertPartToString(fechaPart);

              Part matriculaPart = request.getPart("matricula");
              String matricula = convertPartToString(matriculaPart);

              // Validar que la fecha cumpla con el formato "yyyy-MM-dd"
              SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
              Date fecha = null;

              try {
                  fecha = Date.valueOf(fechaStr);
              } catch (IllegalArgumentException e) {
                  System.out.println("Fecha incorrecta: " + fechaStr);
                  return;  // Sale del método doPost
              }

              Part filePart = request.getPart("foto");
              byte[] foto = convertInputStreamToByteArray(filePart.getInputStream());

              Camara datos = new Camara(0, fecha, matricula, foto);
              insertardatos.insertar(datos);

              // Guardar detalles en atributos de solicitud
              request.setAttribute("fecha", fecha);
              request.setAttribute("matricula", matricula);
              request.setAttribute("imagenBase64", Base64.getEncoder().encodeToString(foto));

              // Redirigir a la página de detalles
              request.getRequestDispatcher("detallesImagen.jsp").forward(request, response);
          } catch (NumberFormatException nfe) {
              // Manejar error de conversión de número si es necesario
          } catch (SQLException e) {
              e.printStackTrace();
              // Manejar excepciones de SQL
          }
      }

      private byte[] convertInputStreamToByteArray(InputStream inputStream) throws IOException {
          ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
          byte[] buffer = new byte[4096];
          int bytesRead;
          while ((bytesRead = inputStream.read(buffer)) != -1) {
              byteArrayOutputStream.write(buffer, 0, bytesRead);
          }
          return byteArrayOutputStream.toByteArray();
      }

      public String convertPartToString(Part part) throws IOException {
          if (part != null) {
              InputStream is = part.getInputStream();
              ByteArrayOutputStream os = new ByteArrayOutputStream();
              byte[] buffer = new byte[1024];
              int bytesRead;
              while ((bytesRead = is.read(buffer)) != -1) {
                  os.write(buffer, 0, bytesRead);
              }
              return os.toString("UTF-8");
          }
          return null;
      }
  }
