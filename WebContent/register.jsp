<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Register for an account</title>
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
		            box-shadow: 0 0 15px 4px rgba(0,0,0,0.06);
		            border-radius: 10px;
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
                    <li>
                        <a href="listorder.jsp">Past Orders</a>
                    </li>                                
                    <%
                    String userName = (String) session.getAttribute("authenticatedUser");
                    if(userName != null){
                        out.println("<li><a href='listorder.jsp'>Past Orders</a></li>");
                        out.println("<li><a href='customer.jsp'>" + userName + "</a></li>");
                        out.println("<li><a href='logout.jsp'>Sign Out</a></li>");
                    } else {
                        out.println("<li><a href='login.jsp'>Sign In</a></li>");
                        out.println("<li><a href='register.jsp'>Register</a></li>");

                    }
                    %>
                </ul>
            </nav>
        </header>
        <form align="center">
            <img height=150px width=150px src="img/304logo-nobg.png" alt="logo">
    </form>
        <h3 align='center'>Register for an account</h3>
        <br>
            <form align="center" name="AccountCreation" method=post action="validateRegister.jsp">
                <table style="overflow:auto" align="center">
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">First Name:</font></div></td>
                        <td><input placeholder="First Name" type="text" name="First Name"  size=15 maxlength=15></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Last Name:</font></div></td>
                        <td><input placeholder="Last Name" type="text" name="Last Name" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Email:</font></div></td>
                        <td><input placeholder="Email" type="email" name="Email" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Phone Number:</font></div></td>
                        <td><input placeholder="Phone Number" type="text" name="Phone Number" size=15 maxlength="15"></td>                    
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Address:</font></div></td>
                        <td><input placeholder="Address" type="text" name="Address" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">City:</font></div></td>
                        <td><input placeholder="City" type="text" name="City" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Province:</font></div></td>
                        <td><input placeholder="Province" type="text" name="Province" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Postal Code:</font></div></td>
                        <td><input placeholder="Postal Code" type="text" name="Postal Code" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Country:</font></div></td>
                        <td><input placeholder="Country" type="text" name="Country" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">User Id:</font></div></td>                            
                        <td><input placeholder="User Id" type="text" name="User Id" size=15 maxlength="15"></td>
                    </tr>
                    <tr>
                        <td><div align="left"><font face="serif" size="3.5">Password:</font></div></td>
                        <td><input placeholder="Password" type="password" name="password" size=15 maxlength="15"></td>
                    </tr>
                </table>
            </br>
            <input class="submit" type="submit" name="Submit2" value="Create Account">
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
            String SQL = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(SQL);
            if(first != null && last != null && email != null && phone != null && addy != null && city != null && state != null && postal != null && country != null && userid != null && password != null){
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
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException ex){
            out.println(ex);
        }
        finally {
			try
		    {
		        closeConnection();
	        } catch (SQLException e) {
                out.println(e);
		    }
        }
        %>
    </body>
</html>