package modelo;

import java.util.Date;

public class Camara {

	int id;
    private Date fecha;
    private String matricula;
    private byte[] foto;
    private String imagenBase64;

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Camara(int id, Date fecha, String matricula, byte[] foto) {
    	this.id = id;
        this.fecha = fecha;
        this.matricula = matricula;
        this.foto = foto;
    }
    
	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public String getMatricula() {
		return matricula;
	}

	public void setMatricula(String matricula) {
		this.matricula = matricula;
	}

	public byte[] getFoto() {
		return foto;
	}

    // Otros getters y setters

    public String getImagenBase64() {
        return imagenBase64;
    }

    public void setImagenBase64(String imagenBase64) {
        this.imagenBase64 = imagenBase64;
    }
    
	public void setFoto(byte[] foto) {
		this.foto = foto;
	}

}