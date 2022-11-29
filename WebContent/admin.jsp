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
<%@ page import="java.util.*,java.sql.*,java.io.*,java.nio.*"%>

<%
try{
    getConnection();

    if(!authenticated) {
        String error = "You need to login before accessing this page."
        session.setAttribute("errorMessage", error);
        out.println(errorMessage);
        response.sendRedirect("login.jsp");
    }
    out.println("<h1>Administrator</h1>");
if(validateLogin == username)
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT DISTINCT orderDate, SUM(totalAmount) FROM ordersummary GROUP BY orderDate";
PreparedStatement ordPstmt = con.prepareStatement(sql);
ResultSet ordRs = ordPstmt.executeQuery();
out.println("<h2>Sales Report by Day</h2>");
out.println("table class=table border=2><tr><th>Date</th><th>Total Order Amount</th></tr>");
while(ordRs.next()){
    String date = ordRs.getDate(1);
    String amount = ordRs.getString(2);
    out.println("<tr><td>" + date + "</td><td>$" + amount + "</td></tr>");
}
out.println("</table>");

String sql2 = "SELECT * FROM customer";
PreparedStatement pstmt = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);
ResultSet rst = pstmt.executeQuery();
out.println("<h2>Customer List</h2>");
out.println("<table class='table' border='2'>");
out.println("<tr><th>Id</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone Number</th><th>Address</th><th>City</th><th>City</th><th>State</th><th>Postal Code</th><th>Country</th>");
while(rst.next()){
    String id = rst.getString(1);
    String first = rst.getString(2);
    String last = rst.getString(3);
    String email = rst.getString(4);
    String phone = rst.getString(5);
    String city = rst.getString(6);
    String state = rst.getString(7);
    String postal = rst.getString(8);
    String country = rst.getString(9);
    String user = rst.getString(10);
    out.println("<tr><td>" + id + "</td><td>" + first + "</td><td>" + last + </td><td>" + email + "</td><td>" + phone + "</td><td>" + address + "</td><td>" + city + "</td><td>" + state + "</td><td>" + postal + "</td><td>" + country + "</td><td>" + user + "</td></tr>")
}
out.println("</tr></table>");
} catch (Exception e) {
    out.println(e);
}
%>

</body>
</html>

