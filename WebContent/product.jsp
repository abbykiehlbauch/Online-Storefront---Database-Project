<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
String name = request.getParameter("name");
out.println("<h2>"+name+"</h2>");

// TODO: Retrieve and display info for the product
String id = request.getParameter("id");

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

String sql;
sql = "SELECT productImageURL, productImage, productPrice FROM Product P  WHERE productId = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1, Integer.parseInt(id));
ResultSet rst = pstmt.executeQuery();
String imageUrl;
if(rst.next() == true)
{
    // TODO: If there is a productImageURL, display using IMG tag
    imageUrl = rst.getString("productImageURL");
    if(imageUrl != null)
        out.println("<img src=\"" + imageUrl + "\">");
}


// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
String imageBin;

// TODO: If there is a productBin, display using IMG tag
imageBin = rst.getString("productImage");
if(imageBin != null)
	out.println("<img src=\"displayImage.jsp?id=" + id + "\">");


// out.println("<h4>ID: + "id" + <h4>");
out.println("<h4><b>ID:</b> "+id+"</h4>");
out.println("<h4><b>Price:</b> $"+rst.getString("productPrice")+"</h4>");

// TODO: Add links to Add to Cart and Continue Shopping

out.println("<h3></h3>");
%>

<h3><a href="listprod.jsp">Continue Shopping</a></h3>
</body>
</html>


