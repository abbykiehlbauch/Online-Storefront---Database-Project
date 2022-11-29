<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<h1>Administrator Sales Report by Day</h1>
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

out.print("<h4 align=\"center\">Total sales all time: "+ total +"</h4>");


Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery("SELECT year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM ordersummary GROUP BY year(orderDate), month(orderDate), day(orderDate)");		
out.println("<table border=\"1\" align=\"center\"><tr><th>Order Date</th><th>Total Amount</th></tr>");
while (rst.next()){
    out.println("<tr><td>"+rst.getInt(1) +"-"+ rst.getInt(2) +"-"+ rst.getInt(3)+"</td>"+"<td>"+rst.getDouble(4)+"</td><tr>");
        
}
out.println("</tr></td></table>");
out.println("</table></div>");

}
catch (SQLException ex) { // Close connection with try catch
out.println(ex); 
}finally{
closeConnection();
}

%>

</body>
</html>

