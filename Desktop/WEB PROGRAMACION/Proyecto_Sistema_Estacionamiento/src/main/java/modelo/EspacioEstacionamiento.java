package modelo;

public class EspacioEstacionamiento {
    private int numero;
    private boolean estado;
    private String matricula;
    
    public EspacioEstacionamiento(int numero, boolean estado, String matricula) {
        this.numero = numero;
        this.estado=estado;
        this.matricula=matricula;
    }

    public String getMatricula() {
		return matricula;
	}

	public void setMatricula(String matricula) {
		this.matricula = matricula;
	}

	public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    @Override
    public String toString() {
        return "EspacioEstacionamiento{" +
                "numero=" + numero +
                ", estado=" + estado +
                '}';
    }
}
