<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean authenticated;

	try
	{
		authenticatedUser = validateLogin(out,request,session);
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
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		
		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;
		
		try 
		{
			getConnectionForOrders();
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			String SQL = "SELECT * FROM customer WHERE userid= ? AND password = ?";
			PreparedStatement st = con.prepareStatement(SQL);
			st.setString(1, username);
			st.setString(2, password);
			ResultSet rs = st.executeQuery();
			while(rs.next())
			{
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
			session.setAttribute("authenticatedUser", username);
      session.setAttribute("authenticated", true);
		}
		else
		{
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
      session.setAttribute("authenticated", false);
		}
		return retStr;
	}
%>