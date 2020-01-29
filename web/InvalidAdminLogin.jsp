<%-- 
    Document   : InvalidCustomerLogin
    Created on : Jan 25, 2020, 6:14:12 AM
    Author     : Igneel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/InvalidAdminLogin.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
         <div class="video-container">
                <div class="color-overlay"></div>
                <video autoplay loop muted>
                    <source src="Loading.mp4" type="video/webm">
                    <source src="Loading.mp4" type="video/mp4">
                </video>
            </div>
        
        <form class="box" action="Home.html" method="post">
            
            <h1>Login</h1>
            <p class="invalid">Invalid username or password</p>
            <input type="text" placeholder="Username">
            <input type="password" placeholder="Password">
            <input type="submit" value="Login">
            <p>Not registered yet? <a href="CustomerRegistration.jsp">Register now</a></p>
            
        </form>
        
    </body>
</html>
