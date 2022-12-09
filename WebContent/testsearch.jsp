<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Test Page</title>
        <script>
            function searchdata(a)
            {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange=function()
                {
                    document.getElementById("res").innerHTML= xmlhttp.responseText;
                }
                xmlhttp.open("POST", "testdisplay.jsp?q="+a, true);
                xmlhttp.send();
            }

        </script>
    </head>
    <body background="img/blue-abstract-gradient-wave-vector-background_53876-111548.jpg.webp">
        <header>
            <nav>
                    <ul>
                            <li>
                                    <a href="index.jsp">Home</a>
                            </li>
                            <li>
                                    <a href="listprod.jsp">Products</a>
                            </li>
                            <li>
                                    <a href="showcart.jsp">View Cart</a>
                            </li>
                            <%
                            String userName = (String) session.getAttribute("authenticatedUser");
                            if(userName != null){
                                    %>
                                    <div style="padding-left: 325px;">
                                            <%
                                    out.println("<li><a href='adminIndex.jsp'>Admin Homepage</a></li>");
                                    out.println("<li><a href='customer.jsp'>" + userName + "</a></li>");
                                    out.println("<li><a href='logout.jsp'>Sign Out</a></li>");
                                    %>
                                    </div>
                                    <%
                            } else {
                                    %>
                                    <div style="padding-left: 450px;">
                                            <%
                                    out.println("<li><a href='register.jsp'>Register</a></li>");
                                    out.println("<li><a href='login.jsp'>Sign In</a></li>");
                                    %>
                            </div>
                            <%
                            }
                            %>
                    </ul>
            </nav>
    </header>
        <input type="text" id="txtsearch" onkeyup="searchdata(this.value)" />

        <br>
        <div id="res"></div>
    </body>
</html>