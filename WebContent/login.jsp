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
                    <c:if test="${logout_msg != null }">
				<div class="col-lg-12">
                    <div class="alert alert-info">
                                <c:out value="${logout_msg }"></c:out>
                    </div>
                </div>
                </c:if>
                    <fieldset>
						<font color="red"><c:out value="${msg }"></c:out></font>
					
							<form action="<%=request.getContextPath() %>/Controller" method="post">
							<input type="hidden" name="action" value="login_form" />
 							<input type="hidden" name="flag" value="1" />
							
								<div class="form-group">
		        				 	
									<input class="form-control" placeholder="E-mail" type="email" name="email" required>
								</div>
								<div class="form-group">
		        				 	<input class="form-control" placeholder="Password" type="password" name="password" required>
								</div>
								<div class="form-group">
								
									
									<button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
									<div class="clearfix"></div>
									<HR>
									Create an Account <a href="<%=request.getContextPath() %>/Controller?action=sign_up" class="forgot-password"> <font color="Green">Sign-Up</font></a>
									<BR>
									I forgot my Password <a href="<%=request.getContextPath() %>/Controller?action=forgot_password" class="forgot-password"><font color="Green"> Lets Retrieve</font></a>
								</div>
								
								</form>
								<c:if test="${flag == 100 }">
								<div class="form-group">
		        				<form action="<%=request.getContextPath() %>/Controller" method="post">
		        				<font color="red"><c:out value="${msg1 }"></c:out></font>
		        				 	<input type="hidden" name="action" value="forgot_password_form" />
		        				 	<input class="form-control" placeholder="Enter Email on File" type="email"
		        				 	 name="email" value="<c:out value="${email }"></c:out>" required>
								
								<button type="submit" class="btn btn-sm btn-success btn-block">Fetch</button>
								</form>
								</div>
								</c:if>
								
							
							</fieldset>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		
		


</body>
</html>