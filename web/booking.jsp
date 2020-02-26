<%-- 
    Document   : booking
    Created on : Jan 2, 2020, 6:14:26 PM
    Author     : NUser1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/js/jquery.timepicker.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/jquery-ui/jquery-ui.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/jquery-ui/jquery-ui.structure.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/jquery-ui/jquery-ui.theme.min.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/navbar.css"> 
        <script type="text/javascript" 
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDp71SgjtxJz9FeNJ8JkmfLH7ISPVQHPdo"></script>
        <script src="${pageContext.servletContext.contextPath}/js/jquery.min.js"></script>        
        <script src="${pageContext.servletContext.contextPath}/jquery-ui/jquery-ui.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/js/jquery.timepicker.min.js"></script>
        
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
        
        <div>

            <p>Origin: <input id ="origin" type="text" name="origin" required> </p>
            <br>
            <p>Destination: <input id ="destination" type="text" name="destination" required> </p>       
            <br>
            <p>Date: <input id ="date" type="text" name="date" required> </p>       
            <br>
            <p>time: <input id ="time" type="text" name="time" required> </p>       
            <br>
            <button id = "button1">Submit</button>


            <form action="${pageContext.servletContext.contextPath}/calcServlet.do" method="post">
                <input id ="origin2" type="hidden" name="origin2"> 
                <input id ="destination2" type="hidden" name="destination2">
                <input id ="distance2" type="hidden" name="distance2" value ="0">
                <input id ="duration2" type="hidden" name="duration2" value ="0">
                <input id ="time2" type="hidden" name="time2" value ="0"> 
                <input id ="date2" type="hidden" name="date2" value ="0"> 
                <input id ="status" type="hidden" name="status" value ="pending">    
                <br>
                <button id ="button2">Booking</button>
            </form>
        </div>
        <div id="map" style="width: 500px; height: 200px;"></div> 
        <div id="duration">Duration: </div> 
        <div id="distance">Distance: </div>
        <div id="sum">Sum: </div>


        <script>


            $(document).ready(function () {

                $("#button1").click(initMap);
                $("#date").datepicker();
                $("#time").timepicker();
                function initMap() {
                    var directionsService = new google.maps.DirectionsService();
                    var directionsDisplay = new google.maps.DirectionsRenderer();

                    var myOptions = {
                        zoom: 7,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    var map = new google.maps.Map(document.getElementById("map"), myOptions);
                    directionsDisplay.setMap(map);
                    var o2 = document.getElementById('origin').value;
                    var d2 = document.getElementById('destination').value;
                    var t = document.getElementById('date').value;
                    var d = document.getElementById('time').value;
                    document.getElementById('date2').value = t;
                    document.getElementById('time2').value = d;
                    document.getElementById('origin2').value = o2;
                    document.getElementById('destination2').value = d2;
                    var request = {
                        origin: o2,
                        destination: d2,
                        travelMode: google.maps.DirectionsTravelMode.DRIVING
                    };

                    directionsService.route(request, function (response, status) {
                        if (status == google.maps.DirectionsStatus.OK) {

                            document.getElementById('distance').innerHTML +=
                                    response.routes[0].legs[0].distance.value + " meters";
                            document.getElementById('duration').innerHTML +=
                                    response.routes[0].legs[0].duration.value + " seconds";
                            //document.getElementById('distance').value = response.routes[0].legs[0].distance.value;
                            //document.getElementById('duration').value = response.routes[0].legs[0].duration.value;

                            document.getElementById('distance2').value = response.routes[0].legs[0].distance.value;
                            document.getElementById('duration2').value = response.routes[0].legs[0].duration.value;
                            directionsDisplay.setDirections(response);
                            var bookingfee = 1.5;
                            var baserate = 0.1;
                            var drivetime = 0.2;
                            var time = response.routes[0].legs[0].duration.value;
                            var distance = response.routes[0].legs[0].distance.value;
                            var sum = (baserate * distance) + (drivetime * time) + bookingfee;
                            document.getElementById('sum').innerHTML += "$" + sum;
                        }
                    });
                }

            });









        </script>

    </body>
</html>
