package modelo;

import java.time.LocalDate;

public class Notificacion {
    private int idPropietario;
    private String descripcion;
    private LocalDate fecha;
    private String hora;
    private String matriculaVehiculo;
    private int tipo;
    private int id;

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Notificacion(int idPropietario, String descripcion, LocalDate fecha, String hora, String matriculaVehiculo, int tipo) {
        this.idPropietario = idPropietario;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.hora = hora;
        this.matriculaVehiculo = matriculaVehiculo;
        this.tipo = tipo;
        this.id = id;
    }

    public int getIdPropietario() {
        return idPropietario;
    }

    public void setIdPropietario(int idPropietario) {
        this.idPropietario = idPropietario;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getMatriculaVehiculo() {
        return matriculaVehiculo;
    }

    public void setMatriculaVehiculo(String matriculaVehiculo) {
        this.matriculaVehiculo = matriculaVehiculo;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
}
