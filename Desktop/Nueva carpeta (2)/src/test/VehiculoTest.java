import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import modelo.Vehiculo;/**
 * 
 */

class VehiculoTest {

	/**
	 * @throws java.lang.Exception
	 */
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		System.out.println("INICIANDO TEST");
	}

    @Test
    public void testValidarMatricula_MatriculaValida_DeberiaRetornarTrue() {
        // Arrange
        String matricula = "AB-1234";

        // Act
        boolean resultado = Vehiculo.validarMatricula(matricula);

        // Assert
        Assertions.assertTrue(resultado);
    }

    @Test
    public void testValidarMatricula_MatriculaInvalida_DeberiaRetornarFalse() {
        // Arrange
        String matricula = "ABC-12345";

        // Act
        boolean resultado = Vehiculo.validarMatricula(matricula);

        // Assert
        Assertions.assertFalse(resultado);
    }

    @Test
    public void testValidarMatricula_FormatoInvalido_DeberiaRetornarFalse() {
        // Arrange
        String matricula = "ABC1234";

        // Act
        boolean resultado = Vehiculo.validarMatricula(matricula);

        // Assert
        Assertions.assertFalse(resultado);
    }

    @Test
    public void testValidarMatricula_MatriculaNula_DeberiaRetornarFalse() {
        // Arrange
        String matricula = null;

        // Act
        boolean resultado = Vehiculo.validarMatricula(matricula);

        // Assert
        Assertions.assertFalse(resultado);
    }

    @Test
    public void testValidarMatricula_MatriculaVacia_DeberiaRetornarFalse() {
        // Arrange
        String matricula = "";

        // Act
        boolean resultado = Vehiculo.validarMatricula(matricula);

        // Assert
        Assertions.assertFalse(resultado);
    }
	
	/**
	 * @throws java.lang.Exception
	 */
	@AfterAll
	static void tearDownAfterClass() throws Exception {
		System.out.println("TERMINANDO TEST");
	}

}
