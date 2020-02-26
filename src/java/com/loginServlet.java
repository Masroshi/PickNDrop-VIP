/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DB;

/**
 *
 * @author NUser1
 */
public class loginServlet extends HttpServlet {

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
        
        doPost(request,response);
        
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
        try {
            
            Object s = request.getSession().getAttribute("customer");
            Object s2 = request.getSession().getAttribute("driver");
            Object s3 = request.getSession().getAttribute("admin");
            String loginPost = request.getParameter("loginPost");
            if (loginPost!=null && loginPost.equals("loginPost")){
                DB db = new DB();
                db.setConnection("root", "root");
                String page = request.getParameter("page");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                ResultSet rs = db.selectCustomer(username, password);             
                ResultSet rs2 = db.selectDriver(username, password);
                ResultSet rs3 = db.selectAdmin(username, password);
                switch (page) {
                    case "login.jsp":
                        //if using customer login page
                        if (rs.next()) { //if user exists
                            HttpSession session = request.getSession(); //create session
                            request.getSession().setAttribute("customer", username); //making specific sessions
                            response.sendRedirect("customerView/customer.jsp");
                        } else if (rs3.next()) {
                            HttpSession session = request.getSession(); //create session
                            request.getSession().setAttribute("admin", username);                            
                            response.sendRedirect("adminView/admin.jsp");
                        } else { //if not found go to loginpage
                            request.setAttribute("error", "Invalid Username or Password");
                            response.sendRedirect(page);
                        }   
                        break;
                    case "DriverLogin.jsp":
                        //if using driver login page
                        if (rs2.next()) {
                            HttpSession session = request.getSession(); //same thing as before
                            request.getSession().setAttribute("driver",username);
                            response.sendRedirect("driverView/driver.jsp");
                        } else if (rs3.next()) {
                            HttpSession session = request.getSession();
                            request.getSession().setAttribute("admin",username);
                            response.sendRedirect("adminView/admin.jsp");
                        } else { //if not found go to loginpage
                            request.setAttribute("error", "Invalid Username or Password");
                            response.sendRedirect(page);
                        }   
                        break;
                    default:
                        //RequestDispatcher view = request.getRequestDispatcher("login.jsp");
                        //view.forward(request, response);
                        break;
                }
            }else if(s != null){
                //RequestDispatcher view = request.getRequestDispatcher("home.jsp");
                //view.forward(request, response);
                response.sendRedirect("customerView/customer.jsp");
            }else if(s2 != null){
                response.sendRedirect("driverView/driver.jsp");
            }else if(s3 != null){
                response.sendRedirect("adminView/admin.jsp");
            }else{
                response.sendRedirect("login.jsp");
            }

            /*if(username.equals("user") && password.equals("pass")){
            
            
             HttpSession session = request.getSession();
             request.getSession().setAttribute("user", username);
             request.setAttribute("loginResult", false);
             RequestDispatcher view = request.getRequestDispatcher("welcome.jsp");
             view.forward(request, response);
             }else{
             request.setAttribute("loginResult", true);
             RequestDispatcher view = request.getRequestDispatcher("welcome.jsp");
             view.forward(request, response);
             }*/
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        
        String loginGet = request.getParameter("loginGet");         //getting parameters to check loginstatus
        String logout = request.getParameter("logout");
        if(loginGet != null){                           //if it is not null go to login page
           response.sendRedirect(request.getContextPath() + "/login.jsp"); 
        }else if(logout != null){                       //if it is not null invalidate session and go to login page
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }else{                                          //if statuses are null then do the things in post method
            Object s = request.getSession().getAttribute("customer");
            Object s2 = request.getSession().getAttribute("driver");
            Object s3 = request.getSession().getAttribute("admin");
            String loginPost = request.getParameter("loginPost");
            if (loginPost!=null && loginPost.equals("loginPost")){
                DB db = new DB();
                db.setConnection("root", "root");
                String page = request.getParameter("page");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                ResultSet rs = db.selectCustomer(username, password);             
                ResultSet rs2 = db.selectDriver(username, password);
                ResultSet rs3 = db.selectAdmin(username, password);
                switch (page) {
                    case "login.jsp":
                        //if using customer login page
                        if (rs.next()) { //if user exists
                            HttpSession session = request.getSession(); //create session
                            request.getSession().setAttribute("customer", username); //making specific sessions
                            response.sendRedirect("customerView/customer.jsp");
                        } else if (rs3.next()) {
                            HttpSession session = request.getSession(); //create session
                            request.getSession().setAttribute("admin", username);                            
                            response.sendRedirect("adminView/admin.jsp");
                        } else { //if not found go to loginpage
                            request.setAttribute("error", "Invalid Username or Password");
                            response.sendRedirect(page);
                        }   
                        break;
                    case "DriverLogin.jsp":
                        //if using driver login page
                        if (rs2.next()) {
                            HttpSession session = request.getSession(); //same thing as before
                            request.getSession().setAttribute("driver",username);
                            response.sendRedirect("driverView/driver.jsp");
                        } else if (rs3.next()) {
                            HttpSession session = request.getSession();
                            request.getSession().setAttribute("admin",username);
                            response.sendRedirect("adminView/admin.jsp");
                        } else { //if not found go to loginpage
                            request.setAttribute("error", "Invalid Username or Password");
                            response.sendRedirect(page);
                        }   
                        break;
                    default:
                        //RequestDispatcher view = request.getRequestDispatcher("login.jsp");
                        //view.forward(request, response);
                        break;
                }
            }else if(s != null){
                response.sendRedirect("customerView/customer.jsp");
            }else if(s2 != null){
                response.sendRedirect("driverView/driver.jsp");
            }else if(s3 != null){
                response.sendRedirect("adminView/admin.jsp");
            }else{
                response.sendRedirect("login.jsp");
            }
        }
        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }
        
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
