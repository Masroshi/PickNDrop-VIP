/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import com.lambdaworks.crypto.SCryptUtil;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Scanner;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.swing.JOptionPane;

/**
 *
 * @author NUser1
 */
public class SprintOneDatabase {

    static ArrayList<Admin> adminList = new ArrayList();
    static ArrayList<Customer> customerList = new ArrayList();
    static ArrayList<Driver> driverList = new ArrayList();

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws ClassNotFoundException {
        // TODO code application logic here
        Connection con = null;
        Statement statement = null;

        try {

            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintOneDatabase", "root", "root");
            statement = con.createStatement();
            /*
             Deleting tables if it exists.
             Will keep them if necessary later on.
             */
            DatabaseMetaData dbmd = con.getMetaData();
            ResultSet rs = dbmd.getTables(null, "ROOT", "ADMIN", null);
            if (rs.next()) {
                String sql = "DROP TABLE ADMIN";
                statement.executeUpdate(sql);
            }
            rs = dbmd.getTables(null, "ROOT", "DRIVER", null);
            if (rs.next()) {
                String sql = "DROP TABLE DRIVER";
                statement.executeUpdate(sql);
            }
            rs = dbmd.getTables(null, "ROOT", "CUSTOMER", null);
            if (rs.next()) {
                String sql = "DROP TABLE CUSTOMER";
                statement.executeUpdate(sql);
            }
            rs = dbmd.getTables(null, "ROOT", "BOOKING", null);
            if (rs.next()) {
                String sql = "DROP TABLE BOOKING";
                statement.executeUpdate(sql);
            }
            /*
             Creating the tables.
            
             */
            try {

                String sqlAdmin = "CREATE TABLE ADMIN" + "(adminID VARCHAR(30) PRIMARY KEY NOT NULL," + "USERNAME VARCHAR(30) NOT NULL," + "NAME VARCHAR(30) NOT NULL," + "PASSWORD VARCHAR(128) NOT NULL," + "EMAIL VARCHAR(50) NOT NULL)";
                statement.executeUpdate(sqlAdmin);
                String sqlDriver = "CREATE TABLE DRIVER" + "(driverID VARCHAR(30) PRIMARY KEY NOT NULL," + "USERNAME VARCHAR(30) NOT NULL," + "NAME VARCHAR(30) NOT NULL," + "PASSWORD VARCHAR(128) NOT NULL," + "EMAIL VARCHAR(50) NOT NULL)";
                statement.executeUpdate(sqlDriver);
                String sqlCustomer = "CREATE TABLE CUSTOMER" + "(customerID VARCHAR(30) PRIMARY KEY NOT NULL," + "USERNAME VARCHAR(30) NOT NULL," + "NAME VARCHAR(30) NOT NULL," + "PASSWORD VARCHAR(128) NOT NULL," + "EMAIL VARCHAR(50) NOT NULL)";
                statement.executeUpdate(sqlCustomer);
                String sqlBooking = "CREATE TABLE BOOKING" + "(bookingID VARCHAR(30) PRIMARY KEY NOT NULL," + "ORIGIN VARCHAR(100) NOT NULL," + "DESTINATION VARCHAR(100) NOT NULL," + "DURATION INTEGER NOT NULL," + "DISTANCE INTEGER NOT NULL," + "BOOKINGDATE DATE NOT NULL," + "BOOKINGTIME TIME NOT NULL," + "TOTAL FLOAT NOT NULL)";
                statement.executeUpdate(sqlBooking);
                statement.close();
                /*
                 Using data from text file.
            
                 */
                FileReader fr = new FileReader("C:\\Users\\NUser1\\Documents\\NetBeansProjects\\sprintOneDatabase\\admin.txt");
                Scanner input = new Scanner(fr);
                PreparedStatement pp = null;
                input.useDelimiter(",");
                String n, u, p = null, e, hp = null;
                while (input.hasNext()) {
                    u = input.next();
                    n = input.next();
                    e = input.next();
                    p = input.next();
                    hp = hashPassword(p);
                    adminList.add(new Admin(u, n, e, hp));
                    System.out.println(u + " " + n + " " + e + " " + hp + " ");
                }
                input.close();
                fr.close();

                FileReader fr2 = new FileReader("C:\\Users\\NUser1\\Documents\\NetBeansProjects\\sprintOneDatabase\\driver.txt");
                Scanner input2 = new Scanner(fr2);
                input2.useDelimiter(",");
                while (input2.hasNext()) {
                    u = input2.next();
                    n = input2.next();
                    e = input2.next();
                    p = input2.next();
                    hp = hashPassword(p);
                    driverList.add(new Driver(u, n, e, hp));
                    System.out.println(u + " " + n + " " + e + " " + hp + " ");
                }
                input2.close();
                fr2.close();
                FileReader fr3 = new FileReader("C:\\Users\\NUser1\\Documents\\NetBeansProjects\\sprintOneDatabase\\customer.txt");
                Scanner input3 = new Scanner(fr3);
                input3.useDelimiter(",");

                while (input3.hasNext()) {
                    u = input3.next();
                    n = input3.next();
                    e = input3.next();
                    p = input3.next();
                    hp = hashPassword(p);
                    customerList.add(new Customer(u, n, e, hp));
                    System.out.println(u + " " + n + " " + e + " " + hp + " ");
                }
                input3.close();
                fr3.close();
                /*
                 Inserting data to database.
            
                 */
                
                for (Admin a : adminList) {

                    pp = con.prepareStatement("INSERT INTO ADMIN " + "VALUES(?,?,?,?,?)");
                    pp.setString(1, a.getAdminID());
                    pp.setString(2, a.getUsername());
                    pp.setString(3, a.getName());
                    pp.setString(4, a.getPassword());
                    pp.setString(5, a.getEmail());
                    pp.executeUpdate();

                }

                for (Driver d : driverList) {

                    pp = con.prepareStatement("INSERT INTO DRIVER " + "VALUES(?,?,?,?,?)");
                    pp.setString(1, d.getDriverID());
                    pp.setString(2, d.getUsername());
                    pp.setString(3, d.getName());
                    pp.setString(4, d.getPassword());
                    pp.setString(5, d.getEmail());
                    pp.executeUpdate();

                }

                for (Customer c : customerList) {

                    pp = con.prepareStatement("INSERT INTO CUSTOMER " + "VALUES(?,?,?,?,?)");
                    pp.setString(1, c.getCustomerID());
                    pp.setString(2, c.getUsername());
                    pp.setString(3, c.getName());
                    pp.setString(4, c.getPassword());
                    pp.setString(5, c.getEmail());
                    pp.executeUpdate();

                }
                
                
                pp.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        } catch (SQLException s) {
            System.out.println("SQL statement is not executed! error: " + s.getMessage());
            s.printStackTrace();
        }
        
    }
    /*
     Using function to hash the password.
            
     */

    public static String hashPassword(String password) {
        String generatedSecuredPasswordHash = SCryptUtil.scrypt(password, 16, 16, 16);
        return generatedSecuredPasswordHash;

    }
    
    
}
