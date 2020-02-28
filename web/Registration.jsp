
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/CustomerRegistration.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Reg</title>
    </head>
    <body>

            <form class="box" action="CRegistrationServlet.do" method="post">
                <h1>Customer Registration</h1>
                <input type="text" name="name" placeholder="Name">
                <input type="email" name="email" placeholder="example1234@gmail.com" multiple>
                <input type="text" name="username" placeholder="Username">
                <input type="password" name="password" placeholder="Password">
                <input type="submit" name="register" value="Register">
            </form>
    </body>
</html>