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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String page = request.getParameter("page");  //using page name to go back if user/pass is incorrect
            Object s = request.getSession().getAttribute("customer");   
            Object s2 = request.getSession().getAttribute("driver");
            Object s3 = request.getSession().getAttribute("admin");
            if (s == null || s2 == null || s3 == null) {   //finding if session exists
                DB db = new DB();
                db.setConnection("root", "root");   //setting db connection
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                ResultSet rs = db.selectCustomer(username, password);   //using function in db to find user
                ResultSet rs2 = db.selectDriver(username, password);
                ResultSet rs3 = db.selectAdmin(username, password);
                if(page.equals("CustomerLogin.jsp")){   //if using customer login page
                if (rs.next()) { //if user exists
                    HttpSession session = request.getSession(); //create session
                    request.getSession().setAttribute("customer", username); //making specific sessions
                    RequestDispatcher view = request.getRequestDispatcher("Customer.jsp");
                    view.forward(request, response);
                }else if (rs3.next()) {
                    HttpSession session = request.getSession();
                    request.getSession().setAttribute("admin", username);
                    RequestDispatcher view = request.getRequestDispatcher("Admin.jsp");
                    view.forward(request, response);
                }else { //if not found go to loginpage
                    request.setAttribute("error","Invalid Username or Password");
                    RequestDispatcher view = request.getRequestDispatcher(page);
                    view.forward(request, response);
                }
                }else if(page.equals("DriverLogin.jsp")){   //if using driver login page
                    if (rs2.next()) {
                    HttpSession session = request.getSession(); //same thing as before
                    request.getSession().setAttribute("driver", username);
                    RequestDispatcher view = request.getRequestDispatcher("Driver.jsp");
                    view.forward(request, response);
                }else if (rs3.next()) {
                    HttpSession session = request.getSession();
                    request.getSession().setAttribute("admin", username);
                    RequestDispatcher view = request.getRequestDispatcher("Admin.jsp");
                    view.forward(request, response);
                }else { //if not found go to loginpage
                    request.setAttribute("error","Invalid Username or Password");
                    RequestDispatcher view = request.getRequestDispatcher(page);
                    view.forward(request, response);
                } 
                }
            }else{  //if session already created go back to homepage
                RequestDispatcher view = request.getRequestDispatcher("Home.html"); //will change to jsp later
                view.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
