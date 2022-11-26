<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<h1>Administrator Sales Report by Dat</h1>
</head>
<body>

    // TODO: Include files auth.jsp and jdbc.jsp
<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%

if(validateLogin == username)
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT totalAmount, orderDate FROM ordersummary GROUP BY orderDate";

%>

</body>
</html>

