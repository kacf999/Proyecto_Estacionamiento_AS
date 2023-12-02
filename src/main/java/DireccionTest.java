import static org.junit.jupiter.api.Assertions.*;
import modelo.Direccion;
import org.junit.jupiter.api.Test;

public class DireccionTest {

    @Test
    void testSetCalle_ValidaCalleExitosa() {
        Direccion direccion = new Direccion("", "Colonia Prueba", "Delegación Prueba", 1, 12345);
        direccion.setCalle("Calle de Prueba 123");
        assertEquals("Calle de Prueba 123", direccion.getCalle());
    }

    @Test
    void testSetCalle_CalleInvalida_LanzaExcepcion() {
        Direccion direccion = new Direccion("", "Colonia Prueba", "Delegación Prueba", 1, 12345);
        assertThrows(IllegalArgumentException.class, () -> {
            direccion.setCalle("Calle %%%");
        });
    }

    @Test
    void testSetColonia_ValidaColoniaExitosa() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "", "Delegación Prueba", 1, 12345);
        direccion.setColonia("Colonia Prueba");
        assertEquals("Colonia Prueba", direccion.getColonia());
    }

    @Test
    void testSetColonia_ColoniaInvalida_LanzaExcepcion() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "", "Delegación Prueba", 1, 12345);
        assertThrows(IllegalArgumentException.class, () -> {
            direccion.setColonia("Colonia 123");
        });
    }

    @Test
    void testSetDelegacion_ValidaDelegacionExitosa() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "Colonia Prueba", "", 1, 12345);
        direccion.setDelegacion("Delegación Prueba");
        assertEquals("Delegación Prueba", direccion.getDelegacion());
    }

    @Test
    void testSetDelegacion_DelegacionInvalida_LanzaExcepcion() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "Colonia Prueba", "", 1, 12345);
        assertThrows(IllegalArgumentException.class, () -> {
            direccion.setDelegacion("Delegación 123");
        });
    }

    @Test
    void testSetNumero_ValidaNumeroExitoso() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "Colonia Prueba", "Delegación Prueba", 1, 12345);
        direccion.setNumero(5);
        assertEquals(5, direccion.getNumero());
    }

    @Test
    void testSetNumero_NumeroInvalido_LanzaExcepcion() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "Colonia Prueba", "Delegación Prueba", 1, 12345);
        assertThrows(IllegalArgumentException.class, () -> {
            direccion.setNumero(-10);
        });
    }

    @Test
    void testSetCp_ValidaCpExitoso() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "Colonia Prueba", "Delegación Prueba", 1, 0);
        direccion.setCp(12345);
        assertEquals(12345, direccion.getCp());
    }

    @Test
    void testSetCp_CpInvalido_LanzaExcepcion() {
        Direccion direccion = new Direccion("Calle de Prueba 123", "Colonia Prueba", "Delegación Prueba", 1, 0);
        assertThrows(IllegalArgumentException.class, () -> {
            direccion.setCp(123456);
        });
    }
}
