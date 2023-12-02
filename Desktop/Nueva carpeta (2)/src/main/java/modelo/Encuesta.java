package modelo;

public class Encuesta {

	private int id;
	private int idUsuario;
	private String comentarios;
	private String calificacion;
	private String fecha;
	private String nombreUsuario;

	public Encuesta(int id, int idUsuario, String nombreUsuario, String comentarios, String calificacion, String fecha) {
		this.id = id;
		this.idUsuario = idUsuario;
		this.nombreUsuario = nombreUsuario;
		this.comentarios = comentarios;
		this.calificacion = calificacion;
		this.fecha = fecha;
	}

	public String getNombreUsuario() {
		return nombreUsuario;
	}

	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getComentarios() {
		return comentarios;
	}

	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}

	public String getCalificacion() {
		return calificacion;
	}

	public void setCalificacion(String calificacion) {
		this.calificacion = calificacion;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

}

