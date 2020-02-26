

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
               <a class="active" href="admin.jsp">Home</a>
                <a href="adminCustomer.jsp">Customer</a>
                 <a href="adminDriver.jsp">Driver</a>
                <a href="adminDriverAssign.jsp">Assign Driver</a>
                <a href="adminTurnover.jsp">Turnover</a>
                <form action="${pageContext.servletContext.contextPath}/loginServlet.do" method ="get">
                    <div> 
                        <%
                            if (session.getAttribute("admin") == null) {//if session is null rename button to login else logout
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
        <form action="${pageContext.servletContext.contextPath}/bookingServlet.do" method="post">        
           <table border="2">
                <tr>
                    <td>CUSTOMER ID</td>
                    <td>USERNAME</td>
                    <td>NAME</td>
                    <td>EMAIL</td>
                    
                </tr>  
                <%
                    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                    PreparedStatement pp = null;
                    String status;
                    pp = con.prepareStatement("SELECT * FROM CUSTOMER");    //getting customer details from table
                    
                    ResultSet rs = pp.executeQuery();
                    while (rs.next()) {
                        
                        //putting data in table
                %>      
                <td><%=rs.getInt("CUSTOMERID")%></td>    
                    <td><%=rs.getString("USERNAME")%></td>                
                    <td><%=rs.getString("NAME")%></td>
                    <td><%=rs.getString("EMAIL")%></td> 
                    <<tr></tr>
                    
                <%
                    }
                %>
           </table>
          
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
