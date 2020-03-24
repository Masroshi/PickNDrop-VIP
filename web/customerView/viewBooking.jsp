<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/angular-material/1.1.8/angular-material.min.css" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css"> 
        <script src="${pageContext.servletContext.contextPath}/js/jquery.min.js"></script>        
        <title>JSP Page</title>
    </head>
    <body>


        <div id="msg" style="font-size:largest;">

            Loading, please wait...
        </div>
        <div id="body" style="display:none;">

            <nav>
                <div class="nav-wrapper">
                    <a href="#" class="brand-logo center">Bookings</a>
                    <ul class="right hide-on-med-and-down">
                        <li>
                            <form action="${pageContext.servletContext.contextPath}/loginServlet.do" method ="get">
                                <div> 
                                    <%
                                        if (session.getAttribute("customer") == null) {//if session is null rename button to login else logout
                                            //when clicked it opens customerlogin page
                                    %>
                                    <input type="hidden" name = "loginGet" value = "loginGet">
                                    <button type="submit" class="waves-effect waves-light btn">Login</button>  
                                    <%
                                    } else {          //using function to run code when clicked
                                    %>
                                    <input type="hidden" name = "logout" value = "logout">
                                    <button type="submit" class="waves-effect waves-light btn">Logout</button>
                                    <%
                                        }
                                    %>        
                                </div>
                            </form>
                        </li>
                    </ul>

                    <ul class="dropdown-content" id="user_dropdown">

                        <li><a href="#!">Profile</a></li>

                    </ul>
                    <ul id="nav-mobile" class="left hide-on-med-and-down">
                        <li><a class="active" href="home.jsp">Home</a></li>
                        <li><a href="booking.jsp">Booking</a></li>
                        <li><a href="viewBooking.jsp">View Booking</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                </div>
            </nav>
            <form action="${pageContext.servletContext.contextPath}/bookingServlet.do" method="post">


                <div id="customer1" class="col s12">
                    <table class="respnsive-table highlight">
                        <tr>
                            <td>BOOKING ID</td>
                            <td>CUSTOMER ID</td>
                            <td>ORIGIN</td>
                            <td>DESTINATION</td>
                            <td>TOTAL</td>
                            <td>GST TOTAL</td>
                            <td>STATUS</td>
                        </tr>  
                        <%
                            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                            PreparedStatement pp = null;
                            int id = 0;
                            int gst = 0;
                            pp = con.prepareStatement("SELECT * FROM CUSTOMER where USERNAME=?");   //getting customer id
                            pp.setString(1, (String) request.getSession().getAttribute("customer"));
                            ResultSet rs = pp.executeQuery();
                            while (rs.next()) {
                                id = rs.getInt("CUSTOMERID");

                            }

                            pp = con.prepareStatement("SELECT * FROM BOOKING where CUSTOMERID=? and STATUS=?"); //getting all pending requests
                            pp.setInt(1, id);
                            pp.setString(2, "pending");
                            rs = pp.executeQuery();
                            while (rs.next()) {
                                //inserting data to table
                        %>
                        <td><%=rs.getInt("BOOKINGID")%></td>    
                        <td><%=rs.getInt("CUSTOMERID")%></td>                
                        <td><%=rs.getString("ORIGIN")%></td>
                        <td><%=rs.getString("DESTINATION")%></td>
                        <td><%=rs.getInt("TOTAL")%></td>
                        <td><%=gst = (rs.getInt("TOTAL") * 5 / 100) + rs.getInt("TOTAL")%></td> 
                        <td><%= rs.getString("STATUS")%></td>
                        <tr></tr>

                        <%

                            }

                        %>
                        <input type="submit" value = "Cancel" name = "delete">
                        <input type="text" name = "id" placeholder="booking id" required> 
                    </table>
                </div>
            </form>   
        </div>

        <script>

            <%                Object added = request.getSession().getAttribute("bookingAdded");   //getting session
                if (added != null) {  //if it is not null
            %>
            alert("Booking Added"); //alert it is added
            <%
                    session.removeAttribute("bookingAdded"); //after that removing session so it can be created again when something new is added
                } else {  //else do nothing

                }

                Object bookingDeleted = request.getSession().getAttribute("bookingDeleted");   //getting session
                if (bookingDeleted != null) {  //if it is not null
            %>
                    alert("Booking Cancelled"); //alert it is cancelled
            <%
                    session.removeAttribute("bookingDeleted"); //after that removing session so it can be created again when something is cancelled
                } else {  //else do nothing

                }
                Object bookingDeletedFail2 = request.getSession().getAttribute("bookingDeletedFail");   //getting session
                if (bookingDeletedFail2 != null) {  //if it is not null
            %>
                    alert("Couldn't cancel booking"); //alert couldn't cancel
            <%
                    session.removeAttribute("bookingDeletedFail"); //after that removing session so it can be created again when it couldn't cancel booking
                } else {  //else do nothing

                }
            %>

        </script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#body').show();
                $('#msg').hide();


            }
            );
        </script>

    </body>
</html>
