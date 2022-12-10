<!DOCTYPE html>
<html>
<head>
    <title>Main Page</title>
<style type="text/css">
        body 
        {
                height: 125vh;
                margin-top: 25px;
                padding: 20px;
                background-size: cover;
                font-family: serif;
        }
        header {
                background-color:dodgerblue;
                position: fixed;
                left: 0;
                right: 0;
                top: 10px;
                height: 40px;
                display: flex;
                align-items: center;
                box-shadow: 0 0 25px 0 black;
        }
        header * {
                display: inline;
        }
        header li {
                margin: 29px;
        }
        header li a{
                color: white;
                text-decoration: none;
        }
        body h1 {
                margin-top: -20px;

        }

</style>
</head>
<body background="img/blue-abstract-gradient-wave-vector-background_53876-111548.jpg.webp">
        <header>
                <nav>
                        <ul>
                                <%
                                String userName = (String) session.getAttribute("authenticatedUser");
                                if(userName != null){
                                        %>
                                        <li><a href='index.jsp'>Home</a></li>
                                        <li><a href='addProduct.jsp'>Add a product</a></li>
                                        <li><a href='admin.jsp'>Sales report</a></li>
                                        <li><a href='listorder.jsp'>Orders</a></li>
                                        <li><a href='inventory.jsp'>Inventory</a></li>

                                        <div style="padding-left: 325px;">
                                                <%
                                        //out.println("<li><a href='adminIndex.jsp'>Admin Homepage</a></li>");
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
        <form align="center">
                <img height=150px width=150px src="img/304logo-nobg.png" alt="logo">
        </form>
        <h1  align="center"><font color='black'>Admin page</h1>
</body>
</head>


