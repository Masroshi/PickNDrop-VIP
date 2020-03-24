<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
                                        if (session.getAttribute("driver") == null) {//if session is null rename button to login else logout
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
                        <li><a class="active" href="driver.jsp">Home</a></li>
                        <li><a href="viewBooking.jsp">View Booking</a></li>
                        <li><a href="profile.jsp">Profile</a></li>
                    </ul>
                </div>
            </nav>
            <form action="${pageContext.servletContext.contextPath}/bookingServlet3.do" method ="post">          
                <div id="customer1" class="col s12">
                    <table class="respnsive-table highlight">
                        <tr>
                            <td>BOOKING ID</td>
                            <td>CUSTOMER ID</td>
                            <td>ORIGIN</td>
                            <td>DESTINATION</td>
                            <td>TOTAL</td>
                        </tr>
                        <%
                            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                            PreparedStatement pp = null;
                            String status;
                            int driverid = 0;
                            pp = con.prepareStatement("SELECT * FROM DRIVER where USERNAME=?"); //getting driver id
                            pp.setString(1, (String) request.getSession().getAttribute("driver"));
                            ResultSet rs = pp.executeQuery();
                            while (rs.next()) {
                                driverid = rs.getInt("DRIVERID");

                            }
                            pp.close();
                            rs.close();
                            pp = con.prepareStatement("SELECT * FROM BOOKING where DRIVERID=? AND STATUS=?");    //taking all assigned requests
                            pp.setInt(1, driverid);
                            pp.setString(2, "ASSIGNED");
                            rs = pp.executeQuery();
                            while (rs.next()) {

                                //inserting to table
%>
                        <td><%=rs.getInt("BOOKINGID")%></td>    
                        <td><%=rs.getInt("CUSTOMERID")%></td>                
                        <td><%=rs.getString("ORIGIN")%></td>
                        <td><%=rs.getString("DESTINATION")%></td>
                        <td><%=rs.getInt("TOTAL")%></td>                   
                        <tr></tr>
                        <%
                            }
                            pp.close();
                            rs.close();
                        %>
                    </table>
                    <input type="text" name = "bookingID" placeholder="booking id" required>
                    <input type="submit" value ="Complete" name = "complete">
                </div>
            </form>     
        </div>
        <script>
            <%
                Object bookingComplete = request.getSession().getAttribute("bookingComplete");   //getting session
                if (bookingComplete != null) {  //if it is not null
            %>
                    alert("Booking completed"); //alert booking completed
            <%
                    session.removeAttribute("bookingComplete"); //after that removing session so it can be created again when it completes booking
                } else {  //else do nothing

                }
                Object bookingCompleteFail = request.getSession().getAttribute("bookingCompleteFail");   //getting session
                if (bookingCompleteFail != null) {  //if it is not null
            %>
                    alert("Couldn't complete booking. Incorrect booking ID"); //alert couldn't complete incorrect booking id
            <%
                    session.removeAttribute("bookingCompleteFail"); //after that removing session so it can be created again when it can't complete booking
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
            });
        </script>

    </body>
</html>
