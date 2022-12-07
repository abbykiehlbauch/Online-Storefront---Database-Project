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
                margin: 18.5px;
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
                                        <a href="index.jsp">Home</a>
                                </li>
                                <li>
                                        <a href="listprod.jsp">Products</a>
                                </li>
                                <li>
                                        <a href="checkout.jsp">View Cart</a>
                                </li>
                                <li>
                                        <a href="listorder.jsp">Past Orders</a>
                                </li>
                                <li>
                                        <a href="register.jsp">Register</a>
                                </li>
                                <li>
                                        <a href="login.jsp">Sign In</a>
                                </li>
                                <li>
                                        <a href="logout.jsp">Sign Out</a>
                                </li>
                                <li>
                                        <a href="customer.jsp">Account</a>
                                </li>
                        </ul>
                </nav>
        </header>
<img align='center' src=\'304logo.png\' alt='Company Logo'/>
<h1 align="center">Welcome to Our Grocery</h1>
<!-- 
<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2> -->
<%
// TODO: Display user name that is logged in (or nothing if not logged in)
String userName = (String) session.getAttribute("authenticatedUser");
if(userName != null)
{
        out.println("<h1 align='center'>" + userName + "</h1>");
}
else 
{
        out.println("");
}

%>
</body>
</head>


