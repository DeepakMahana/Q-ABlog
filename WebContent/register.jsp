<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<c:import url="header2.jsp"></c:import>

<%-- Step 1 - Create DataSourse and Connect --%>
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost/blog" 
user="root" password=""  />

<%-- Write Query --%>
<sql:query dataSource="${ds }" var="result">
select * from category,sub_cat where category_id = category.id
</sql:query>

            
            <!-- /.row -->
             <div class="section">
	    	<div class="container">
				<div class="row">
				
					<div class="col-md-4 col-md-offset-4">
						<div class="login-panel panel panel-default">
						<div class="panel-heading">
                        <h3 class="panel-title">Registration</h3>
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
						<font color="red" ><c:out value="${msg }" escapeXml="false"></c:out></font>
					
							<form action="<%=request.getContextPath() %>/Controller" method="post">
							<input type="hidden" name="action" value="register" />
 							
								<div class="form-group">
		        				 	
									<input class="form-control" placeholder="Name" type="text" name="name" value="<c:out value="${name }"/>" required>
								</div>
								<div class="form-group">
		        				 	
									<input class="form-control" placeholder="E-mail" type="email" name="email" value="<c:out value="${email }"/>" required>
								</div>
								<div class="form-group">
		        				 	<input class="form-control" placeholder="Password" type="password" name="password" required>
								</div>
								<div class="form-group">
		        				 	<input class="form-control" placeholder="Re-Enter Password" type="password" name="repassword" required>
								</div>
								<div class="form-group">
		        				 	<input class="form-control" placeholder="code" type="text" name="code" required>
								<BR>
								<img src="<%=request.getContextPath() %>/CaptchaServlet"> 
								</div>
								
								
								<div class="form-group">
								
									I have done this before! <a href="<%=request.getContextPath() %>/Controller?action=login" class="forgot-password">Login</a>
									<button type="submit" class="btn btn-lg btn-success btn-block">Sign-Up</button>
									<div class="clearfix"></div>
								</div>
							</form>
							</fieldset>
						</div>
					</div>
					
				</div>
			</div>
		</div>
           
       


      
      




