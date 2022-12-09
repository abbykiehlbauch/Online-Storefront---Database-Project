<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import = "java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
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
                                    <a href="showcart.jsp">Products</a>
                            </li>
                            <li>
                                    <a href="checkout.jsp">View Cart</a>
                            </li>
                        
                            <%
                                String userName = (String) session.getAttribute("authenticatedUser");
                                if(userName != null){
                                        out.println("<li><a href='listorder.jsp'>Past Orders</a></li>");
                                        %>
                                        <div style="padding-left: 325px;">
                                                <%
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
	
<% 


// Get customer id
String custId = request.getParameter("customerId");

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
if(custId == null || custId.equals(""))
	out.println("<h2 align='center'>Invalid customer id, try again.</h2>");
else if (productList == null)
	out.println("<h2 align='center'>There is nothing in your cart.</h2>");
else
{
	int num;
	try
	{
		num = Integer.parseInt(custId);
	}
	catch(Exception e)
	{
		out.println("<h2 align='center'>Invalid customer id</h2>");
		return;
	}
	// Make connection
	try
	{

		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True;";
		String uid = "sa";
		String pw = "304#sa#pw"; 
		Connection con = DriverManager.getConnection(url, uid, pw);

		String sql1 = ("SELECT customerId, firstName, lastName FROM customer WHERE customerId = ? AND customerId IN(SELECT customerId FROM customer)");
		PreparedStatement pstmt1 = con.prepareStatement(sql1);
		pstmt1.setInt(1,Integer.parseInt(custId));
		ResultSet validId = pstmt1.executeQuery();
		int orderId = 0;
		String name = "";
		if(!validId.next())
		{
			out.println("<h2 align='center'>Invalid customer id</h2>");
		}
		else
		{
			name = validId.getString(2) +" "+ validId.getString(3);
			// Save order information to database
			String sql2 = "INSERT INTO OrderSummary (customerId, orderDate) VALUES (?,?)";

			// Use retrieval of auto-generated keys.
			PreparedStatement pstmt2 = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);			
			pstmt2.setInt(1, Integer.parseInt(custId));
			pstmt2.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
			pstmt2.executeUpdate();
			ResultSet keys = pstmt2.getGeneratedKeys();
			keys.next();
			orderId = keys.getInt(1);

			out.println("<h2 align='center'>Your order</h2>");
			out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
			double total = 0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				// Print out order summary
				//TO DO: fix formatting
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				out.println("<tr><td>"+productId+"</td>");
				String price = (String) product.get(2);
				out.println("<td align = \"center\">"+product.get(1)+"</td>");
				int qty = ( (Integer)product.get(3)).intValue();
				out.println("<td align = \"center\">"+qty+"</td>");
				double pr = Double.parseDouble(price);
				out.println("<td align = \"center\">"+pr+"</td>");
				out.println("<td>"+pr*qty+"</td>");
				out.println("</tr>");
				
				total = total + (pr*qty);
					
				// Insert each item into OrderProduct table using OrderId from previous INSERT
				String sql3 = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
				PreparedStatement pstmt3 = con.prepareStatement(sql3);
				pstmt3.setInt(1, orderId);
				pstmt3.setInt(2, Integer.parseInt(productId));
				pstmt3.setInt(3, qty);
				pstmt3.setString(4, price);
				pstmt3.executeUpdate();
			}
			out.println("<tr><td></td><td></td><td></td><th>Order Total:</th><td>"+total+"</td></tr>");

			out.println("</table>");
			// Update total amount for order record
			String sql4 = "UPDATE OrderSummary SET totalAmount = ? WHERE orderId=?";
			PreparedStatement pstmt4 = con.prepareStatement(sql4);
			pstmt4.setDouble(1, total);
			pstmt4.setInt(2, orderId);
			pstmt4.executeUpdate();

			out.println("<h2>Order completed. Will be shipped soon...</h2>");
			out.println("<h2>Your order reference number is:"+orderId+"</h2>");
			out.println("<h2>Shipping to customer: "+custId+" Name: "+name+"</h2>");

		}

		// Clear cart if order placed successfully
		session.setAttribute("productList", null);
		con.close();

		// Here is the code to traverse through a HashMap
		// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

		/*
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
					...
			}
		*/
	}
	catch (SQLException ex)
	{
		out.println(ex);
	}
}
%>
<form method="get" action="checkout.jsp">
	<table align='center'>
			<tr align='right'><td><input type="submit" value="Try Again"></td></tr>
	</table>
</form>
</BODY>
</HTML>

