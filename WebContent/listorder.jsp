<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Order List</title>
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
	.big{
		align-items:center;
		font-family: serif;
		border-color: dodgerblue;
		padding-top: 5px;
		background-color: white;
		border-radius: 5px;
		width: 500px;
		box-shadow: 0 0 10px 0 dodgerblue;
	}
	.small{
		font-family: serif;
		border-color: dodgerblue;
		padding-bottom: 10px;
		padding-top: 5px;
		background-color: white;
		border-radius: 5px;
		width: 500px;
		box-shadow: 0 0 5px 0 dodgerblue;
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

<h2 align='center'>Order List</h2>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
Connection con = DriverManager.getConnection(url, uid, pw);
String sql1;
String sql2;

// Write query to retrieve all order summary records
try 
{
	sql1 = "SELECT orderId, customer.customerId, firstName, lastName, totalAmount" + " FROM ordersummary JOIN customer ON ordersummary.customerId=customer.customerId";
	PreparedStatement pstmt1 = con.prepareStatement(sql1);
	ResultSet rst1 = pstmt1.executeQuery();
	out.println("<table class='big' align='center'><tr align='center'><td class='tableheader'><b>Order ID</b></td><td class='tableheader'><b>Customer ID</b></td><td class='tableheader'><b>Customer Name</b></td><td class='tableheader'><b>Total Amount</b></td></tr>");
	while(rst1.next())
	{
		int ordID = rst1.getInt("orderId");
		String custID = rst1.getString("customerId");
		String custFirst = rst1.getString("firstName");
		String custLast = rst1.getString("lastName");
		String custName = custFirst + " " + custLast;
		double total = rst1.getDouble("totalAmount");


		out.println("<tr align='center'><td>" + ordID + "</td><td>" + custID + "</td><td>" + custName + "</td><td>" + currFormat.format(total) + "</td></tr>");
		out.println("<tr align='center'><td colspan=5 align='right'><table align='left' class='small'>");
		out.println("<tr align='center'><td class='tableheader'><b>Product Id</b></td><td class='tableheader'><b>Quantity</b></td><td class='tableheader'><b>Price</b></td></tr>");
		sql2 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = " + ordID;
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		ResultSet rst2 = pstmt2.executeQuery();
		while(rst2.next())
		{
			String productID = rst2.getString("productId");
			String quant = rst2.getString("quantity");
			double price_ = rst2.getDouble("price");
			out.println("<tr><td align='center'>" + productID + "</td><td align='center'>" + quant + "</td><td align='center'>" + currFormat.format(price_) + "</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.print("</table>");
}
catch (Exception e)
{
	out.print("SQLException: " + e);
}

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
	// Write out product information 

// Close connection
con.close();
%>

</body>
</html>


