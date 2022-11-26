<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("userId");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			getConnection();
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			Statement st = con.createStatement();
			ResultSet rs;
			String userMes = "Username exists";
			String errMes = "Username and password are incorrect";
			rs = st.executeQuery("SELECT * FROM customer WHERE userid='" + username + "' and password='" + password + "'");
			while(rs.next()) {
				request.getSession().setAttribute("userMes", userMes);
			}
			rs.close();
			st.close();
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			try{
				closeConnection();
			}
			catch (SQLException e) {
				out.println(e);

			}
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			if(username.equals(request.getParameter("userId"))&& password.equals(request.getParameter("password"))){
			session.setAttribute("authenticatedUser", username);
			boolean loggedIn = true;
			}
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
			boolean loggedIn = false;
		return retStr;
	}
%>

