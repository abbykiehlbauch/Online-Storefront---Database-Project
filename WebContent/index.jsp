<!DOCTYPE html>
<html>
<head>
        <title>Our Grocery Main Page</title>
<style type="text/css">
        body 
        {
                height: 125vh;
                margin-top: 80px;
                padding: 20px;
                background-size: cover;
                font-family: sans-serif;
        }
        header {
                background-color:dodgerblue;
                position: fixed;
                left: 0;
                right: 0;
                top: 5px;
                height: 30px;
                display: flex;
                align-items: center;
                box-shadow: 0 0 25px 0 black;
        }
        header * {
                display: inline;
        }
        header li {
                margin: 25px;
        }
        header li a{
                color: white;
                text-decoration: none;
        }
</style>
</head>
<body>
        <header>
                <nav>
                        <ul>
                                <li>
                                        <a href="#">Home</a>
                                </li>
                                <li>
                                        <a href="#">Products</a>
                                </li>
                                <li>
                                        <a href="#">View Cart</a>
                                </li>
                                <li>
                                        <a href="#">Past Orders</a>
                                </li>
                                <li>
                                        <a href="#">Register</a>
                                </li>
                                <li>
                                        <a href="#">Sign In</a>
                                </li>
                                <li>
                                        <a href="#">Sign Out</a>
                                </li>
                        </ul>
                </nav>
        </header>
<h1 align="center">Welcome to Our Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
String userName = (String) session.getAttribute("authenticatedUser");
if(userName != null)
{
        out.println("<h3 align='center'>" + "Signed in as: " + userName + "</h3>");
        out.println("<h1 align='center'>" + userName + "</h1>");
}
else 
{
        out.println("");
}

%>
</body>
</head>


