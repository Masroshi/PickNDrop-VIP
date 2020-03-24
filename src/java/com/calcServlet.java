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
import javax.xml.ws.WebServiceRef;
import model.Booking;
import static model.Booking.bookingList;
import model.DB;

/**
 *
 * @author NUser1
 */
public class calcServlet extends HttpServlet {
    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/calculateDistanceAndTime/calculateDistanceAndTime.wsdl")
    private CalculateDistanceAndTime_Service service;

    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object session = request.getSession().getAttribute("customer");
        if (session == null) {
            RequestDispatcher view = request.getRequestDispatcher("login.jsp");
            view.forward(request, response);

        } else {
            try {
                String origin2 = request.getParameter("origin2");
                String destination2 = request.getParameter("destination2");
                String time2 = request.getParameter("time2");
                String date2 = request.getParameter("date2");
                int distance2 = Integer.parseInt(request.getParameter("distance2"));
                int duration2 = Integer.parseInt(request.getParameter("duration2"));
                String status = request.getParameter("status");
                int sum = calculateDistanceAndTime(duration2, distance2);
                request.setAttribute("sum", sum);
                request.setAttribute("od", origin2);
                request.setAttribute("do", destination2);
                String bookingAdded = "false";
                DB conn = new DB();

                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                PreparedStatement pp = null;
                //bookingList.add(new Booking(origin2, destination2, duration2, distance2, date2, time2, sum, status));
                int id = 0;
                pp = con.prepareStatement("SELECT * FROM CUSTOMER where USERNAME=?");
                pp.setString(1, (String) request.getSession().getAttribute("customer"));
                ResultSet rs = pp.executeQuery();
                while (rs.next()) {

                    id = rs.getInt("CUSTOMERID");
                    bookingAdded = "true";
                    request.getSession().setAttribute("bookingAdded", bookingAdded);
                }
                rs.close();
                
                pp = con.prepareStatement("INSERT INTO BOOKING (CUSTOMERID, ORIGIN, DESTINATION, DURATION, DISTANCE, BOOKINGDATE, BOOKINGTIME, TOTAL, STATUS)" + "VALUES(?,?,?,?,?,?,?,?,?)");
                pp.setInt(1, id);
                pp.setString(2, origin2);
                pp.setString(3, destination2);
                pp.setInt(4, duration2);
                pp.setInt(5, distance2);
                pp.setString(6, date2);
                pp.setString(7, time2);
                pp.setInt(8, sum);
                pp.setString(9, status);
                pp.executeUpdate();
                pp.close();
                
                
                response.sendRedirect("customerView/viewBooking.jsp");
                
               // bookingAdded = "false";
            } catch (SQLException ex) {
                Logger.getLogger(calcServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private int calculateDistanceAndTime(int i, int j) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        com.CalculateDistanceAndTime port = service.getCalculateDistanceAndTimePort();
        return port.calculateDistanceAndTime(i, j);
    }

    

}
