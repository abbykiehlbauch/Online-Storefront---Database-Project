<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<title>Your Shopping Cart</title>
<script>
	function update(newid, newname, newprice)
	{
		window.location="addcart.jsp?id="+newid+"&name="+newname+"&price"+newprice+"&newqty="+document.getElementById("newqtytext").value;
	}
</script>
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
	}
	body h1 {
		margin-top: 50px;
	}
	table {
		width: 1000px;
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
				<a href="listprod.jsp">Products</a>
			</li>
			<li>
				<a href="showcart.jsp">View Cart</a>
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
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
if (productList == null)
{	out.println("<h2 align='center'>Your shopping cart is empty!</h2>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	out.println("<h2>Your Shopping Cart</h2>");
	out.print("<table class='big'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");
	double total = 0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		out.println("<form method=\"get\" action=\"showcart.jsp\">");
		out.println("<td><input id = \"newqtytext\" type=\"text\" size = \"3\" value =\"" + product.get(3) + "\"></td>");
	
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());			
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		
		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		out.print("<td>"+"<a href=\"removecart.jsp?id=" + product.get(0)  + "\">Remove from cart</a>" + "</td>");
		//out.print("<td><input id = \"newqtybtn\" type=\"button\" onclick= \"update(" + product.get(0)+ "," + product.get(1) + ")\" value=\"Update Quantity\"></tr></td>");
		out.println("<td><a href = \"addcart.jsp?id=" +product.get(0)+ "&name=" + product.get(1)+"&price" + product.get(2) + "&newqty=" + request.getParameter("newqty") + "\">Add one</a></td>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");
	out.println("</form>");
	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
	out.println("<h2 align='center'><a href=\"checkout.jsp\">Check Out</a></h2><h2 align=\"center\"><a href=\"listprod.jsp\">Continue Shopping</a></h2>");
}
%>
</body>
</html> 