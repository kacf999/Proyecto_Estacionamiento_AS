import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import modelo.Direccion;
import modelo.Propietario;

class PropietarioTest {

    @Test
    void setNombre_NombreValido_DeberiaEstablecerNombreCorrectamente() {
        // Arrange
        Propietario propietario = new Propietario(null, null, null, false, null);
        String nombre = "John Doe";

        // Act
        propietario.setNombre(nombre);

        // Assert
        Assertions.assertEquals(nombre, propietario.getNombre());
    }

    @Test
    void setNombre_NombreInvalido_DeberiaLanzarExcepcion() {
        // Arrange
        Propietario propietario = new Propietario(null, null, null, false, null);
        String nombre = "John Doe 123";

        // Assert
        Assertions.assertThrows(IllegalArgumentException.class, () -> {
            // Act
            propietario.setNombre(nombre);
        });
    }


    @Test
    void setNumeroTelefono_TelefonoValido_DeberiaEstablecerNumeroTelefonoCorrectamente() {
        // Arrange
        Propietario propietario = new Propietario(null, null, null, false, null);
        String numeroTelefono = "1234567890";

        // Act
        propietario.setNumeroTelefono(numeroTelefono);

        // Assert
        Assertions.assertEquals(numeroTelefono, propietario.getNumeroTelefono());
    }

    @Test
    void setNumeroTelefono_TelefonoInvalido_DeberiaLanzarExcepcion() {
        // Arrange
        Propietario propietario = new Propietario(null, null, null, false, null);
        String numeroTelefono = "12345";

        // Assert
        Assertions.assertThrows(IllegalArgumentException.class, () -> {
            // Act
            propietario.setNumeroTelefono(numeroTelefono);
        });
    }

    @Test
    void setMatricula_EstudianteConMatriculaValida_DeberiaEstablecerMatriculaCorrectamente() {
        // Arrange
        Propietario propietario = new Propietario(null, null, null, false, null);
        String matricula = "987654321";
        propietario.setEstudiante(true);

        // Act
        propietario.setMatricula(matricula);

        // Assert
        Assertions.assertEquals(matricula, propietario.getMatricula());
    }

    @Test
    void setMatricula_EstudianteConMatriculaInvalida_DeberiaLanzarExcepcion() {
        // Arrange
        Propietario propietario = new Propietario(null, null, null, false, null);
        String matricula = "1234";
        propietario.setEstudiante(true);

        // Assert
        Assertions.assertThrows(IllegalArgumentException.class, () -> {
            // Act
            propietario.setMatricula(matricula);
        });
    }

    @Test
    void setMatricula_NoEstudiante_DeberiaEstablecerMatriculaComoNull() {
        // Arrange
        Propietario propietario = new Propietario(null, null, null, false, null);
        String matricula = "987654321";
        propietario.setEstudiante(false);

        // Act
        propietario.setMatricula(matricula);

        // Assert
        Assertions.assertNull(propietario.getMatricula());
    }

    @Test
    void crearPropietario_DatosValidos_DeberiaCrearPropietarioCorrectamente() {
        // Arrange
        String nombre = "John Doe";
        String numeroTelefono = "1234567890";
        String matricula = "987654321";
        boolean estudiante = true;
        Direccion direccion = new Direccion("Calle 123", "Ciudad", "País", 0, 0);

        // Act
        Propietario propietario = new Propietario(nombre, numeroTelefono, matricula, estudiante, direccion);

        // Assert
        Assertions.assertNotNull(propietario);
        Assertions.assertEquals(nombre, propietario.getNombre());
        Assertions.assertEquals(numeroTelefono, propietario.getNumeroTelefono());
        Assertions.assertEquals(matricula, propietario.getMatricula());
        Assertions.assertEquals(estudiante, propietario.isEstudiante());
        Assertions.assertEquals(direccion, propietario.getDireccion());
    }

    @Test
    /* Prueba de aceptación */
    void crearPropietario_DatosValidos_DeberiaCrearPropietario() {
        // Arrange
        String nombre = "John Doe";
        String numeroTelefono = "1234567890";
        String matricula = "987654321";
        boolean estudiante = true;
        Direccion direccion = new Direccion("Calle 123", "Ciudad", "País", 0, 0);

        // Act
        Propietario propietario = new Propietario(nombre, numeroTelefono, matricula, estudiante, direccion);

        // Assert
        Assertions.assertNotNull(propietario);
        Assertions.assertEquals(nombre, propietario.getNombre());
        Assertions.assertEquals(numeroTelefono, propietario.getNumeroTelefono());
        Assertions.assertEquals(matricula, propietario.getMatricula());
        Assertions.assertEquals(estudiante, propietario.isEstudiante());
        Assertions.assertEquals(direccion, propietario.getDireccion());
    }

}
