package modelo;

public class ReglaEstacionamiento {
	private TiempoTicket HoraActual;
	private String horaTicket;
	private String fechaTicket;
	
	public ReglaEstacionamiento(String horaTicket, String fechaTicket) {
		HoraActual = new TiempoTicket();
		this.horaTicket = horaTicket;
		this.fechaTicket = fechaTicket;
	}
	
	public boolean VerificarReglas() {
		if(VerificarFecha() == true && VerificarHora() == true) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean VerificarFecha(){
		String[] fecha = fechaTicket.split("/");
		int dia = Integer.parseInt(HoraActual.getDia());
		int diaTicket = Integer.parseInt(fecha[0]);
		
		int mes = Integer.parseInt(HoraActual.getMes());
		int mesTicket = Integer.parseInt(fecha[1]);
		//verifica el dia
		if(diaTicket == dia) {
			//verifica el mes
			if(mesTicket == mes) {
				return true;
			}else
				return false;
		}else
			return false;
	}
	
	public boolean VerificarHora() {
		String[] tiempo = horaTicket.split(":");
		int horaTicket = Integer.parseInt(tiempo[0]);
		int minutoTicket = Integer.parseInt(tiempo[1]);
		boolean horaPermitida = false;
		
		//Se verifica a que el vehiculo haya ingresado despues de las 6 am 
		if(horaTicket > 6){
			horaPermitida = true;
		}
		
		//se verifica que el auto haya ingresado despues de las 6:45
		if(horaTicket == 6){
			if(minutoTicket > 45) {
				horaPermitida = true;
			}else {
				horaPermitida = false;
			}	
		}

		return horaPermitida;
	}
	
}
