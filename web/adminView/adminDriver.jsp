<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/angular-material/1.1.8/angular-material.min.css" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css"> 
        <script src="${pageContext.servletContext.contextPath}/js/jquery.min.js"></script>        
        <title>JSP Page</title>
    </head>
    <body>

        <div id="msg" style="font-size:largest;">

            Loading, please wait...
        </div>
        <div id="body" style="display:none;">

            <nav>
                <div class="nav-wrapper">
                    <a href="#" class="brand-logo center">Admin Panel</a>
                    <ul class="right hide-on-med-and-down">
                        <li>
                            <form action="${pageContext.servletContext.contextPath}/loginServlet.do" method ="get">
                                <%
                                    if (session.getAttribute("admin") == null) {//if session is null rename button to login else logout
                                        //when clicked it opens customerlogin page
                                %>
                                <input type="hidden" name = "loginGet" value = "loginGet">
                                <a><button type="submit" class="waves-effect waves-light btn">Login</button></a> 
                                <%
                                } else {          //using function to run code when clicked
                                %>
                                <input type="hidden" name = "logout" value = "logout">
                                <li><a><button type="submit" class="waves-effect waves-light btn">Logout</button></a></li>
                                            <%
                                                }
                                            %>        
                            </form>
                        </li>
                    </ul>



                    <ul class="dropdown-content" id="user_dropdown">

                        <li><a href="#!">Profile</a></li>

                    </ul>
                    <ul id="nav-mobile" class="left hide-on-med-and-down">
                        <li><a class="active" href="admin.jsp">Home</a></li>
                        <li><a href="adminCustomer.jsp">Customer</a></li>
                        <li><a href="adminDriver.jsp">Driver</a></li>
                        <li><a href="adminDriverAssign.jsp">Assign Driver</a></li>
                        <li><a href="adminTurnover.jsp">Turnover</a></li>
                    </ul>
                </div>
            </nav>
            <form action="${pageContext.servletContext.contextPath}/AddDriver.do" method="post">        
                <div id="customer1" class="col s12">
                    <table class="respnsive-table highlight">
                        <tr>
                            <td>DRIVER ID</td>
                            <td>USERNAME</td>
                            <td>NAME</td>
                            <td>EMAIL</td>
                        </tr>  
                        <%
                            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/SprintTwoDatabase", "root", "root");
                            PreparedStatement pp = null;
                            String status;
                            pp = con.prepareStatement("SELECT * FROM DRIVER");  //getting driver details from table

                            ResultSet rs = pp.executeQuery();
                            while (rs.next()) {

                                //inserting data to table
%>
                        <td><%=rs.getInt("DRIVERID")%></td>    
                        <td><%=rs.getString("USERNAME")%></td>                
                        <td><%=rs.getString("NAME")%></td>
                        <td><%=rs.getString("EMAIL")%></td> 
                        <tr></tr>

                        <%
                            }
                        %>
                        <div id="adddriver" class="modal">
                            <div class="modal-content">
                                <h4 class="indigo-text">Add Driver</h4>
                                <div class="col s6">
                                    <form class="">
                                        <div class="row">
                                            <div class="input-field col s12">
                                                <input id="username" name="username" type="text" class="validate" required>
                                                <label for="username">Username</label>
                                            </div>
                                            <div class="input-field col s12">
                                                <input id="name" name="name" type="text" class="validate" required>
                                                <label for="name">Name</label>
                                            </div>
                                            <div class="input-field col s12">
                                                <input id="email" name="email" type="email" class="validate" required>
                                                <label for="email">Email</label>
                                            </div>
                                            <div class="input-field col s12">
                                                <input id="password" name="password" type="password" class="validate" required>
                                                <label for="Password">Password</label>
                                            </div>
                                            <div class="input-field col s12">
                                                <button id= "add" value="add" name="add" type="submit" class="waves-effect waves-light btn">Add Driver</button>
                                            </div>
                                        </div>	
                                    </form>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
                            </div>
                        </div> 
                    </table>
                    <a class="waves-effect waves-light btn modal-trigger" href="#adddriver">Add</a>
                </div>
            </form>
        </div>
        <form action="${pageContext.servletContext.contextPath}/DeleteDriver.do" method="post">
            <input type="text" placeholder="Driver ID" name = "driverID" required> 
            <button id= "delete" value="delete" name="delete" type="submit" class="waves-effect waves-light btn">Delete</button>
        </form>

        <form action="${pageContext.servletContext.contextPath}/EditDriver.do" method="post">
            <div id="fields" style="display:none">
                <div class="row">
                    <div class="input-field col s1">
                        <input type="text" name="driverID" placeholder="Driver ID" required>
                    </div>
                    <div class="input-field col s2">
                        <input type="text" name="username" placeholder="Username" required>
                    </div>
                    <div class="input-field col s3">
                        <input type="text" name="name" placeholder="Name" required>
                    </div>
                    <div class="input-field col s3">
                        <input type="password" name="password" placeholder="Password" required>
                    </div>
                    <div class="input-field col s3">
                        <input type="email" name="email" placeholder="Email" required>
                    </div>
                    <div class="row">
                        <div class="input-field col s2 right">
                            <button value="save" id="save" name="save" type="submit" class="waves-effect waves-light btn">Save</button>
                            <button value="cancel" id="cancel" name="cancel" type="submit" class="waves-effect waves-light btn">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>

        </form>
        <button id="contact-btn" class="waves-effect waves-light btn" onClick="toggleFields()">
            Edit
        </button

    </form>
</div>
<script>
    <%
        Object added = request.getSession().getAttribute("driverAdded");   //getting session
        if (added != null) {  //if it is not null
    %>
            alert("Driver Added"); //alert it is added
    <%
            session.removeAttribute("driverAdded"); //after that removing session so it can be created again when something new is added
        } else {  //else do nothing

        }

        Object removed = request.getSession().getAttribute("driverRemoved");   //getting session
        if (removed != null) {  //if it is not null
    %>
            alert("Driver Removed"); //alert it is removed
    <%
            session.removeAttribute("driverRemoved"); //after that removing session so it can be created again when something is removed
        } else {  //else do nothing

        }

        Object edit = request.getSession().getAttribute("driverEdit");   //getting session
        if (edit != null) {  //if it is not null
    %>
            alert("Driver Edited"); //alert it is edited
    <%
            session.removeAttribute("driverEdit"); //after that removing session so it can be created again when something is edited
        } else {  //else do nothing

        }
        Object removeFail2 = request.getSession().getAttribute("removeFail");   //getting session
        if (removeFail2 != null) {  //if it is not null
    %>
            alert("Couldn't remove driver"); //alert it is edited
    <%
            session.removeAttribute("removeFail"); //after that removing session so it can be created again when something is edited
        } else {  //else do nothing

        }
    %>

</script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#body').show();
        $('#msg').hide();
    });

    $(document).ready(function () {
        $('.modal').modal();
    });

    $(document).ready(function () {
        $('.fixed-action-btn').floatingActionButton();
    });

    $(document).ready(function () {
        $('.edit').click(function () {
            var currentTD = $(this).parents('tr').find('td');
            if ($(this).html() == 'Edit') {
                currentTD = $(this).parents('tr').find('td');
                $.each(currentTD, function () {
                    $(this).prop('contenteditable', true)
                });
            } else {
                $.each(currentTD, function () {
                    $(this).prop('contenteditable', false)
                });
            }

            $(this).html($(this).html() == 'Edit' ? 'Save' : 'Edit')

        });

    });

    window.toggleFields = function toggleFields() {
        $('#fields, #contact-btn').toggle();
    }
</script>

</body>
</html>
