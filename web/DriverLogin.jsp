<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/angular-material/1.1.8/angular-material.min.css" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/DriverLogin.css"/>
        <title>Driver Login</title>
    </head>
    <body>  

        <div class="section"></div>
        <main>
            <center>
                <div class="section"></div>


                <div class="section"></div>

                <div class="container">
                    <div class="z-depth-1 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">

                        <h5 class="indigo-text">Login</h5>
                        <form class="col s12" action="loginServlet.do" method="post">
                            <div class='row'>
                                <div class='col s12'>
                                </div>
                            </div>

                            <%
                                String login_msg = (String) request.getAttribute("error");  //checking if error session is made
                                if (login_msg != null) {
                                    out.println("<font color=red size=4px>" + login_msg + "</font>");
                                }
                            %>
                            <div class='row'>
                                <div class='input-field col s12'>
                                    <input class='validate' type="text" name = "username" required>
                                    <label for='username'>Enter your username</label>
                                </div>
                            </div>

                            <div class='row'>
                                <div class='input-field col s12'>
                                    <input class='validate' type='password' name="password" required>
                                    <label for='password'>Enter your password</label>
                                </div>
                                <label style='float: right;'>
                                    <a class='pink-text' href='#!'><b>Forgot Password?</b></a>
                                </label>
                            </div>

                            <br />
                            <center>
                                <div class='row'>
                                    <input type="hidden" name = "page" value = "DriverLogin.jsp">
                                    <input type="hidden" name = "loginPost" value = "loginPost">
                                    <button type='submit' value = "login" class='col s12 btn btn-large waves-effect indigo'>Login</button>
                                </div>
                            </center>
                        </form>
                    </div>
                </div>
                <p>Not registered yet? <a href="registration.jsp">Register now</a></p>
                <p>Are you a registered driver? <a href="DriverLogin.jsp">Login as a driver</a></p>
            </center>

            <div class="section"></div>
            <div class="section"></div>
        </main>
        
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
        <script>

            $(document).ready(function () {

            <%
                String name2 = (String) session.getAttribute("driver");
                String name3 = (String) session.getAttribute("customer");
                String name4 = (String) session.getAttribute("admin");
                if (name2 != null) {    //if session is not found then it will redirect to driverlogin
                    response.sendRedirect("driverView/driver.jsp");
                } else if (name3 != null) {
                    response.sendRedirect("customerView/customer.jsp");
                } else if (name4 != null) {
                    response.sendRedirect("adminView/admin.jsp");
                } else {

                }

            %>
            });

        </script>
    </body>
</html>
