

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

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css"> 
        <script src="${pageContext.servletContext.contextPath}/js/jquery.min.js"></script>        


        <title>JSP Page</title>
    </head>
    <body>

        <div id="msg" style="font-size:largest;">

            Loading, please wait...
        </div>
        <div id="body" style="display:none;">

            <div class="topnav">
                <a class="active" href="driver.jsp">Home</a>
                <a href="viewBooking.jsp">View Booking</a>
                <a href="profile.jsp">Profile</a>
                <form action="${pageContext.servletContext.contextPath}/loginServlet.do" method ="get">
                    <div> 
                        <%
                            if (session.getAttribute("driver") == null) {//if session is null rename button to login else logout
                                //when clicked it opens customerlogin page
                        %>
                        <input type="hidden" name = "loginGet" value = "loginGet">
                        <button type="submit">Login</button>  
                        <%
                        } else {          //using function to run code when clicked
                        %>
                        <input type="hidden" name = "logout" value = "logout">
                        <button type="submit">Logout</button>
                        <%
                            }
                        %>        
                    </div>
                </form>
            </div>
            <form action="${pageContext.servletContext.contextPath}/bookingServlet3.do" method ="post">          
                <table border="2">
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
            </form>     
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#body').show();
                $('#msg').hide();
            });
        </script>

    </body>
</html>
