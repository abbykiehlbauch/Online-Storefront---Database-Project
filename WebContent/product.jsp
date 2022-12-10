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
<title>Product Information</title>
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
	<form align="center">
		<img height=150px width=150px src="img/304logo-nobg.png" alt="logo">
    </form>
	
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
            out.println("<p><img height=250px src=\"" + imageUrl + "\"></p>");
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

    //out.println("<h3><a href=\"addcart.jsp?id=" + prodid + "&name=" + name + "&price=" + rst.getString("productPrice") + "\"" + ">Add to cart</a></h3>");
    out.println("<h3><a href=\"addcart.jsp?id=" + prodid + "&name=" + name + "&price=" + rst.getString("productPrice") + "&newqty=1" + "\"" + ">Add to cart</a></h3>");

    out.println("<h3><a href='listprod.jsp'>Continue Shopping</a></h3>");

    %>

    <%
    // session = request.getSession(true);
    out.println("<h3>Product Reviews:</h3>");

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
    out.print("<table align='center' border='1px' border-style='ridge'>");
    out.print("<tr><th style='padding-right: 10px'> Date </th><th style='padding-right: 10px'> Customer </th><th style='padding-right: 10px'> Rating </th><th style='padding-right: 10px'> Comment </th></tr>" + "<br>");
    while(rst2.next())
    {
        int outrating = rst2.getInt("reviewRating");
        String outreviewdate = rst2.getString("reviewDate");
        String outcustid = rst2.getString("firstName");
        String outcomment = rst2.getString("reviewComment");
        out.print("<tr><td style='padding-right: 10px'>" + outreviewdate + "</td>");
        out.print("<td style='padding-right: 10px'>" + outcustid + " </td>");
        out.print("<td style='padding-right: 10px'>Rating: " + outrating + "/5</td>");
        out.print("<td style='padding-right: 10px'>" + outcomment + "</td></tr>");
    }
    out.print("</table>");
    // Close connection
    con.close();

    %>
    <h3>Add a Review:</h3>
    <form align="center" name="NewReview" method=post>
        <table style="overflow:auto" align="center">
            <tr>
                <td><div align="center"><font face="serif" size="3.5">Rate (1-5):</font></div></td>
                <td><input placeholder="(5 is Best)" type="text" name="rating"  size="7" maxlength="1"></td>
            </tr>
            <tr>
                <td><div align="center"><font face="serif" size="3.5">Comment:</font></div></td>
                <td><input placeholder="Explain the Rating" type="text" name="comment" size="50" maxlength="1000"></td>
            </tr>
        </table>
        <br>
        <input class="submit" type="submit" name="Submit2" value="Add Review">
    </form>

</body>
</html>


