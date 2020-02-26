

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
            <form action="${pageContext.servletContext.contextPath}/availableServlet.do" method ="post">          
                <table border="2">
                <tr>
                    <td>DRIVER ID</td>
                    <td>USERNAME</td>
                    <td>NAME</td>
                    <td>EMAIL</td>
                    <td>STATUS</td>
                    
                </tr>  
                <%
                    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                    PreparedStatement pp = null;
                    String status;
                     pp = con.prepareStatement("SELECT * FROM DRIVER where USERNAME=?"); //getting driver id
                     pp.setString(1, (String) request.getSession().getAttribute("driver"));
                     ResultSet rs = pp.executeQuery();
                     while(rs.next()){
                        
                        //inserting data to table
                %>
                <td><%=rs.getInt("DRIVERID")%></td>    
                    <td><%=rs.getString("USERNAME")%></td>                
                    <td><%=rs.getString("NAME")%></td>
                    <td><%=rs.getString("EMAIL")%></td> 
                    <td><%=rs.getString("STATUS")%></td> 
                    <<tr></tr>
                    
                <%
                    }
                %>
           </table>
                <input type="submit" name = "available" value ="Available">                
            </form> 
           <form action="${pageContext.servletContext.contextPath}/availableServlet.do" method ="post">
               <input type="submit" name = "notAvailable" value="Not Available">
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
