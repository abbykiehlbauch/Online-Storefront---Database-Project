<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<h3>Administrator Sales Report by Day</h3>
</head>
<body background="img/blue-abstract-gradient-wave-vector-background_53876-111548.jpg.webp">

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
    //create form to add a product
    out.println("<form method=\"get\" action=\"admin.jsp\">");
    out.println("</table>");
    out.println("<h3>Add new product</h3>");
    out.println("<label for=\"productName\">Product Name: </label> <input type=\"text\" name =\"productName\" size = \"10\">");
    out.println("<label for=\"productPrice\">Price: </label> <input type=\"text\" name =\"productPrice\" size = \"10\">");
    String SQL = "SELECT categoryId, categoryName FROM category";
    PreparedStatement pstmtC = con.prepareStatement(SQL);
    ResultSet categories = pstmtC.executeQuery();
    out.println("<br><label for=\"categories\">Choose a category:</label>");
    out.println("<select name=\"categoriesDropDown\" id=\"category-spinner\">");
    out.println("<option value=\"none\" selected disabled hidden>Select an Option</option>");
    while(categories.next())
    {
        out.println("<option value=\"" + categories.getInt("categoryId") + "\">" + categories.getString("CategoryName") + "</option>");
    }
    out.println("</select>");
    out.println("<input name = \"submitBtn\" type=\"submit\" value=\"Submit\">");
    out.println("</form>");

    try{
        request.getParameter("submitBtn");
        try{
            //get parameters to add to database
            String productName = request.getParameter("productName");
            double productPrice = Float.parseFloat(request.getParameter("productPrice"));
            int catId = Integer.parseInt(request.getParameter("categoriesDropDown")); 

            //validate data entered
            //check if null or empty string (product name and price)
            if(productName == null || productName == "")
                throw new NumberFormatException();
            //check if category has been selected
            else if(catId == 0)
                throw new NumberFormatException();

            String SQL2 = "INSERT INTO product(productName, categoryId, productPrice) VALUES (?, ?, ?)";
            PreparedStatement insertProduct = con.prepareStatement(SQL2);
            insertProduct.setString(1, productName);
            insertProduct.setInt(2, catId);
            insertProduct.setDouble(3, productPrice);
            int insertedProduct = insertProduct.executeUpdate();
            out.println("<h4>Your product has been added successfully</h4>"); 
            
        }catch(NumberFormatException e){
            out.println("<h4>Please enter the appropriate data types (Text for the product name and a number for the price)</h4>");
            out.println("<p>You must choose from the existing categories in the dropdown list</p>");
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
