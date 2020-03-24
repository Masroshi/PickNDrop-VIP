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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author NUser1
 */
public class bookingServlet2 extends HttpServlet {

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
        /*
        ADMIN ASSIGNING DRIVER SERVLET
        */
        Object session2 = request.getSession().getAttribute("admin");   //getting sessions
        String assign = request.getParameter("assign"); 
        String driverAssigned = "false";
        String driverAssignedFail = "true";
        if (session2 != null) {

            if (assign != null) {   //if not null

                try {
                    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                    PreparedStatement pp = null;
                    int driverID = Integer.parseInt(request.getParameter("driverID"));
                    int bookingID = Integer.parseInt(request.getParameter("bookingID"));    //getting parameters
                    String assigned = "ASSIGNED";
                    String status = "";
                    pp = con.prepareStatement("SELECT * FROM DRIVER where DRIVERID=?");   //getting bookingid
                    pp.setInt(1, driverID);
                    ResultSet rs = pp.executeQuery();
                    while (rs.next()) {

                        status = rs.getString("STATUS");
                        
                    }
                    if(status.equals("AVAILABLE")){
                    pp = con.prepareStatement("SELECT * FROM BOOKING where BOOKINGID=?");   //getting bookingid
                    pp.setInt(1, bookingID);
                    rs = pp.executeQuery();
                    while (rs.next()) {
                        pp = con.prepareStatement("UPDATE BOOKING SET STATUS=?, DRIVERID=? where BOOKINGID=?"); //updating booking status
                        pp.setString(1, assigned);
                        pp.setInt(2, driverID);
                        pp.setInt(3, bookingID);
                        driverAssigned = "true";
                        driverAssignedFail = "false";
                        request.getSession().setAttribute("driverAssigned", driverAssigned);
                        pp.executeUpdate();
                    }
                    if(driverAssignedFail.equals("true")){
                        request.getSession().setAttribute("driverAssignedFail", driverAssignedFail);
                    }
                    pp.close();
                    rs.close();
                    response.sendRedirect("adminView/adminDriverAssign.jsp");
                    }else{
                        request.getSession().setAttribute("driverAssignedFail", driverAssignedFail);
                        response.sendRedirect("adminView/adminDriverAssign.jsp");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(bookingServlet2.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                RequestDispatcher view = request.getRequestDispatcher("login.jsp");
                view.forward(request, response);
            }
        } else {

            RequestDispatcher view = request.getRequestDispatcher("login.jsp");
            view.forward(request, response);
        }
    }

}
