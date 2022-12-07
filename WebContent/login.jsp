<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<style type="text/css">
	body 
	{
			height: 125vh;
			margin-top: 80px;
			padding: 20px;
			background-size: cover;
			font-family: sans-serif;
	}
	header {
			background-color:dodgerblue;
			position: fixed;
			left: 0;
			right: 0;
			top: 5px;
			height: 30px;
			display: flex;
			align-items: center;
			box-shadow: 0 0 25px 0 black;
	}
	header * {
			display: inline;
	}
	header li {
			margin: 18.5px;
	}
	header li a{
			color: white;
			text-decoration: none;
	}
</style>
</head>
<body>
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
									<a href="checkout.jsp">View Cart</a>
							</li>
							<li>
									<a href="listorder.jsp">Past Orders</a>
							</li>
							<li>
									<a href="register.jsp">Register</a>
							</li>
							<li>
									<a href="login.jsp">Sign In</a>
							</li>
							<li>
									<a href="logout.jsp">Sign Out</a>
							</li>
							<li>
									<a href="customer.jsp">Account</a>
							</li>
					</ul>
			</nav>
	</header>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
//out.println(session.getAttribute("test").toString());
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>

