

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
            <a class="active" href="home.jsp">Home</a>
            <a href="booking.jsp">Booking</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
            <button type="button" onclick="location.href = 'login.jsp'">Login</button>
        </div> 
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#body').show();
                $('#msg').hide();
            });
        </script>

    </body>
</html>
