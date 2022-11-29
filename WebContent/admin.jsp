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
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
String username = (String) session.getAttribute("authenticatedUser");

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

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
ResultSet rst = stmt.executeQuery("SELECT year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM ordersummary GROUP BY year(orderDate), month(orderDate), day(orderDate)");		
out.println("<table border=\"1\"><tr><th>Order Date</th><th>Total Amount</th></tr>");
out.print("<tr><td>null-null-null</td><td>" + currFormat.format(total) + "</td></tr>");

while (rst.next()){
    out.println("<tr><td>"+rst.getInt(1) +"-"+ rst.getInt(2) +"-"+ rst.getInt(3)+"</td><td>"+ currFormat.format(rst.getDouble(4)) +"</td><tr>");
        
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

