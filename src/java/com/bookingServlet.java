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
public class bookingServlet extends HttpServlet {

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
        CUSTOMER BOOKING CANCELLING SERVLET
        */
        try {
            Object session = request.getSession().getAttribute("customer");
            //getting session
            
            if (session != null) {  //if not null

                String delete = request.getParameter("delete");
                int id = Integer.parseInt(request.getParameter("id"));  //getting parameters
                if (delete != null) {

                    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                    PreparedStatement pp = null;
                    pp = con.prepareStatement("SELECT * FROM BOOKING where BOOKINGID=?");   //getting bookingid
                    pp.setInt(1, id);
                    ResultSet rs = pp.executeQuery();
                    while(rs.next()){
                        
                         pp = con.prepareStatement("DELETE FROM BOOKING where BOOKINGID=?");    //deleting booking id
                         pp.setInt(1, id);
                         pp.executeUpdate();
                    }
                    pp.close();
                    rs.close();
                    response.sendRedirect("customerView/viewBooking.jsp");

                } else {
                    response.sendRedirect("customerView/home.jsp");
                }
            } else {
                    
                RequestDispatcher view = request.getRequestDispatcher("login.jsp");
                view.forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(bookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}