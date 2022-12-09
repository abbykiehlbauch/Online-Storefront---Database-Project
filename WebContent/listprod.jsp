<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
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
	table {
		border: 4px;
		color: black;
		border-style: inset;
		border-radius: 20px;
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
<h1 align='center'>Search for the products you want to buy:</h1>

<form align='center' method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)

<h3>Need some inspiration? Check out your recommended products <a href = "prodRecs.jsp">here</a></h3>

<% // Get product name to search for

String name = request.getParameter("productName");
		
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

//create dropdown menu for categories
String SQL = "SELECT categoryId, categoryName FROM category";
PreparedStatement pstmtC = con.prepareStatement(SQL);
ResultSet categories = pstmtC.executeQuery();
out.println("<br><label for=\"categories\">Choose a category:</label>");
out.println("<select name=\"categoriesDropDown\" id=\"category-spinner\">");
out.println("<option value=\"none\" selected disabled hidden>Select an Option</option>");

while(categories.next())
{
	out.println("<option value=\"" + categories.getInt("categoryId") + "\">" + categories.getString("CategoryName") + "</option>");
}
out.println("</select>");
out.println("</form>");
String catId = request.getParameter("categoriesDropDown");

String sql;
if(name != null && catId !=null)
{
	sql = "SELECT productId, productName, productPrice, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE '%" + name + "%'" + "AND product.categoryId ="+ catId;
	out.println("<h2>Products containing '" + name + "'</h2>");
}

else if(catId == null)
{
	if(name == null)
		sql = "SELECT productId, productName, productPrice, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId";
	else
		sql = "SELECT productId, productName, productPrice, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE '%" + name + "%'";
}

else
{
	sql = "SELECT productId, productName, productPrice, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId";
	out.println("<h2>All products</h2>");
}
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();
// Print out the ResultSet
out.print("<table align='center'>");
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
out.print("</table>");
// Close connection
con.close();
%>
</body>
</html>