
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/DriverLogin.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Driver Login</title>
    </head>
    <body>     
        <div class="video-container">
            <div class="color-overlay"></div>
            <video autoplay loop muted>
                <source src="Loading.mp4" type="video/webm">
                <source src="Loading.mp4" type="video/mp4">
            </video>
        </div>

        <form class="box" action="loginServlet.do" method="post">
            <h1>Driver Login</h1>
            <%
            String login_msg=(String)request.getAttribute("error");  //checking if error session is made
            if(login_msg!=null)
            out.println("<font color=red size=4px>"+login_msg+"</font>");
            %>
            <input type="text" placeholder="Username" required name = "username">
            <input type="password" placeholder="Password" required name = "password">
            <input type="hidden" name = "page" value = "DriverLogin.jsp">
            <input type="submit" value="Login">
            <p>Not a registered driver yet? <a href="DriverRegistration.jsp">Register now</a></p>
        </form>
        <script>

            $(document).ready(function () {

            <%  
            String name2 = (String) session.getAttribute("driver");
            String name3 = (String) session.getAttribute("customer"); 
            String name4 = (String) session.getAttribute("admin"); 
            if (name2 != null) {    //if session is not found then it will redirect to driverlogin
                response.sendRedirect("Driver.jsp");
            } else if(name3 != null) {
                response.sendRedirect("Customer.jsp");
            }else if(name4 != null){
                response.sendRedirect("Admin.jsp");
            }else{
                    
            }
            %>
            });

        </script>
    </body>
</html>
