<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<h3>Administrator Sales Report by Day</h3>
</head>
<body background="img/blue-abstract-gradient-wave-vector-background_53876-111548.jpg.webp">
    <header>
        <nav>
                <ul>
                        <li>
                                <a href="index.jsp">Home</a>
                        </li>
                        <li>
                                <a href="listprod.jsp">Products</a>
                        </li>
                        <li>
                                <a href="showcart.jsp">View Cart</a>
                        </li>
                        <%
                        String userName = (String) session.getAttribute("authenticatedUser");
                        if(userName != null){
                                %>
                                <div style="padding-left: 325px;">
                                        <%
                                out.println("<li><a href='adminIndex.jsp'>Admin Homepage</a></li>");
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

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try{		
    getConnectionForOrders();

    boolean clicked = false;
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

    //to update a product
    out.println("<form method=\"get\" action=\"admin.jsp\">");
    out.println("</table>");
    out.println("<h3>Update product</h3>");
    out.println("<label for=\"productName\">Product Name: </label> <input type=\"text\" name =\"productName\" size = \"10\">");
    out.println("<label for=\"productPrice\">Price: </label> <input type=\"text\" name =\"productPrice\" size = \"10\">");
    out.println("<input name = \"submitBtn2\" type=\"submit\" value=\"Submit\">");
    out.println("</form>");
    try{
        request.getParameter("submitBtn2");
        try{
            //get parameters to UPDATE to database
            String productName = request.getParameter("productName");
            double productPrice = Float.parseFloat(request.getParameter("productPrice"));

            //validate data entered
            //check if null or empty string (product name and price)
            if(productName == null || productName == "")
                throw new NumberFormatException();

            String SQL4 = "UPDATE product SET productPrice = ? WHERE productName = ?";
            PreparedStatement updateProduct = con.prepareStatement(SQL4);
            updateProduct.setString(2, productName);
            updateProduct.setDouble(1, productPrice);
            int insertedProduct = updateProduct.executeUpdate();
            out.println("<h4>Your product has been updated successfully</h4>"); 
            
        }catch(NumberFormatException e){
            out.println("<h4>Please enter the appropriate data types (Text for the product name and a number for the price)</h4>");
        }
    }catch(NullPointerException n){

    }
        //to delete a product
        out.println("<form method=\"get\" action=\"admin.jsp\">");
        out.println("</table>");
        out.println("<h3>Delete product</h3>");
        out.println("<label for=\"productName\">Product Name: </label> <input type=\"text\" name =\"productName\" size = \"10\">");
        out.println("<input name = \"submitBtn3\" type=\"submit\" value=\"Submit\">");
        out.println("</form>");
        try{
            request.getParameter("submitBtn3");
            try{
                //get parameters to DELETE to database
                String productName = request.getParameter("productName");

                //validate data entered
                //check if null or empty string (product name and price)
                if(productName == null || productName == "")
                    throw new NumberFormatException();

                String SQL6 = "DELETE FROM product WHERE productName = ?";
                PreparedStatement statement1 = con.prepareStatement(SQL6);
                statement1.setString(1, productName);
                int rowsDeleted = statement1.executeUpdate();
                if (rowsDeleted > 0)
                {
                    out.println("<h4>Your product has been deleted successfully</h4>");
                }  
            }catch(NumberFormatException e){
                out.println("<h4>Please enter the appropriate data types (Text for the product name)</h4>");
            }
    }catch(NullPointerException n){

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
