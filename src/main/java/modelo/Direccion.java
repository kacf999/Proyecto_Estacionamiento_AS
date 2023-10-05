package modelo;

public class Direccion {
    private String calle;
    private String colonia;
    private String delegacion;
    private int numero;
    private int cp;

    public Direccion(String calle, String colonia, String delegacion, int numero, int cp) {
        this.calle = calle;
        this.colonia = colonia;
        this.delegacion = delegacion;
        this.numero = numero;
        this.cp = cp;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getColonia() {
        return colonia;
    }

    public void setColonia(String colonia) {
        this.colonia = colonia;
    }

    public String getDelegacion() {
        return delegacion;
    }

    public void setDelegacion(String delegacion) {
        this.delegacion = delegacion;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public int getCp() {
        return cp;
    }

    public void setCp(int cp) {
        this.cp = cp;
    }

    @Override
    public String toString() {
        return "Direccion{" +
                "calle='" + calle + '\'' +
                ", colonia='" + colonia + '\'' +
                ", delegacion='" + delegacion + '\'' +
                ", numero=" + numero +
                ", cp=" + cp +
                '}';
    }
}
