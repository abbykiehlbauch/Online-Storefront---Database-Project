<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
try 
{
	String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId FROM customer";
	PreparedStatement pstmt1 = con.prepareStatement(sql);
	ResultSet rst1 = pstmt1.executeQuery();
	out.println("<table border='2px' border-style='ridge'><tr><td class='tableheader'><b>Id</b></td></tr><tr>><td class='tableheader'><b>FirstName</b></td></tr><tr><td class='tableheader'><b>Last Name</b></td></tr><tr><td class='tableheader'><b>Email</b></td></tr><tr><td class='tableheader'><b>Phone</b></td></tr><tr><td class='tableheader'><b>Address</b></td></tr><tr><td class='tableheader'><b>City</b></td></tr><tr><td class='tableheader'><b>State</b></td></tr><tr><td class='tableheader'><b>Postal Code</b></td></tr><tr><td class='tableheader'><b>Country</b></td></tr><tr><td class='tableheader'><b>User id</b></td></tr>");
	while(rst1.next())
	{
		String custId = rst1.getString("customerId");
		String first = rst1.getString("firstName");
		String last = rst1.getString("lastName");
		String email = rst1.getString("email");
		String phone = rst1.getString("phonenum");
		String address = rst1.getString("address");
		String city = rst1.getString("city");
		String state = rst1.getString("state");
		String postal = rst1.getString("postalCode");
		String country = rst1.getString("country");
		String userid = rst1.getString("userid");

		out.println("<tr><td>" + custId + "</td></tr><tr><td>" + custID + "</td></tr><tr><td>" + firstName + "</td></tr><tr><td>" + lastName + "</td></tr><tr><td>" + email + </td></tr><tr><td>" + phone + "</td></tr><tr><td>" + address + "</td></tr><tr><td>" + );
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


// Make sure to close connection
%>

</body>
</html>

