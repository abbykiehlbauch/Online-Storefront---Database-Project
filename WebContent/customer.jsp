<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
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
	body h2 {
		margin-top: -20px;
	}
	table {
		align-items:center;
		font-family: serif;
		border-color: dodgerblue;
		padding-top: 5px;
		background-color: white;
		border-radius: 5px;
		width: 500px;
		box-shadow: 0 0 10px 0 dodgerblue;
	}
	.edit {
		padding-top: 20px;
		font-size: 20px;
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

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
String username = (String) session.getAttribute("authenticatedUser");
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
%>
<h2 align="center">Customer Profile</h2>
<%
try 
{
	getConnectionForOrders();
	String sql1 = "SELECT * FROM customer WHERE userid='" + username + "'";
	PreparedStatement pstmt1 = con.prepareStatement(sql1);
	ResultSet rst1 = pstmt1.executeQuery();
	if(rst1.next())
	{
		int customId = rst1.getInt(1);
		String first = rst1.getString(2);
		String last = rst1.getString(3);
		String email = rst1.getString(4);
		String phone = rst1.getString(5);
		String address = rst1.getString(6);
		String city = rst1.getString(7);
		String state = rst1.getString(8);
		String postal = rst1.getString(9);
		String country = rst1.getString(10);
		String userid = rst1.getString(11);

		out.println("<table align='center' class='table' border='2px'>");
		out.println("<tr><th><b>Id</b></th><td align='center'>" + customId + "</td></tr>");
		out.println("<tr><th><b>First Name</b></th><td align='center'>" + first + "</td></tr>");
		out.println("<tr><th><b>Last Name</b></th><td align='center'>" + last + "</td></tr>");
		out.println("<tr><th><b>Email</b></th><td align='center'>" + email + "</td></tr>");
		out.println("<tr><th><b>Phone Number</b></th><td align='center'>" + phone + "</td></tr>");
		out.println("<tr><th><b>Address</b></th><td align='center'>" + address + "</td></tr>");
		out.println("<tr><th><b>City</b></th><td align='center'>" + city + "</td></tr>");
		out.println("<tr><th><b>State</b></th><td align='center'>" + state + "</td></tr>");
		out.println("<tr><th><b>Postal Code</b></th><td align='center'>" + postal + "</td></tr>");
		out.println("<tr><th><b>Country</b></th><td align='center'>" + country + "</td></tr>");
		out.println("<tr><th><b>User id</b></th><td align='center'>" + userid + "</td></tr>");
		out.println("</table>");
		closeConnection();

	}

}
catch (Exception e)
{
	out.println(e);
}



// Make sure to close connection
%>
<form align="center" class="edit">
<a href="editAccount.jsp">Edit Account</a>
</form>
</body>
</html>

