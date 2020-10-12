<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.lang.Object" %>

<%
	
	if(request.getParameter("username") != null){
		String username = request.getParameter("username");
		try {
			Process p = Runtime.getRuntime().exec("echo \"Link to reset password: http://3.101.135.105/CTF2/Reset.jsp  \" | mail -s \"Pulsar Password Reset " + username + "@usc.edu");
			p.waitFor();
			response.sendRedirect("EmailSent.jsp");
			System.out.println("exit code: " + p.exitValue());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
	}


%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<title>Failure</title>
</head>
<body>
	<div class="container">
		<div class="header">
			<h1 class="col-12 mt-4 mb-4">Failed to Login!</h1>
		</div>
	</div>
	
	<div class="container">
		<form action="Failure.jsp" method="GET" class="needs-validation" novalidate>
			<div class="row mb-3">
				<div class="font-italic text-danger col-sm-9 ml-sm-auto">
				</div>
			</div>
			<div class="form-group">
    			<label for="username">Please enter username to reset password </label>
    			<input type="text" class="form-control" id="username" name="username" required>
    			<div class="valid-feedback"></div>
    			<div class="invalid-feedback">Please enter username</div>
  			</div>
  			<button id = "clickLogin" type="submit" class="btn btn-dark">Reset Password</button>
		</form>
		
		<form action = "Login.jsp" method = "GET" class = "needs-validation" style = "margin: 10px 0px;" >
  			<button id = "clickLogin" type="submit" class = "btn btn-light">Go back to Login</button>
  		</form>
	</div>
	
	<script>
	// Disable form submissions if there are invalid fields
	(function() {
	  'use strict';
	  window.addEventListener('load', function() {
	    // Get the forms we want to add validation styles to
	    var forms = document.getElementsByClassName('needs-validation');
	    // Loop over them and prevent submission
	    var validation = Array.prototype.filter.call(forms, function(form) {
	      form.addEventListener('submit', function(event) {
	        if (form.checkValidity() === false ) {
	          event.preventDefault();
	          event.stopPropagation();
	        }
	        form.classList.add('was-validated');
	      }, false);
	    });
	  }, false);
	})();
	</script>
	
</body>
</html>