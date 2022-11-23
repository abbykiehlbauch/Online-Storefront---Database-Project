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
String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId FROM customer";

// Make sure to close connection
%>

</body>
</html>

