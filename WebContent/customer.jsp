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
String username = (String) session.getAttribute("authenticatedUser");
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
%>
<h3 align="center">Customer Profile</h3>
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

		out.println("<table class='table' border='2'>");
		out.println("<tr><th><b>Id</b></th><td>" + customId + "</td></tr>");
		out.println("<tr><th><b>First Name</b></th><td>" + first + "</td></tr>");
		out.println("<tr><th><b>Last Name</b></th><td>" + last + "</td></tr>");
		out.println("<tr><th><b>Email</b></th><td>" + email + "</td></tr>");
		out.println("<tr><th><b>Phone Number</b></th><td>" + phone + "</td></tr>");
		out.println("<tr><th><b>Address</b></th><td>" + address + "</td></tr>");
		out.println("<tr><th><b>City</b></th><td>" + city + "</td></tr>");
		out.println("<tr><th><b>State</b></th><td>" + state + "</td></tr>");
		out.println("<tr><th><b>Postal Code</b></th><td>" + postal + "</td></tr>");
		out.println("<tr><th><b>Country</b></th><td>" + country + "</td></tr>");
		out.println("<tr><th><b>User id</b></th><td>" + email + "</td></tr>");
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
</body>
</html>

