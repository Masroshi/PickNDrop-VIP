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
public class bookingServlet3 extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

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
        DRIVER BOOKING COMPLETING SERVLET
        */
        Object session3 = request.getSession().getAttribute("driver");  //getting sessions
        String complete = request.getParameter("complete");
        String bookingComplete = "false";
        String bookingCompleteFail = "true";
        int driverID = 0;
        if (session3 != null) {

            if (complete != null) {         //if not null
                try {

                    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                    PreparedStatement pp = null;
                    int bookingID = Integer.parseInt(request.getParameter("bookingID"));
                    pp = con.prepareStatement("SELECT * FROM DRIVER where USERNAME=?");     //getting username
                    pp.setString(1, (String) request.getSession().getAttribute("driver"));
                    ResultSet rs = pp.executeQuery();
                    while (rs.next()) {
                        driverID = rs.getInt("DRIVERID");
                        
                    }
                    String status = "COMPLETED";                //getting parameters

                    pp = con.prepareStatement("SELECT * FROM BOOKING where BOOKINGID=? AND DRIVERID=?");       //getting bookingid
                    pp.setInt(1, bookingID);
                    pp.setInt(2, driverID);
                    rs = pp.executeQuery();
                    while (rs.next()) {
                        pp = con.prepareStatement("UPDATE BOOKING SET STATUS=? where BOOKINGID=?");     //updating booking status
                        pp.setString(1, status);
                        pp.setInt(2, bookingID);
                        bookingComplete = "true";
                        bookingCompleteFail = "false";
                        request.getSession().setAttribute("bookingComplete", bookingComplete);
                        pp.executeUpdate();
                    }
                    if(bookingCompleteFail.equals("true")){
                        request.getSession().setAttribute("bookingCompleteFail", bookingCompleteFail);
                    }
                    pp.close();
                    rs.close();
                    response.sendRedirect("driverView/viewBooking.jsp");
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
