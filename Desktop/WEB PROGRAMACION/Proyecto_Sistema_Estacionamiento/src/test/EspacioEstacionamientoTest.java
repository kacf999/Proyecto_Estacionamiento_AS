import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

public class EspacioEstacionamientoTest {

    @Test
    void testSetNumero_ValidaNumeroExitoso() {
        EspacioEstacionamiento espacio = new EspacioEstacionamiento(1, true, "");
        espacio.setNumero(5);
        assertEquals(5, espacio.getNumero());
    }

    @Test
    void testSetNumero_NumeroInvalido_LanzaExcepcion() {
        EspacioEstacionamiento espacio = new EspacioEstacionamiento(1, true, "");
        assertThrows(IllegalArgumentException.class, () -> {
            espacio.setNumero(10.5);
        });
    }

    @Test
    void testSetEstado_ValidaEstadoExitoso() {
        EspacioEstacionamiento espacio = new EspacioEstacionamiento(1, true, "");
        espacio.setEstado(false);
        assertFalse(espacio.isEstado());
    }

    @Test
    void testSetEstado_EstadoInvalido_LanzaExcepcion() {
        EspacioEstacionamiento espacio = new EspacioEstacionamiento(1, true, "");
        assertThrows(IllegalArgumentException.class, () -> {
            espacio.setEstado("activo");
        });
    }

    @Test
    void testToString() {
        EspacioEstacionamiento espacio = new EspacioEstacionamiento(1, true, "AB12CD34");
        String expectedString = "EspacioEstacionamiento{numero=1, estado=true, matricula='AB12CD34'}";
        assertEquals(expectedString, espacio.toString());
    }
}
