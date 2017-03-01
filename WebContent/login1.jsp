<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>

<h1>LOGIN</h1>

<font color="red"><c:out value="${msg }"></c:out></font>

<BR><BR>
<form action="Controller" method="POST">
 <input type="hidden" name="action" value="login_form" />
 <input type="hidden" name="ans_id" value="<c:out value="${ans_id }"></c:out>" />
 <input type="hidden" name="qid" value="<c:out value="${qid }"></c:out>" />
 <input type="hidden" name="u" value="<c:out value="${u }"></c:out>" />
 
 <input type="hidden" name="flag" value="2" />
 
 Email: <input type="text" name="email" />
 <br>
 
 <BR>
 Password: <input type="password" name="password" /> 
 <br><BR>

 <input type="submit" name="submit" value="Login" />
 </form>


</body>
</html>