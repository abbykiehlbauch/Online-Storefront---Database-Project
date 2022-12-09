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
                        out.println("<li><a href=\"admin.jsp\">Sales Analytics</a></li>");
                        out.println("<li><a href=\"inventory.jsp\">Inventory</a></li>");
                        out.println("<li><a href=\"addProduct.jsp\">Add a product</a></li>");
                        out.println("<li><a href=\"listorder.jsp\">Orders</a></li>");
                        %>
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


