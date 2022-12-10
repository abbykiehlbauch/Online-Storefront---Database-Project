<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>nulllllll</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
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
    input {
        padding:10px;
        border:0;
        box-shadow: 0 0 15px 4px rgba(0,0,0,0.06);
        border-radius: 10px;
        align-items: center;
        }
	body h1 {
		margin-top: -20px;
	}
    h2 {text-align: center;}
    h3 {text-align: center;}
    h4 {text-align: center;}
    p {text-align: center;}
</style>
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
        <% // Get product name to search for

        String name = request.getParameter("q");
                
        //Note: Forces loading of SQL Server driver
        try
        {	
            // Load driver class
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        }
        catch (java.lang.ClassNotFoundException e)
        {
            out.println("ClassNotFoundException: " +e);
        }

        // Variable name now contains the search string the user entered
        // Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

        // Make the connection
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True;";
        String uid = "sa";
        String pw = "304#sa#pw"; 
        Connection con = DriverManager.getConnection(url, uid, pw);

        //create dropdown menu for categories
        String SQL = "SELECT categoryId, categoryName FROM category";
        PreparedStatement pstmtC = con.prepareStatement(SQL);
        ResultSet categories = pstmtC.executeQuery();
        // out.println("<br><label for=\"categories\">Choose a category:</label>");
        // out.println("<select name=\"categoriesDropDown\" id=\"category-spinner\">");
        // out.println("<option value=\"none\" selected disabled hidden>Select an Option</option>");

        // while(categories.next())
        // {
        // 	out.println("<option value=\"" + categories.getInt("categoryId") + "\">" + categories.getString("CategoryName") + "</option>");
        // }
        // out.println("</select>");
        // out.println("</form>");
        String catId = request.getParameter("categoriesDropUp");

        // get userid for product page (review)
        userName = (String) session.getAttribute("authenticatedUser");
        String sqll2;
        if(userName != null)
        {
            sqll2 = "SELECT customerId FROM customer WHERE userid = '"+ userName + "'"; 
        }
        else 
        {
            sqll2 = "SELECT customerId FROM customer WHERE userid = 'arnold'";
        }
        PreparedStatement pstmt2 = con.prepareStatement(sqll2);
        ResultSet rst2 = pstmt2.executeQuery();
        int custidd;
        if(rst2.next() == true)
        {
            custidd = rst2.getInt("customerId");
            // out.println("<h2>'"+custidd+"'</h2>");
        }
        custidd = rst2.getInt("customerId");


        String sql;
        if(name != null && catId !=null)
        {
            sql = "SELECT productId, productName, productPrice, productImageURL, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE '%" + name + "%'" + "AND product.categoryId ="+ catId;
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rst = pstmt.executeQuery();
            if(rst.next()){
                out.println("<h2>Products containing '" + name + "' in '" + rst.getString("categoryName") + "':</h2>");
            }
        }
        else if(catId == null)
        {
            if(name == null)
                sql = "SELECT productId, productName, productPrice, productImageURL, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId";
            else
                sql = "SELECT productId, productName, productPrice, productImageURL, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE '%" + name + "%'";
        }
        else
        {
            sql = "SELECT productId, productName, productPrice, productImageURL, product.categoryId, categoryName FROM product JOIN category ON product.categoryId = category.categoryId";
            out.println("<h2>All products</h2>");
        }
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rst = pstmt.executeQuery();
        // Print out the ResultSet
        out.print("<form align='center'>");
        out.print("<table align='center'>");
        out.print("<tr><th></th><th style='padding-left: 20px'>Product Name</th><th style='padding-left: 20px'>Category</th><th>Price</th><th></th></tr>" + "<br>");
        while(rst.next())
        {
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            String prodid = rst.getString("productId");
            String prodname = rst.getString("productName");
            double prodprice = rst.getDouble("productPrice");
            String imageUrl = rst.getString("productImageURL");
            int categoryId = rst.getInt("categoryId");
            custidd = rst2.getInt("customerId");
            String categoryName = rst.getString("categoryName");
            out.print("<tr><td style='padding-right: 20px'><img height=100px src=\"" + imageUrl + "\"></td>");
            out.print("<td style='padding-right: 20px'>"+" " + "<a href=\"product.jsp?id=" + prodid + "&name=" + prodname + "&userid=" + custidd + "\"" + "> "+prodname+" </a>" + "</td>");
            out.print("<td style='padding-right: 20px'>" + categoryName + "</td>");
            out.print("<td style='padding-right: 20px' >"+" "+ currFormat.format(rst.getDouble("productPrice")) + "</td>");
            out.print("<td style='padding-right: 20px'>"+"<a href=\"addcart.jsp?id=" + prodid + "&name=" + prodname + "&price=" + prodprice  + "&newqty=1\">Add to cart</a>" + "</td></tr>");
        }
        out.print("</table>");
        out.print("</form>");
        // Close connection
        con.close();
        %>
    </body>
</html>