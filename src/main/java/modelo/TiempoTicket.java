package modelo;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TiempoTicket {
	private String anio;
	private String mes;
	private String dia;
	private String hora;
	private String minuto;
	
	public TiempoTicket() {
		// Obtener la fecha y hora actual
	    LocalDateTime fechaHoraActual = LocalDateTime.now();
	    // Obtener la fecha por separado
	    this.anio = String.valueOf(fechaHoraActual.getYear());
	    this.mes = String.valueOf(fechaHoraActual.getMonthValue());
	    this.dia = String.valueOf(fechaHoraActual.getDayOfMonth());

	    // Obtener la hora por separado
	    this.hora = String.valueOf(fechaHoraActual.getHour());
	    this.minuto = String.valueOf(fechaHoraActual.getMinute());
	    
	}

	public String getAnio() {
		return anio;
	}

	public void setAnio(String anio) {
		this.anio = anio;
	}

	public String getMes() {
		return mes;
	}

	public void setMes(String mes) {
		this.mes = mes;
	}

	public String getDia() {
		return dia;
	}

	public void setDia(String dia) {
		this.dia = dia;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public String getMinuto() {
		return minuto;
	}

	public void setMinuto(String minuto) {
		this.minuto = minuto;
	}
    
	public String ObtenerHora() {
		String hora = ""+this.hora+":"+this.minuto;
		return hora;
	}
	
	public String ObtenerFecha() {
		String fecha = ""+this.dia+"/"+this.mes+"/"+this.anio;
		return fecha;
	}
}
