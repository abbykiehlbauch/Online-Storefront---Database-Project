<!DOCTYPE html>
<html>
<head>
<title>Inventory</title>
<h3>Inventory by warehouse</h3>
</head>
<body background="img/blue-abstract-gradient-wave-vector-background_53876-111548.jpg.webp">

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.nio.*"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
String username = (String) session.getAttribute("authenticatedUser");

try{		
    getConnectionForOrders();
    
    out.println("<form align='center' method=\"get\" action=\"inventory.jsp\">");
    out.println("<br><label for=\"warehouse\">Warehouse </label>");
    out.println("<select name=\"warehouse\" id=\"warehouse-name\">");
    out.println("<option value=\"default\"  selected disabled hidden>Choose warehouse</option>");
    
    String getWarehouses = "SELECT warehouseId, warehouseName FROM warehouse";
    PreparedStatement warehouses = con.prepareStatement(getWarehouses);
    ResultSet warehouses1 = warehouses.executeQuery();
    while(warehouses1.next())
    {
 	    out.println("<option value=\"" + warehouses1.getInt("warehouseId") + "\">" + warehouses1.getString("warehouseName") + "</option>");
    }
    out.println("</select>");
    out.println("<input type=\"submit\" value=\"Submit\">");
    
    String sql = "SELECT productId, quantity, warehouse.warehouseId, warehouseName FROM productInventory JOIN warehouse ON productInventory.warehouseId = warehouse.warehouseId WHERE productInventory.warehouseId = ?";
    PreparedStatement getInventory = con.prepareStatement(sql);
    getInventory.setString(1, request.getParameter("warehouse"));
    ResultSet inventory = getInventory.executeQuery();
    out.print("<table align='center' border='2px' border-style='none'>");
    out.print("<tr><th>Product Id</th><th>Quantity</th></tr>" + "<br>");
    while(inventory.next())
    {
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        String prodid = inventory.getString("productId");
        int quant = inventory.getInt("quantity");
        out.print("<td>" + prodid + "</td>");
        out.print("<td>"+ quant + "</td></tr>");       
    }
}
catch (SQLException ex) { // Close connection with try catch
    out.println(ex); 
}finally{
    closeConnection();
}

%>
</body>
</html>
