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
  String pwd = request.getParameter("pwd");
  boolean validFlag = true;
  
  if (username == null || username.length() == 0) {
	  validFlag = false;
  }
%>   

<%
	// set up JDBC
	Connection conn = null;
	Statement st = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql = "";
	// check if username existed
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://3.101.135.105:3306/ctf2?user=root&password=root");
		st = conn.createStatement();
		// check username
		sql = "SELECT * FROM userinfo WHERE username='" + username + "'";		
		rs = st.executeQuery(sql);
		
		if (rs.next()) {	// username existed
			validFlag = false;
			%>
		  		<font color="red"><strong> Sorry, this Username is taken! </strong></font><br />
			  	<font color="red"><strong> Going back to Register again in 2 seconds. </strong></font><br />
		  		<script>
		  			setTimeout(function(){
		  				var uri = "/CTF2/Register.jsp";
				        location.href = uri;
		  			}, 2000);
		  		</script>
		  	<%
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
%>

<% 
	// store user data if not existed
	if(validFlag) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SalEats?user=root&password=root");
			st = conn.createStatement();
			sql = "INSERT INTO userinfo (username, email, pw) " + "VALUES ('" + username + "', '" + pwd + "')";		
			st.executeUpdate(sql);
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
		%>
	  		<font color="green"><strong> You have been registered. </strong></font><br />
	  		<font color="green"><strong> Going back to Login in 3 seconds. </strong></font><br />
	  		<script>
	  			setTimeout(function(){
	  				var uri = "/CTF2/Login.jsp";
			        location.href = uri;
	  			}, 3000);
	  		</script>
	  	<%
	}
%>
