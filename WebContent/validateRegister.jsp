<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
	try
	{   
		// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}

	// Make the connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True;";
	String uid = "sa";
	String pw = "304#sa#pw"; 
	Connection con = DriverManager.getConnection(url, uid, pw);

	String authenticatedUser = null;
	session = request.getSession(true);
	boolean authenticated;

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
	{
		response.sendRedirect("login.jsp");	
	}
		String first = request.getParameter("First Name");
        String last = request.getParameter("Last Name");
        String email = request.getParameter("Email");
        String phone = request.getParameter("Phone Number");
        String addy = request.getParameter("Address");
        String city = request.getParameter("City");
        String state = request.getParameter("Province");
        String postal = request.getParameter("Postal Code");
        String country = request.getParameter("Country");
        String userid = request.getParameter("User Id");
        String password = request.getParameter("password");
		String retStr = null;
		
		try 
		{
			getConnection();
			String SQL = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(SQL);

			if(first != null && last != null && email != null && phone != null && addy != null && city != null && state != null && postal != null && country != null && userid != null && password != null){
			pstmt.setString(1, first);
			pstmt.setString(2, last);
			pstmt.setString(3, email);
			pstmt.setString(4, phone);
			pstmt.setString(5, addy);
			pstmt.setString(6, city);
			pstmt.setString(7, state);
			pstmt.setString(8, postal);
			pstmt.setString(9, country);
			pstmt.setString(10, userid);
			pstmt.setString(11, password);
			pstmt.executeUpdate();
			// response.sendRedirect("login.jsp");
			retStr = userid;
			}
		}
		catch (SQLException ex) {
			out.println(ex);
		}
		finally 
		{
			try
			{
				closeConnection();
			}catch (SQLException e) {
				out.println(e);
			}
		}
		if(first != null)
		{	
			session.setAttribute("registerMessage", "Account created successfully!");
			session.setAttribute("authenticatedUser", userid);
		}
		else
		{
			session.setAttribute("registerMessage","Could not create an account with that username/password.");
			
		}
		
%>