package modelo;

public class Ticket {
    private int id;
    private int cajon;
    private String matriculaVehiculo;
    private String fecha;
    private String hora;

    public Ticket(int id, int cajon, String matriculaVehiculo, String fecha, String hora) {
        this.id = id;
        this.cajon = cajon;
        this.matriculaVehiculo = matriculaVehiculo;
        this.fecha = fecha;
        this.hora = hora;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCajon() {
        return cajon;
    }

    public void setCajon(int cajon) {
        this.cajon = cajon;
    }

    public String getMatriculaVehiculo() {
        return matriculaVehiculo;
    }

    public void setMatriculaVehiculo(String matriculaVehiculo) {
        this.matriculaVehiculo = matriculaVehiculo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    @Override
    public String toString() {
        return "Ticket{" +
                "id=" + id +
                ", cajon=" + cajon +
                ", matriculaVehiculo='" + matriculaVehiculo + '\'' +
                ", fecha='" + fecha + '\'' +
                ", hora='" + hora + '\'' +
                '}';
    }
}
