
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/DriverLogin.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Driver Login</title>
    </head>
    <body>     
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
            <input type="hidden" name = "loginPost" value = "loginPost">
            <input type="submit" value = "login">
            <p>Not a registered driver yet? <a href="driverRegistration.jsp">Register now</a></p>
        </form>
        <script>

            $(document).ready(function () {

            <%  
            
            String name2 = (String) session.getAttribute("driver");
            String name3 = (String) session.getAttribute("customer"); 
            String name4 = (String) session.getAttribute("admin"); 
            if (name2 != null) {    //if session is not found then it will redirect to driverlogin
                response.sendRedirect("driverView/driver.jsp");
            } else if(name3 != null) {
                response.sendRedirect("customerView/customer.jsp");
            }else if(name4 != null){
                response.sendRedirect("adminView/admin.jsp");
            }else{
                    
            }
            
            %>
            });

        </script>
    </body>
</html>
