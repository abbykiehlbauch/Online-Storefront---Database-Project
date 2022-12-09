<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="auth.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
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
							<%
                                String userName = (String) session.getAttribute("authenticatedUser");
                                if(userName != null){
                                        out.println("<li><a href='adminIndex.jsp'>Admin Homepage</a></li>");
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
<body>
<h1 align='center'>Recommended and Previously Ordered Products</h1>

<% // Get username
String username = (String) session.getAttribute("authenticatedUser");

//Note: Forces loading of SQL Server driver
try
{	
	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True;";
String uid = "sa";
String pw = "304#sa#pw"; 
Connection con = DriverManager.getConnection(url, uid, pw);

//get customerId
String getId = "SELECT customerId FROM customer WHERE userid = ?";
PreparedStatement getIdPS = con.prepareStatement(getId);
getIdPS.setString(1, username);
ResultSet id = getIdPS.executeQuery();
id.next();
int userid = id.getInt("customerId");

//create dropdown menu for categories
String SQL = "SELECT categoryId, categoryName FROM category";
PreparedStatement pstmtC = con.prepareStatement(SQL);
ResultSet categories = pstmtC.executeQuery();
out.println("<form align='center' method=\"get\" action=\"prodRecs.jsp\">");

out.println("<br><label for=\"recType\">What type of recommendation would you like to see? </label>");
out.println("<select name=\"recType\" id=\"rec-type\">");
out.println("<option value=\"default\"  selected disabled hidden>Choose a type of recommendation</option>");
out.println("<option value=\"prevProducts\">Previously Ordered Products</option>");
out.println("<option value=\"recProducts\">Recommended Products</option>");
out.println("</select>");
out.println("<input type=\"submit\" value=\"Submit\">");


out.println("</form>");
String catId = request.getParameter("recType");

String sql = "";
if(catId != null)
{
	if(catId.equals("prevProducts"))
	{
		out.println("<h2>Back for more?</h2><h3>Here are all the products you've ordered in the past.</h3>");
		sql = "SELECT product.productId, productName, productPrice, product.categoryId, categoryName FROM product JOIN orderproduct ON product.productId = orderproduct.productId JOIN ordersummary ON ordersummary.orderId = orderproduct.orderId JOIN category ON category.categoryId = product.categoryId WHERE customerId = ?";

		PreparedStatement pstmt1 = con.prepareStatement(sql);
		pstmt1.setInt(1, userid);

		ResultSet rst = pstmt1.executeQuery();

		// Print out the ResultSet
		out.print("<table align='center' border='2px' border-style='none'>");
		out.print("<tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>" + "<br>");
		while(rst.next())
		{
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			String prodid = rst.getString("productId");
			String prodname = rst.getString("productName");
			double prodprice = rst.getDouble("productPrice");
			int categoryId = rst.getInt("categoryId");
			String categoryName = rst.getString("categoryName");
			out.print("<tr><td>"+"<a href=\"addcart.jsp?id=" + prodid + "&name=" + prodname + "&price=" + prodprice + "\"" + ">Add to cart</a>" + "</td>");
			out.print("<td>"+" " + "<a href=\"product.jsp?id=" + prodid + "&name=" + prodname + "\"" + "> "+prodname+" </a>"+ "</td>");
			out.print("<td>" + categoryName + "</td>");
			out.print("<td>"+" "+ currFormat.format(rst.getDouble("productPrice")) + "</td></tr>");
		}
	}
	else if(catId.equals("recProducts"))
	{
		out.println("<h2>Wanting something new?</h2><h3>Here are products similar to what you've ordered in the past.</h3>");
		//get list of all the categories the user has ordered from
		String categories1 = "SELECT product.categoryId, categoryName FROM product JOIN orderproduct ON product.productId = orderproduct.productId JOIN ordersummary ON ordersummary.orderId = orderproduct.orderId JOIN category ON category.categoryId = product.categoryId WHERE customerId = ? GROUP BY product.categoryId, categoryName";
		PreparedStatement catPS = con.prepareStatement(categories1);
		catPS.setInt(1, userid);
		ResultSet categ = catPS.executeQuery();
		sql = "SELECT product.productId, productName, productPrice, product.categoryId, categoryName FROM product JOIN category ON category.categoryId = product.categoryId WHERE product.categoryId = null";
		while(categ.next())
		{
			String curr = categ.getString("categoryId");
			sql += " OR product.categoryId = " + curr;
		}
		sql += " GROUP BY product.categoryId, categoryName, product.productId, productName, productPrice";
		
		PreparedStatement pstmt1 = con.prepareStatement(sql);
		ResultSet rst = pstmt1.executeQuery();
		// Print out the ResultSet
		out.print("<table align='center' border='2px' border-style='none'>");
		out.print("<tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>" + "<br>");
		while(rst.next())
		{
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			String prodid = rst.getString("productId");
			String prodname = rst.getString("productName");
			double prodprice = rst.getDouble("productPrice");
			int categoryId = rst.getInt("categoryId");
			String categoryName = rst.getString("categoryName");
			out.print("<tr><td>"+"<a href=\"addcart.jsp?id=" + prodid + "&name=" + prodname + "&price=" + prodprice + "\"" + ">Add to cart</a>" + "</td>");
			out.print("<td>"+" " + "<a href=\"product.jsp?id=" + prodid + "&name=" + prodname + "\"" + "> "+prodname+" </a>"+ "</td>");
			out.print("<td>" + categoryName + "</td>");
			out.print("<td>"+" "+ currFormat.format(rst.getDouble("productPrice")) + "</td></tr>");
				
		}
	}
	out.print("</table>");

}
// Close connection
con.close();
%>
</body>
</html>