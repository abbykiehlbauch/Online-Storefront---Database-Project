<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<h3>Administrator Sales Report by Day</h3>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.nio.*"%>

<%
String username = (String) session.getAttribute("authenticatedUser");

try{		
getConnectionForOrders();

double total=0;
String sql2 = "SELECT totalAmount FROM ordersummary";
Statement stmt2 = con.createStatement();
ResultSet rstt = stmt2.executeQuery(sql2);
while(rstt.next()){
    total = total + rstt.getDouble(1);
}

Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery("SELECT orderDate, SUM(totalAmount) FROM ordersummary GROUP BY orderDate");		
out.println("<table border=\"1\"><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
    out.print("<tr><td>Total sales: </td><td>" + total +"</td></tr>");
while (rst.next()){
        out.println("<tr><td>"+rst.getDate("orderDate")+"</td><td>"+rst.getDouble(2)+"</td></tr>");
        
        
}
out.println("</table>");

}
catch (SQLException ex) { // Close connection with try catch
out.println(ex); 
}finally{
closeConnection();
}

%>

</body>
</html>

