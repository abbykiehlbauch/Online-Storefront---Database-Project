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
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	int orderID = Integer.parseInt(request.getParameter("orderId"));
	

	try(Connection con = DriverManager.getConnection(url,uid,pw);)
	{
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
			out.println("The Order ID DOES NOT EXIST.");

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
				out.print("Ordered Product : " + rst2.getInt(2));
				out.print(" Previous Inventory : " + rst2.getInt(4));
				out.print(" New Inventory : " + newInv+"\n");

			} else {
				isSufficient = false;
				insufficient  = rst2.getInt(2);
				out.println("Shipment not done. Insufficient inventory for product id:" + insufficient);
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

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>