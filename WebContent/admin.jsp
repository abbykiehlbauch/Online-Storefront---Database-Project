<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%

if(validateLogin == username)
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT totalAmount FROM ordersummary GROUP BY orderDate";

%>

</body>
</html>

