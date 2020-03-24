<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
                    <a href="#" class="brand-logo center">Driver Profile</a>
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


            <form action="${pageContext.servletContext.contextPath}/availableServlet.do" method ="post">          
                <div id="customer1" class="col s12">
                    <table class="respnsive-table highlight">
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
                            while (rs.next()) {

                                //inserting data to table
%>
                        <td><%=rs.getInt("DRIVERID")%></td>    
                        <td><%=rs.getString("USERNAME")%></td>                
                        <td><%=rs.getString("NAME")%></td>
                        <td><%=rs.getString("EMAIL")%></td> 
                        <td><%=rs.getString("STATUS")%></td> 
                        <tr></tr>

                        <%
                            }
                        %>
                    </table>
                    <input type="submit" name = "available" value ="Available">
                </div>
            </form> 
            <form action="${pageContext.servletContext.contextPath}/availableServlet.do" method ="post">
                <input type="submit" name = "notAvailable" value="Not Available">
            </form>
        </div>
        <script>
            <%
                Object available = request.getSession().getAttribute("available");   //getting session
                if (available != null) {  //if it is not null
            %>
                    alert("Status changed to Available"); //alert status is changed to available
            <%
                    session.removeAttribute("available"); //after that removing session so it can be created again when clicked available button
                } else {  //else do nothing

                }
            
                Object notAvailable = request.getSession().getAttribute("notAvailable");   //getting session
                if (notAvailable != null) {  //if it is not null
            %>
                    alert("Status changed to Not Available"); //alert status is changed to available
            <%
                    session.removeAttribute("notAvailable"); //after that removing session so it can be created again when clicked not available button
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
