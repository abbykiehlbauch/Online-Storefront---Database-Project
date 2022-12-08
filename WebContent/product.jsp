<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import = "java.util.Date" %>
<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body background="img/blue-abstract-gradient-wave-vector-background_53876-111548.jpg.webp">

    <%@ include file="header.jsp" %>

    <%
    // Get product name to search for
    String name = request.getParameter("name");
    out.println("<h2>"+name+"</h2>");

    // TODO: Retrieve and display info for the product
    String prodid = request.getParameter("id");

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

    String sql;
    sql = "SELECT productImageURL, productImage, productPrice, productDesc FROM Product P  WHERE productId = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(prodid));
    ResultSet rst = pstmt.executeQuery();
    
    String imageUrl;
    if(rst.next() == true)
    {
        // TODO: If there is a productImageURL, display using IMG tag
        imageUrl = rst.getString("productImageURL");
        if(imageUrl != null)
            out.println("<img src=\"" + imageUrl + "\">");
    }

    // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
    String imageBin;

    // TODO: If there is a productBin, display using IMG tag
    imageBin = rst.getString("productImage");
    if(imageBin != null)
        out.println("<img src=\"displayImage.jsp?id=" + prodid + "\">");



    // imagePrice = rst.getString("productPrice");
    out.println("<h4><b>Product ID:</b> "+prodid+"</h4>");
    out.println("<h4><b>Price:</b> $"+rst.getString("productPrice")+"</h4>");
    out.println("<h4><b>Description: </b>" + rst.getString("productDesc") + "</h4>");
    

    // TODO: Add links to Add to Cart and Continue Shopping

    out.println("<h3><a href=\"addcart.jsp?id=" + prodid + "&name=" + name + "&price=" + rst.getString("productPrice") + "\"" + ">Add to cart</a></h3>");
    out.println("<h3><a href='listprod.jsp'>Continue Shopping</a></h3>");

    %>

    <form align="center" name="NewReview" method=post>
        <table style="overflow:auto" align="center">
            <tr>
                <td><div align="left"><font face="serif" size="3.5">Rate (1-5):</font></div></td>
                <td><input placeholder="(5 is Best)" type="text" name="rating"  size="5" maxlength="1"></td>
            </tr>
            <tr>
                <td><div align="left"><font face="serif" size="3.5">Comment:</font></div></td>
                <td><input placeholder="Explain the Rating" type="text" name="comment" size="50" maxlength="1000"></td>
            </tr>
        </table>
        <br>
        <input class="submit" type="submit" name="Submit2" value="Add Review">
    </form>
    <%
    // session = request.getSession(true);

    String rate = request.getParameter("rating");
    String comment = request.getParameter("comment");
    String userid = request.getParameter("userid");
    prodid = request.getParameter("id");

    try 
    {
        getConnection();
        String SQL = "INSERT INTO review(reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?,?,?,?,?)";
        PreparedStatement pstmt2 = con.prepareStatement(SQL);
        if(rate != null && comment != null && prodid != null){
            pstmt2.setInt(1, Integer.parseInt(rate));
            pstmt2.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
            pstmt2.setInt(3, Integer.parseInt(userid));
            pstmt2.setInt(4, Integer.parseInt(prodid));
            pstmt2.setString(5, comment);
            pstmt2.executeUpdate();
        }
    } catch (SQLException ex){
        out.println(ex);
    }

    finally {
        try
        {
            closeConnection();
        } catch (SQLException e) {
            out.println(e);
        }
    }

    String sql2;
    // if(prodid != null)
    // {
    sql2 = "SELECT reviewRating, reviewDate, firstName, productId, reviewComment FROM review JOIN customer ON review.customerId = customer.customerId WHERE productId = " + prodid;
    //  out.println("<h2>Products containing '" + prodid + "'</h2>");
    //}
    // else
    // {
    //  out.println("<h2>No prod id</h2>");
    // }

    PreparedStatement pstmt3 = con.prepareStatement(sql2);
    ResultSet rst2 = pstmt3.executeQuery();
    // Print out the ResultSet
    out.print("<table align='center'>");
    out.print("<tr><th> Date </th><th> Customer </th><th> Rating </th><th> Comment </th></tr>" + "<br>");
    while(rst2.next())
    {
        int outrating = rst2.getInt("reviewRating");
        String outreviewdate = rst2.getString("reviewDate");
        String outcustid = rst2.getString("firstName");
        String outcomment = rst2.getString("reviewComment");
        out.print("<tr><td>" + outreviewdate + " |</td>");
        out.print("<td>" + outcustid + " </td>");
        out.print("<td>Rating: " + outrating + "/5 |</td>");
        out.print("<td>" + outcomment + "</td></tr>");
    }
    out.print("</table>");
    // Close connection
    con.close();

    %>
</body>
</html>


