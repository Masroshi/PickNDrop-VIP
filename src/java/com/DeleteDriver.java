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
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteDriver extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // JDBC driver name and database URL
    static final String DB_URL = "jdbc:derby://localhost:1527/CRUDTest";

    //  Database credentials
    static Connection con = null;
    static Statement stmt = null;
//    static int cdid = 0;
    static String ch = null;
//    static int cdid = 0;

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
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("Test");
        String delete = request.getParameter("delete");
        int driverID = Integer.parseInt(request.getParameter("driverID"));
        String driverRemoved = "false";
        String removeFail = "true";
        if (delete != null) {
            try {
                //Register JDBC driver
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                Statement stmt = con.createStatement();

                PreparedStatement pp = con.prepareStatement("SELECT * FROM DRIVER where DRIVERID=?");//Getting bookingid
                pp.setInt(1, driverID);
                ResultSet rs = pp.executeQuery();
                while (rs.next()) {

                    pp = con.prepareStatement("DELETE FROM DRIVER where DRIVERID=?");//Deleting bookingid
                    pp.setInt(1, driverID);
                    pp.executeUpdate();
                    driverRemoved = "true";
                    removeFail = "false";
                    request.getSession().setAttribute("driverRemoved", driverRemoved);
                }
                if(removeFail.equals("true")){
                    request.getSession().setAttribute("removeFail", removeFail);
                }
                System.out.println("Record Deleted");
                response.sendRedirect("adminView/adminDriver.jsp");

            } catch (SQLException se) {
                //Handle errors for JDBC
                se.printStackTrace();
            } catch (Exception e) {
                //Handle errors for Class.forName
                e.printStackTrace();
            } finally {
                //finally block used to close resources
                try {
                    if (stmt != null) {
                        con.close();
                    }
                } catch (SQLException se) {
                }
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException se) {
                    se.printStackTrace();
                }//end finally try
            }//end try

            System.out.println(
                    "CRUD complete!");

        } else {
            removeFail = "true";
            request.getSession().setAttribute("removeFail", removeFail);
            response.sendRedirect("adminView/admin.jsp");
        }
    }
}
