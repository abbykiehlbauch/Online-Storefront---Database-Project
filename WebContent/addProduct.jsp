<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
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
<h3>Add a product</h3>
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

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try{		
    getConnectionForOrders();
    //create form to add a product
    out.println("<form method=\"get\" action=\"admin.jsp\">");
    out.println("</table>");
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
