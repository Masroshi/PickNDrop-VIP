/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author NUser1
 */
public class availableServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
            PreparedStatement pp = null;
            String status = request.getParameter("available");
            String status2 = request.getParameter("notAvailable");
            String statusFail = "false";         
            if (status != null) {
                int driverid = 0;
                pp = con.prepareStatement("SELECT * FROM DRIVER where USERNAME=?"); //getting driver id
                pp.setString(1, (String) request.getSession().getAttribute("driver"));
                ResultSet rs = pp.executeQuery();
                while (rs.next()) {
                    driverid = rs.getInt("DRIVERID");
                    
                }
                pp = con.prepareStatement("SELECT * FROM DRIVER where DRIVERID=?"); //using driver id
                pp.setInt(1, driverid);
                rs = pp.executeQuery();
                while (rs.next()) {

                    pp = con.prepareStatement("UPDATE DRIVER SET STATUS=? where DRIVERID=?"); //updating booking status
                    pp.setString(1, "AVAILABLE");
                    pp.setInt(2, driverid);
                    request.getSession().setAttribute("available", status);
                    pp.executeUpdate();

                }
                pp.close();
                rs.close();
                response.sendRedirect("driverView/profile.jsp");
            } else if (status2 != null) {
                int driverid = 0;
                pp = con.prepareStatement("SELECT * FROM DRIVER where USERNAME=?"); //getting driver id
                pp.setString(1, (String) request.getSession().getAttribute("driver"));
                ResultSet rs = pp.executeQuery();
                while (rs.next()) {
                    driverid = rs.getInt("DRIVERID");

                }
                pp = con.prepareStatement("SELECT * FROM DRIVER where DRIVERID=?"); //using driver id
                pp.setInt(1, driverid);
                rs = pp.executeQuery();
                while (rs.next()) {

                    pp = con.prepareStatement("UPDATE DRIVER SET STATUS=? where DRIVERID=?"); //updating booking status
                    pp.setString(1, "NOT AVAILABLE");
                    pp.setInt(2, driverid);
                    request.getSession().setAttribute("notAvailable", status2);
                    pp.executeUpdate();

                }
                pp.close();
                rs.close();
                response.sendRedirect("driverView/profile.jsp");
            }else{
                statusFail = "true";
                request.getSession().setAttribute("statusFail", statusFail);
                response.sendRedirect("driverView/driver.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(availableServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
