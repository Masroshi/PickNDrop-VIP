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
                    <a href="#" class="brand-logo center">Admin Panel</a>
                    <ul class="right hide-on-med-and-down">
                        <li>
                            <form action="${pageContext.servletContext.contextPath}/loginServlet.do" method ="get">
                                <%
                                    if (session.getAttribute("admin") == null) {//if session is null rename button to login else logout
                                        //when clicked it opens customerlogin page
                                %>
                                <input type="hidden" name = "loginGet" value = "loginGet">
                                <a><button type="submit" class="waves-effect waves-light btn">Login</button></a> 
                                <%
                                } else {          //using function to run code when clicked
                                %>
                                <input type="hidden" name = "logout" value = "logout">
                                <li><a><button type="submit" class="waves-effect waves-light btn">Logout</button></a></li>
                                            <%
                                                }
                                            %>        
                            </form>
                        </li>
                    </ul>



                    <ul class="dropdown-content" id="user_dropdown">

                        <li><a href="#!">Profile</a></li>

                    </ul>
                    <ul id="nav-mobile" class="left hide-on-med-and-down">
                        <li><a class="active" href="admin.jsp">Home</a></li>
                        <li><a href="adminCustomer.jsp">Customer</a></li>
                        <li><a href="adminDriver.jsp">Driver</a></li>
                        <li><a href="adminDriverAssign.jsp">Assign Driver</a></li>
                        <li><a href="adminTurnover.jsp">Turnover</a></li>
                    </ul>
                </div>
            </nav> 
            <form action="${pageContext.servletContext.contextPath}/bookingServlet2.do" method="post">        
                <div id="customer1" class="col s12">
                    <table class="respnsive-table highlight">
                        <tr>
                            <td>BOOKING ID</td>
                            <td>CUSTOMER ID</td>
                            <td>ORIGIN</td>
                            <td>DESTINATION</td>
                            <td>TOTAL</td>
                            <td>STATUS</td>
                        </tr>  
                        <%
                            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                            PreparedStatement pp = null;
                            String status;
                            pp = con.prepareStatement("SELECT * FROM BOOKING where STATUS=?");  //taking all pending status
                            //pp.setString(1, (String) request.getSession().getAttribute("customer"));
                            pp.setString(1, "pending");
                            ResultSet rs = pp.executeQuery();
                            while (rs.next()) {

                                //inserting to table
                        %>
                        <td><%=rs.getInt("BOOKINGID")%></td>    
                        <td><%=rs.getInt("CUSTOMERID")%></td>                
                        <td><%=rs.getString("ORIGIN")%></td>
                        <td><%=rs.getString("DESTINATION")%></td>
                        <td><%=rs.getInt("TOTAL")%></td>
                        <td><%=rs.getString("STATUS")%></td> 
                        <tr></tr>
                        <%
                            }
                        %>
                    </table>
                </div>
                <input type="text" name = "bookingID" placeholder="booking id" required>
                <input type="text" placeholder="driver id" name = "driverID" required>                
                <input type="submit" value ="Assign" name = "assign">
            </form>
        </div>
        <script>
            <%
                Object driverAssigned = request.getSession().getAttribute("driverAssigned");   //getting session
                if (driverAssigned != null) {  //if it is not null
            %>
                    alert("Booking has been assigned to driver"); //alert book has been assigned to driver
            <%
                    session.removeAttribute("driverAssigned"); //after that removing session so it can be created again when it assigns driver
                } else {  //else do nothing

                }
                Object driverAssignedFail = request.getSession().getAttribute("driverAssignedFail");   //getting session
                if (driverAssignedFail != null) {  //if it is not null
            %>
                    alert("Couldn't assign driver. Incorrect booking ID or driver ID"); //alert incorrect booking id or driver id
            <%
                    session.removeAttribute("driverAssignedFail"); //after that removing session so it can be created again when it can't assign driver
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
