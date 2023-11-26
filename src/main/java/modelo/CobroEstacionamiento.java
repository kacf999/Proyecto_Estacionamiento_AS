package modelo;

public class CobroEstacionamiento {
	private TiempoTicket HoraActual;
	private Ticket ticket;
	private int cobroBase = 5;
	private int cobroHora = 5;
	private int tarifa = 0;
	private ReglaEstacionamiento reglas;
	
	public CobroEstacionamiento(Ticket ticket) {
		HoraActual = new TiempoTicket();
		this.ticket = ticket;
		reglas = new ReglaEstacionamiento(ticket.getHora(), ticket.getFecha());
	}
	
	public String calcularTarifa() {
		int hora = Integer.valueOf(HoraActual.getHora());
		int minutos = Integer.valueOf(HoraActual.getMinuto());
		
		String[] tiempo = ticket.getHora().split(":");
		int horaTicket = Integer.parseInt(tiempo[0]);
		int minutoTicket = Integer.parseInt(tiempo[1]);
		
		tarifa = tarifa + cobroBase;
		tarifa = tarifa + (cobroHora * (hora - horaTicket));
		
		String tarifaPago = "Se deben pagar: "+tarifa;
		
		if(reglas.VerificarReglas() == false) {
			tarifaPago = "Existe un problema, ha incumplido con las reglas del estacionamiento";
		}
		
		return tarifaPago;
		
	}
}
