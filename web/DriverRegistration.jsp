<%-- 
    Document   : DriverRegistration
    Created on : Jan 22, 2020, 5:28:15 PM
    Author     : Igneel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/DriverRegistration.css"/>
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

            <form class="box" action="DriverRegistration.jsp" method="post">

                <h1>Driver Registration</h1>
                <input type="text" placeholder="Name">
                <input type="email" placeholder="example1234@gmail.com" multiple>
                <input type="text" placeholder="Username">
                <input type="password" placeholder="Password">
                <input type="submit" value="Register">

            </form>
    </body>
</html>
