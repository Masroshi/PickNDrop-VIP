
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/CustomerLogin.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Login</title>
    </head>
    <body>
        
        <div class="video-container">
                <div class="color-overlay"></div>
                <video autoplay loop muted>
                    <source src="Loading.mp4" type="video/webm">
                    <source src="Loading.mp4" type="video/mp4">
                </video>
            </div>
        
        <form class="box" action="loginServlet.do" method="get">
            
            <h1>Login</h1>
            <%
            String login_msg=(String)request.getAttribute("error");  
            if(login_msg!=null)
            out.println("<font color=red size=4px>"+login_msg+"</font>");
            %>
            <input type="text" placeholder="Username" name = "username">
            <input type="password" placeholder="Password" name = "password">
            <input type="hidden" name = "page" value = "CustomerLogin.jsp">
            <input type="submit" value="Login">
            <p>Not registered yet? <a href="CustomerRegistration.jsp">Register now</a></p>
            <p>Are you a registered driver? <a href="DriverLogin.jsp">Login as a driver</a></p>
            
        </form>
        
    </body>
</html>
