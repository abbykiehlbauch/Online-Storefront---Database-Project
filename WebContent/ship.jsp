<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	<h1>Enter the orderId to display: </h1>
	<form method ="get" action="ship.jsp">
		orderId :<input type = "text" name="orderId",size="5">
		<input type="submit" value="Submit">
		<input type ="reset" value="Reset">
	</form>

	int orderId = request.getParameter("orderId");
	

          
	// TODO: Check if valid order id
	try(Connection con = DriverManager.getConnection(url,uid,pw);)
	{
		String sql1 = "SELECT orderId FROM orderproduct";
		boolean isValid= false;
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql1);
		while(rst.next()){
			if(orderId == rst.getInt(1)){
				isValid = true;
			}

		}
		if(!isValid){
			out.println("The Order ID DOES NOT EXIST.");

		}


		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutocommit(false);

		// TODO: Retrieve all items in order with given id
		String sql = "SELECT orderId,productId, O.quantity, P.quantity FROM orderproduct O JOIN productInventory P"
					+ "WHERE warehouseID = 1 AND orderID = ?";
		PreparedStatement psmt = con.preparestatement(sql);
		psmt.setInt(1) = orderId;

		ResultSet rst2= psmt.executeQuery(sql);
		

		// TODO: Create a new shipment record.
		sql = "INSERT INTO Shipment(warehouseID) VALUES(1)";
		con.commit();

		// TODO: For each item verify sufficient quantity available in warehouse 1.
		boolean isSufficient = true;
		int insufficient = [];
		
		while(rst2.next()){
			int newInv = rst2.getInt(4)-rst2.getInt(3);

			if( newInv < 0){
				isSufficient = false;
				insufficient.apppend(rst.getInt(2));
			}
				
		}
		// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
		if(isSufficient){
			while(rst2.next()){
				int newInv = rst2.getInt(4)-rst2.getInt(3);
				sql = "UPDATE productInventory SET quantity =? WHERE productId = ?";
				PreparedStatement pst2 = con.prepareStatement(sql);
				pst2.setInt(1) = newInv;
				pst2.setInt(2) = rst2.getInt(2);
				ResultSet rst3 = pst2.executeQuery();
				con.commit();


				out.print("Ordered Product : " + rst2.getInt(2));
				out.print(" Previous Inventory : " + rst2.getInt(4));
				out.print(" New Inventory : " + newInv);
				out.println();


			}
			out.println("Shipment successfully processed.")
		

		} else{
			out.println("Shipment not done. Insufficient inventory for product id:"+insufficient);
			con.rollback();

		}

	// TODO: Auto-commit should be turned back on
	con.setAutocommit(true);

		
	} catch(SQLException ex){
		System.err.println("SQLException: " +ex);
	}


	
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
