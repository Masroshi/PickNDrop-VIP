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

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
        CUSTOMER BOOKING CANCELLING SERVLET
        */
        try {
            String bookingDeleted = "false";
            String bookingDeletedFail = "true";
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
                         bookingDeleted = "true";
                         bookingDeletedFail = "false";
                         request.getSession().setAttribute("bookingDeleted", bookingDeleted);
                         pp.executeUpdate();
                         
                    }
                    if(bookingDeletedFail.equals("true")){
                        request.getSession().setAttribute("bookingDeletedFail", bookingDeletedFail);
                    }
                    pp.close();
                    rs.close();
                    response.sendRedirect("customerView/viewBooking.jsp");

                } else {
                    bookingDeletedFail = "true";
                    request.getSession().setAttribute("bookingDeletedFail", bookingDeletedFail);
                    response.sendRedirect("customerView/customer.jsp");
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
