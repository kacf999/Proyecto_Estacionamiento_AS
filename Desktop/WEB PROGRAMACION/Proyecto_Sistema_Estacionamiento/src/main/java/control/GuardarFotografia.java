package control;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import almacen.ConexionBD;
import modelo.Camara;

public class GuardarFotografia {

    public void insertar(Camara datos) throws SQLException {
        Connection connection = ConexionBD.obtenerConexion();
        PreparedStatement pst;
        String sql = "insert into fotos (fecha, matricula, foto) values(?,?,?)";
        try {
            pst = connection.prepareStatement(sql);
            pst.setDate(1, (Date) datos.getFecha());
            pst.setString(2, datos.getMatricula());
            pst.setBytes(3, datos.getFoto());
            pst.executeUpdate();
            pst.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Camara> buscar() throws SQLException {
        Connection connection = ConexionBD.obtenerConexion();
        String sql = "select fecha, matricula, foto from fotos";
        ResultSet rs = null;
        Camara datos = null;
        ArrayList<Camara> ingresar = new ArrayList<>();

        PreparedStatement pst;
        try {
            pst = connection.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                datos = new Camara(0, rs.getDate("fecha"), rs.getString("matricula"), rs.getBytes("foto"));
                ingresar.add(datos);
            }
            pst.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ingresar;
    }
}
