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
                font-family: serif;
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
                margin: 29px;
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
                                <%
                                String userName = (String) session.getAttribute("authenticatedUser");
                                if(userName != null){
                                        out.println("<li><a href='customer.jsp'>" + userName + "</a></li>");
                                        out.println("<li><a href='logout.jsp'>Sign Out</a></li>");
                                } else {
                                        out.println("<li><a href='login.jsp'>Sign In</a></li>");

                                }
                                %>
                        </ul>
                </nav>
        </header>
<img align='center' src=\'304logo.png\' alt='Company Logo'/>
<h1 align="center">Welcome to Our Personality Store</h1>
<h2  align='center'>Shopping? Browsing? Looking to change your everything about yourself?</h2>
<h3  align='center'>Look no further! We have every type of personality from narcissism to empathy</h3>
</body>
</head>


