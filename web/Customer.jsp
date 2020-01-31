
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/Customer.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Page</title>
    </head>
    <body>
        <form action="loginServlet.do" method ="get">
        <div> 
            <%
                if (session.getAttribute("customer") == null) {//if session is null rename button to login else logout
                    //when clicked it opens customerlogin page
            %>                                              
            <button type="button" onclick="location.href = 'CustomerLogin.jsp'">Login</button>  
            <%
            } else {          //using function to run code when clicked
            %>
            <button type="submit">Logout</button>
            <%
                }
            %>        
        </div>
       </form>
        <section>
            <%
                String name = (String) session.getAttribute("customer");  //getting session with username
                if (name != null) { //if it's not null
                    out.println("<font color=green size=5px>"+ "Welcome! " + name + "</font>");
                } else {    
                    out.println("cannot find"); 
                }
            %>
            <h1>You are logged in to customer page</h1>

            <br>

            <h2>Under Construction</h2>

            <p id="countdown"></p>
        </section>
        <script>
            $(document).ready(function () {
                
                <%  
                    String name2 = (String) session.getAttribute("customer"); 
                if (name2 != null) {    //if session is not found then it will redirect to customerlogin
                    
                } else {
                    response.sendRedirect("CustomerLogin.jsp");
                }
                %>
            });
        </script>
        <script>
            // Set the date we're counting down to
            var countDownDate = new Date("Feb 27, 2020 18:00:00").getTime();

            // Update the count down every 1 second
            var x = setInterval(function () {

                // Get today's date and time
                var now = new Date().getTime();

                // Find the distance between now and the count down date
                var distance = countDownDate - now;

                // Time calculations for days, hours, minutes and seconds
                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                // Output the result in an element with id="demo"
                document.getElementById("countdown").innerHTML = days + "d " + hours + "h "
                        + minutes + "m " + seconds + "s ";

                // If the count down is over, write some text 
                if (distance < 0) {
                    clearInterval(x);
                    document.getElementById("countdown").innerHTML = "EXPIRED";
                }
            }, 1000);
        </script>
    </body>



</html>
