package modelo;

public class Propietario {
	private int id;
    private String nombre;
    private Direccion direccion;
    private String numeroTelefono;
    private String matricula;
    private boolean estudiante;
    private String contraseña;

    public String getContraseña() {
		return contraseña;
	}

	public void setContraseña(String contraseña) {
		this.contraseña = contraseña;
	}

	public Propietario(String nombre, String numeroTelefono, String matricula, boolean estudiante, Direccion direccion) {
        this.nombre = nombre;
        this.numeroTelefono = numeroTelefono;
        this.matricula = (estudiante) ? matricula : null;
        this.estudiante = estudiante;
        this.direccion = direccion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Direccion getDireccion() {
        return direccion;
    }

    public void setDireccion(Direccion direccion) {
        this.direccion = direccion;
    }

    public String getNumeroTelefono() {
        return numeroTelefono;
    }

    public void setNumeroTelefono(String numeroTelefono) {
        this.numeroTelefono = numeroTelefono;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = (estudiante) ? matricula : null;
    }

    public boolean isEstudiante() {
        return estudiante;
    }

    public void setEstudiante(boolean estudiante) {
        this.estudiante = estudiante;
        this.matricula = (estudiante) ? matricula : null;
    }

    @Override
    public String toString() {
        return "Propietario{" +
                "nombre='" + nombre + '\'' +
                ", direccion=" + direccion +
                ", numeroTelefono='" + numeroTelefono + '\'' +
                ", matricula='" + matricula + '\'' +
                ", estudiante=" + estudiante +
                '}';
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}


}
