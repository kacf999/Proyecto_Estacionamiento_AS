package modelo;

public class Vehiculo {
    private int propietario;
    private String modelo;
    private String marca;
    private String color;
    private String matricula;

    public Vehiculo(int propietario, String modelo, String marca, String color, String matricula) {
        this.propietario = propietario;
        this.modelo = modelo;
        this.marca = marca;
        this.color = color;
        this.matricula = matricula;
    }

    public int getPropietario() {
		return propietario;
	}

	public void setPropietario(int propietario) {
		this.propietario = propietario;
	}

	public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    @Override
    public String toString() {
        return "Vehiculo{" +
                "propietario=" + propietario +
                ", modelo='" + modelo + '\'' +
                ", marca='" + marca + '\'' +
                ", color='" + color + '\'' +
                ", matricula='" + matricula + '\'' +
                '}';
    }
}
