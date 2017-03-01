<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>ADMIN LOGIN</h1>

<c:out value="${msg }"></c:out>

<BR><BR>
<form action="<%=request.getContextPath() %>/Admin" method="POST">
  <input type="hidden" name="action" value="admin_login_form" />
 
 Email: <input type="text" name="email" />
 <br>
 
 <BR>
 Password: <input type="password" name="password" /> 
 <br><BR>

 <input type="submit" name="submit" value="Login" />
 </form>


</body>
</html>