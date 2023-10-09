package almacen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static final String URL = "jdbc:postgresql://localhost:5432/RespaldoBase";
    private static final String USUARIO = "postgres";
    private static final String CONTRASEÑA = "2020";

    public static Connection obtenerConexion() throws SQLException {
    	try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return DriverManager.getConnection(URL, USUARIO, CONTRASEÑA);
    }
}
