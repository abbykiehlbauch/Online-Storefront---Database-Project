<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit your account</title>
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
                                    <li>
                                            <a href="index.jsp">Home</a>
                                    </li>
                                    <li>
                                            <a href="showcart.jsp">Products</a>
                                    </li>
                                    <li>
                                            <a href="checkout.jsp">View Cart</a>
                                    </li>
                                    <%
                                String userName = (String) session.getAttribute("authenticatedUser");
                                if(userName != null){
                                        out.println("<li><a href='listorder.jsp'>Past Orders</a></li>");
                                        %>
                                        <div style="padding-left: 325px;">
                                                <%
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
            <h3 align='center'>Edit your account</h3>
            <br>
            <form align="center" name="EditAccount" method=post action="edit.jsp">
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
                        <td><input type="email" name="Email" size=10 maxlength="100"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Phone Number:</font></div></td>
                        <td><input type="text" name="Phone Number" size=10 maxlength="10"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Address:</font></div></td>
                        <td><input type="text" name="Address" size=10 maxlength="50"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">City:</font></div></td>
                        <td><input type="text" name="City" size=10 maxlength="20"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">State:</font></div></td>
                        <td><input type="text" name="State" size=10 maxlength="20"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Postal Code:</font></div></td>
                        <td><input type="text" name="Postal Code" size=10 maxlength="7"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="3.5">Country:</font></div></td>
                        <td><input type="text" name="Country" size=10 maxlength="20"></td>
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
            <input class="submit" type="submit" name="Submit2" value="Submit Changes">
        </form>
        <%
        session = request.getSession(true);

        String first = request.getParameter("firstName");
        String last = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phonenum");
        String addy = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postal = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");

        try 
		{
			getConnection();
			String SQL = "UPDATE customer SET firstName=?, lastName=?, email=?, phonenum=?, address=?, city=?, state=?, postalCode=?, country=?, userid=?, password=? WHERE userid=?";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, first);
            pstmt.setString(2, last);
            pstmt.setString(3, email);                        
            pstmt.setString(4, phone);
            pstmt.setString(5, addy);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postal);
            pstmt.setString(9, country);
            pstmt.setString(10, userid);
            pstmt.setString(11, password);
            pstmt.executeUpdate();
            out.println("<h2 align='center'>Edits successfully saved!</h2>");
            out.println("<a href='index.jsp'>Home</a>");
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally 
		{
			try
			{
				closeConnection();
			}catch (SQLException e) {
				out.println(e);
			}
		}
        %>
     </body>
</html>