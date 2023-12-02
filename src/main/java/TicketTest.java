import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import modelo.Ticket;

class TicketPruebas {

    @Test
    void testSetMatriculaVehiculo_ValidaMatriculaExitosa() {
        Ticket ticket = new Ticket(1, 1, "", "", "");
        ticket.setMatriculaVehiculo("AB12CD34");
        assertEquals("AB12CD34", ticket.getMatriculaVehiculo());
    }

    @Test
    void testSetMatriculaVehiculo_MatriculaInvalida_LanzaExcepcion() {
        Ticket ticket = new Ticket(1, 1, "", "", "");
        assertThrows(IllegalArgumentException.class, () -> {
            ticket.setMatriculaVehiculo("12345");
        });
    }

    @Test
    void testSetFecha_ValidaFechaExitosa() {
        Ticket ticket = new Ticket(1, 1, "", "", "");
        ticket.setFecha("31/12/2023");
        assertEquals("31/12/2023", ticket.getFecha());
    }

    @Test
    void testSetFecha_FechaInvalida_LanzaExcepcion() {
        Ticket ticket = new Ticket(1, 1, "", "", "");
        assertThrows(IllegalArgumentException.class, () -> {
            ticket.setFecha("2023/12/31");
        });
    }

    
    @Test
    void testSetHora_ValidaHoraExitosa() {
        Ticket ticket = new Ticket(1, 1, "", "", "");
        ticket.setHora("12:30");
        assertEquals("12:30", ticket.getHora());
    }

    @Test
    void testSetHora_HoraInvalida_LanzaExcepcion() {
        Ticket ticket = new Ticket(1, 1, "", "", "");
        assertThrows(IllegalArgumentException.class, () -> {
            ticket.setHora("12-30");
        });
    }
}
