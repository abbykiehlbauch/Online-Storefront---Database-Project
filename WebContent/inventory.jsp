<!DOCTYPE html>
<html>
<head>
<title>Inventory</title>
<style type="text/css">
        body 
        {
                height: 125vh;
                margin-top: 25px;
                padding: 20px;
                background-size: cover;
                font-family: serif;
        }
        header {
                background-color:dodgerblue;
                position: fixed;
                left: 0;
                right: 0;
                top: 10px;
                height: 40px;
                display: flex;
                align-items: center;
                box-shadow: 0 0 25px 0 black;
        }
        header * {
                display: inline;
        }
        header li {
                margin: 29px;
        }
        header li a{
                color: white;
                text-decoration: none;
        }
        body h1 {
                margin-top: -20px;

        }

</style>
<h3>Inventory by warehouse</h3>
</head>
<body background="img/blue-abstract-gradient-wave-vector-background_53876-111548.jpg.webp">
        <header>
                <nav>
                        <ul>
                                <%
                                String userName = (String) session.getAttribute("authenticatedUser");
                                if(userName != null){
                                        %>
                                        <li><a href='index.jsp'>Home</a></li>
                                        <li><a href='addProduct.jsp'>Add a product</a></li>
                                        <li><a href='admin.jsp'>Sales report</a></li>
                                        <li><a href='listorder.jsp'>Orders</a></li>
                                        <li><a href='inventory.jsp'>Inventory</a></li>
    
                                        <div style="padding-left: 325px;">
                                                <%
                                        //out.println("<li><a href='adminIndex.jsp'>Admin Homepage</a></li>");
                                        out.println("<li><a href='customer.jsp'>" + userName + "</a></li>");
                                        out.println("<li><a href='logout.jsp'>Sign Out</a></li>");
                                        %>
                                        </div>
                                        <%
                                } else {
                                        %>
                                        <div style="padding-left: 450px;">
                                                <%
                                        out.println("<li><a href='register.jsp'>Register</a></li>");
                                        out.println("<li><a href='login.jsp'>Sign In</a></li>");
                                        %>
                                </div>
                                <%
                                }
                                %>
                        </ul>
                </nav>
        </header>
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
