<!DOCTYPE html>
<html>
    <head>
        <title>Register for an account</title>
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
                <h3 align='center'>Register for an account</h3>
                <br>
                <form align="center" name="AccountCreation" method=post action="createAccount.jsp">
                    <table style="overflow:auto" align="center">
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">First Name:</font></div></td>
                            <td><input type="text" name="First Name"  size=10 maxlength=10></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Last Name:</font></div></td>
                            <td><input type="text" name="Last Name" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Email:</font></div></td>
                            <td><input type="email" name="Email" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Phone Number:</font></div></td>
                            <td><input type="text" name="Phone Number" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Address:</font></div></td>
                            <td><input type="text" name="Address" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">City:</font></div></td>
                            <td><input type="text" name="City" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">State:</font></div></td>
                            <td><input type="text" name="State" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Postal Code:</font></div></td>
                            <td><input type="text" name="Postal Code" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Country:</font></div></td>
                            <td><input type="text" name="Country" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">User Id:</font></div></td>
                            <td><input type="text" name="User Id" size=10 maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Password:</font></div></td>
                            <td><input type="password" name="password" size=10 maxlength="10"></td>
                        </tr>
                    </table>
                </br>
                <input class="submit" type="submit" name="Submit2" value="Create Account">
            </form>
        </body>
        </html>