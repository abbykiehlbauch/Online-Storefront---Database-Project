<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean authenticated;

	try
	{
		authenticatedUser = validateRegister(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
	{
		response.sendRedirect("login.jsp");	
	}	// Failed login - redirect back to login page with a message 
%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
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
		
		if(first == null && last == null && email == null && phone == null && addy == null && city == null && state == null && postal == null && country == null && userid == null && password == null)
				return null;
		if((first.length() == 0) && (last.length() == 0) && (email.length() == 0) && (phone.length() == 0) && (addy.length() == 0) && (city.length() == 0) && (state.length() == 0) && (postal.length() == 0) && (country.length() == 0) && (userid.length() == 0) && (password.length() == 0))
				return null;
		
		try 
		{
			getConnection();
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			String SQL = "SELECT userid, password FROM customer WHERE userid=? AND password=?";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userid);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			String username = rs.getString(1);
			if(!username.equals(null) || username.equals(userid)){
				retStr = username;
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
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser", userid);
		}
		else
		{
			session.setAttribute("loginMessage","Could not create account, please try again.");
			
		}
		return retStr;
	}
%>