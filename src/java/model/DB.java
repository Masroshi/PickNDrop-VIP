/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import com.lambdaworks.crypto.SCryptUtil;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;

/**
 *
 * @author NUser1
 */
public class DB {

    static final String driver = "org.apache.derby.jdbc.ClientDriver";
    static final String databaseUrl = "jdbc:derby://localhost:1527/SprintTwoDatabase";
    private Connection connection = null;
    private Statement stmt = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public DB() {
    }

    public void setConnection(String user, String password) { //source from Histogram zip file in practicals

        try {

            Class.forName(driver);

            connection = DriverManager.getConnection(databaseUrl, user, password);
            stmt = connection.createStatement();

        } catch (SQLException sqlException) {
            System.err.println("Driver loaded, but something went wrong elsewhere!");
            sqlException.printStackTrace();

        } catch (ClassNotFoundException classNotFound) {
            System.err.println("Couldn't find driver!");
            classNotFound.printStackTrace();
        }

    }

    public ResultSet selectCustomer(String user, String pass) throws SQLException {

        ps = connection.prepareStatement("SELECT * FROM CUSTOMER where USERNAME=?");
        ps.setString(1, user);
        rs = ps.executeQuery();

        while (rs.next()) {

            String u = rs.getString("USERNAME");
            String password = rs.getString("PASSWORD");
            if (u.equals(user)) {
                boolean matched = SCryptUtil.check(pass, password);
                if (matched == true) {
                    pass = password;
                }
            }
        }
        ps = connection.prepareStatement("SELECT * FROM CUSTOMER where USERNAME=? and PASSWORD=?");
        ps.setString(1, user);
        ps.setString(2, pass);
        rs = ps.executeQuery();
        return rs;
        
    }
    
    public ResultSet selectDriver(String user, String pass) throws SQLException {

        ps = connection.prepareStatement("SELECT * FROM DRIVER where USERNAME=?");
        ps.setString(1, user);
        rs = ps.executeQuery();

        while (rs.next()) {

            String u = rs.getString("USERNAME");
            String password = rs.getString("PASSWORD");
            if (u.equals(user)) {
                boolean matched = SCryptUtil.check(pass, password);
                if (matched == true) {
                    pass = password;
                }
            }
        }
        ps = connection.prepareStatement("SELECT * FROM DRIVER where USERNAME=? and PASSWORD=?");
        ps.setString(1, user);
        ps.setString(2, pass);
        rs = ps.executeQuery();
        return rs;
        
    }
    
    public ResultSet selectAdmin(String user, String pass) throws SQLException {

        ps = connection.prepareStatement("SELECT * FROM ADMIN where USERNAME=?");
        ps.setString(1, user);
        rs = ps.executeQuery();

        while (rs.next()) {

            String u = rs.getString("USERNAME");
            String password = rs.getString("PASSWORD");
            if (u.equals(user)) {
                boolean matched = SCryptUtil.check(pass, password);
                if (matched == true) {
                    pass = password;
                }
            }
        }
        ps = connection.prepareStatement("SELECT * FROM ADMIN where USERNAME=? and PASSWORD=?");
        ps.setString(1, user);
        ps.setString(2, pass);
        rs = ps.executeQuery();
        return rs;
    }

}
