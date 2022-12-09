<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Shipment Processing</title>
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
<%@ include file="header.jsp" %>

<%
	int orderID = Integer.parseInt(request.getParameter("orderId"));
	try
	{
		getConnectionForOrders();
		String sql1 = "SELECT orderId FROM orderproduct";
		boolean isValid= false;
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql1);
		while(rst.next()){
			if(orderID == rst.getInt(1)){
				isValid = true;
			}

		}
		if(!isValid){
			out.println("<h2>The Order ID DOES NOT EXIST.</h2>");

		}
		con.setAutoCommit(false);

		String sql = "SELECT orderId, O.productId, O.quantity, P.quantity FROM orderproduct O JOIN productinventory P ON O.productId = P.productId WHERE warehouseID = 1 AND orderID = ?";
		
		PreparedStatement psmt = con.prepareStatement(sql);
		
		psmt.setInt(1,orderID);
		
		ResultSet rst2 = psmt.executeQuery();

		boolean isSufficient = true;
		int insufficient;
		while(rst2.next()){
			int newInv = rst2.getInt(4)-rst2.getInt(3);
			if (newInv >= 0) {
				out.print("<h2>Ordered Product : " + rst2.getInt(2) + "</h2>");
				out.print("<h2>Previous Inventory : " + rst2.getInt(4) + "</h2>");
				out.print(" <h2>New Inventory : " + newInv+"\n" + "</h2>");

			} else {
				isSufficient = false;
				insufficient  = rst2.getInt(2);
				out.println("<h2>Shipment not done. Insufficient inventory for product id:" + insufficient + "</h2>");
				out.println("\n");
				con.rollback();
			}

		}

		

		if(isSufficient){
			String sql2 = "INSERT INTO shipment(shipmentId) VALUES(statement.RETURN_GENERATED_KEYS)";
			Statement stmt2 = con.createStatement();
			int rowcount = stmt2.executeUpdate(sql2);
			ResultSet autoKeys = stmt.getGeneratedKeys();			


			con.commit();

			rst2 = psmt.executeQuery();
			
			while(rst2.next()){
				
				int newInv = rst2.getInt(4)-rst2.getInt(3);
				sql = "UPDATE productinventory SET quantity =? WHERE productId = ?";
				PreparedStatement pst2 = con.prepareStatement(sql);
				pst2.setInt(1,newInv);
				pst2.setInt(2,rst2.getInt(2));
				int rowcount2 = pst2.executeUpdate();
				con.commit();

				out.print("Ordered Product : " + rst2.getInt(2));
				out.print(" Previous Inventory : " + rst2.getInt(4));
				out.print(" New Inventory : " + newInv+"\n");
				
				
			
			}
			out.println("Shipment successfully processed.");
		} 
		con.setAutoCommit(true);

	} catch(SQLException ex){
		System.err.println("SQLException: " +ex);
	}
	
%>                    				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>