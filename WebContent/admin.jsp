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

out.print("<h4 align=\"center\">Total sales: "+ total +"</h4>");


Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery("SELECT orderDate, SUM(totalAmount) FROM ordersummary GROUP BY orderDate");		
String sql = "SELECT productId, quantity, price FROM orderproduct JOIN ordersummary ON orderproduct.orderId = ordersummary.orderId WHERE ordersummary.orderId = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
out.println("<table border=\"1\" align=\"center\"><tr><th>Order Date</th><th>Total Amount</th></tr>");
while (rst.next()){
        out.println("<tr><td>"+rst.getDate("orderDate")+"</td>"+"<td>"+rst.getDouble(2)+"</td>"+"</td><tr>");
        /*
        pstmt.setInt(1, rst.getInt(1));
        ResultSet rst2 = pstmt.executeQuery();
        out.println("<tr align=\"right\"><td colspan=\"5\"><table border=\"1\">");
        out.println("<tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
        while(rst2.next()){
            out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getInt(2)+"</td>"+"<td>"+rst2.getDouble(3)+"</td></tr>");
        }
        */
        
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

