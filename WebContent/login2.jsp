<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
 
<c:import url="header2.jsp"></c:import>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>

        <div class="section">
	    	<div class="container">
				<div class="row">
					<div class="col-md-4 col-md-offset-4">
						<div class="login-panel panel panel-default">
						<div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                    <fieldset>
						<font color="red"><c:out value="${msg }"></c:out></font>
					
							<form action="<%=request.getContextPath() %>/Controller" method="post">
							<input type="hidden" name="action" value="login_form" />
 							<input type="hidden" name="flag" value="3" />
							
								<div class="form-group">
		        				 	
									<input class="form-control" placeholder="E-mail" type="email" name="email" required>
								</div>
								<div class="form-group">
		        				 	<input class="form-control" placeholder="Password" type="password" name="password" required>
								</div>
								<div class="form-group">
								
									Do not have Login?<a href="<%=request.getContextPath() %>/Register" class="forgot-password"> Sign-Up</a>
									<button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
									<div class="clearfix"></div>
								</div>
							</form>
							</fieldset>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		
		


</body>
</html>




</body>
</html>