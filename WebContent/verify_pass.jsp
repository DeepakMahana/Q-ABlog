 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<c:import url="header2.jsp"></c:import> 
 
 <!-- Page Title -->
		<div class="section section-breadcrumbs">
			
		</div>
        
         <div class="section">
	    	<div class="container">
				<div class="row">
				
					<div class="col-md-4 col-md-offset-4">
						<div class="login-panel panel panel-default">
						<div class="panel-heading">
                        <h3 class="panel-title">Email Verification</h3>
                    </div>
                    <div class="panel-body">
                    
                    <fieldset>
						<font color="red"><c:out value="${msg }"></c:out></font>
					
							<form action="<%=request.getContextPath() %>/Controller" method="post">
							<input type="hidden" name="action" value="forgot_pass_code">
 							
							<input type="hidden" name="email" value='<c:out value="${email }"></c:out>'>
							
							
								<div class="form-group">
		        				 	
									<input class="form-control" placeholder="Enter Code from Email" type="text" name="code" required>
									 
								</div>
								<div class="form-group" align="center">
		        				 	A code has been sent to your Email, Please Verify!!
									</div>
								<div class="form-group">
								
									<button type="submit" class="btn btn-lg btn-success btn-block">Verify Email</button>
									<div class="clearfix"></div>
									
								</div>
							</form>
							</fieldset>
						</div>
					</div>
					
				</div>
			</div>
		</div>
        
       