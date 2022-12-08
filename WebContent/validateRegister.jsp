<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%

	String authenticatedUser = null;
	session = request.getSession(true);
	boolean authenticated;

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
	{
		response.sendRedirect("login.jsp");	
	}
		String first = request.getParameter("firstName");
        String last = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phonenum");
        String addy = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postal = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String userid = request.getParameter("userid");
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
			response.sendRedirect("login.jsp");
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
		if(retStr != null)
		{	
			session.setAttribute("registerMessage", "Account created successfully!");
			session.setAttribute("authenticatedUser", userid);
		}
		else
		{
			session.setAttribute("registerMessage","Could not create an account with that username/password.");
			
		}
		
%>