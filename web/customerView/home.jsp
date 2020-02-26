

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
                <a href="viewBooking.jsp">View Booking</a>
                <a href="about.jsp">About</a>
                <a href="contact.jsp">Contact</a>
                <form action="${pageContext.servletContext.contextPath}/loginServlet.do" method ="get">
                    <div> 
                        <%
                            if (session.getAttribute("customer") == null) {//if session is null rename button to login else logout
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
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#body').show();
                $('#msg').hide();
            });
        </script>

    </body>
</html>
