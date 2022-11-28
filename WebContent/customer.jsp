<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<h1>Customer Profile</h1>
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
if(authenticatedUser==username){
try 
{
	String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId FROM customer";
	PreparedStatement pstmt1 = con.prepareStatement(sql);
	ResultSet rst1 = pstmt1.executeQuery();
	out.println("<table border='2px' border-style='ridge'><tr><td class='tableheader'><b>Id</b></td></tr><tr>><td class='tableheader'><b>FirstName</b></td></tr><tr><td class='tableheader'><b>Last Name</b></td></tr><tr><td class='tableheader'><b>Email</b></td></tr><tr><td class='tableheader'><b>Phone</b></td></tr><tr><td class='tableheader'><b>Address</b></td></tr><tr><td class='tableheader'><b>City</b></td></tr><tr><td class='tableheader'><b>State</b></td></tr><tr><td class='tableheader'><b>Postal Code</b></td></tr><tr><td class='tableheader'><b>Country</b></td></tr><tr><td class='tableheader'><b>User id</b></td></tr>");
	while(rst1.next())
	{
		String customId = rst1.getString("customerId");
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

		out.println("<tr><td>" + customId + "</td><td>" + first + "</td><td>" + last + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + address + "</td><td>" + city + "</td><td>" + state + "</td><td>" + postal + "</td><td>" + country + "</td><td>" + userid + "</td></tr>");
	
		out.println("</table></td></tr>");
	}
	out.print("</table>");
}
catch (Exception e)
{
	out.print("SQLException: " + e);
}
}

// Make sure to close connection
%>

</body>
</html>

