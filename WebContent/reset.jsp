<!DOCTYPE html>
<html>
    <title>Reset password</title>
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
        input {
            padding:10px;
            border:0;
            box-shadow: 4px 4px 10px rgba(0,0,0,0.06);
            border-radius: 10px;
            align-items: center;
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
                    <form align="center">
                        <img height=150px width=150px src="img/304logo-nobg.png" alt="logo">
        </form>
        <h2 align="center">Reset your password</h2>
        <form align="center" name="AccountCreation" method=post action="login.jsp">
                <br>
                <table style="overflow:auto" align="center">
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Email:</font></div></td>
                        <td><input placeholder="Email" type="email" name="Email" size=15 maxlength="100"></td>
                    </tr>
                </table>
            </br>
            <input class="submit" type="submit" name="Submit2" value="Send reset email">
        </form>
                </body>
</html>