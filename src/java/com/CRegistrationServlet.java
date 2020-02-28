/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Asus
 */
public class CRegistrationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    static final String driver = "org.apache.derby.jdbc.ClientDriver";
    static final String databaseUrl = "jdbc:derby://localhost:1527/SprintTwoDatabase";
    static final String USER = "root";
    static final String PASS = "root";
    private Connection connection = null;
    static Statement stmt = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            Class.forName(driver);

            connection = DriverManager.getConnection(databaseUrl, USER, PASS);
            stmt = connection.createStatement();

            
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            String insert = "INSERT INTO CUSTOMER "
                    + " (USERNAME, NAME, PASSWORD, EMAIL) " + " values (?, ?, ?, ?)";

            PreparedStatement pp = null;
            pp = connection.prepareStatement(insert);

            //set param values
            pp.setString(1, username);
            pp.setString(2, name);
            pp.setString(3, password);
            pp.setString(4, email);

            //Execute SQL query
            pp.executeUpdate();
            response.sendRedirect("login.jsp");
        } catch (SQLException ex) {
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CRegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }

}
