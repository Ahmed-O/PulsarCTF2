<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "javax.servlet.RequestDispatcher" %>

<%
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  if (username == null || username.length() == 0) {
%>
    <font color="red"><strong>Username needs a value.</strong></font><br />
<%
  }
  if (password == null || password.length() == 0) {
%>
    <font color="red"><strong>Password needs a value.</strong></font><br />
<%
  }
%>

<%
	boolean validFlag = true;
	String validUsername = "";
	String validPassword = "";
	// set up JDBC
	Connection conn = null;
	Statement st = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql = "";
	// check if username / email existed
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://3.101.135.105:3306/ctf2?user=root&password=root");
		st = conn.createStatement();
		// check username
		sql = "SELECT * FROM userinfo WHERE username='" + username + "'";		
		rs = st.executeQuery(sql);
		
		if (!rs.next()) {	// not existed
			validFlag = false;
			%>
		   		<font color="red"><strong> Username does not exist. </strong></font><br />
		   		<font color="red"><strong> Going to Fail page now. </strong></font><br />
		  		<script>
		  			setTimeout(function(){
		  				var uri = "/CTF2/Login.jsp";
				        location.href = uri;
		  			}, 100);
		  		</script>
			<%
		} else {			
			validUsername = rs.getString("username");
			validPassword = rs.getString("pwd");
		}
	} catch (SQLException sqle) {
		System.out.println ("SQLException: " + sqle.getMessage());
	} finally {
		try {
			if (rs != null) {
				rs.close();
			}
			if (st != null) {
				st.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
	}
	
	if (validFlag) {
		if (username.equals(validUsername) && password.equals(validPassword)) {
			%>
				<font color="green"><strong> Login Successful </strong></font><br />
		   		<font color="green"><strong> Going to SUCCESS page now. </strong></font><br />
		  		<script>
		  			setTimeout(function(){
		  				var uri = "/CTF2/Login.jsp";
				        location.href = uri;
		  			}, 100);
		  		</script>
			<%
		} else {
			validFlag = false;
			%>
		   		<font color="red"><strong> Username and Password not matched. </strong></font><br />
		   		<font color="red"><strong> Going to Fail page now. </strong></font><br />
		  		<script>
		  			setTimeout(function(){
		  				var uri = "/CTF2/Login.jsp";
				        location.href = uri;
		  			}, 100);
		  		</script>
			<%
		}
	}
%>