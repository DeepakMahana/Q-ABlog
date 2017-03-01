<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
function validate(){
	boolean status=confirm("delete?");
	if(status == true){
		return true;
	}
	else 
		return false;
}
</script>
</head>
<body>
<h1> Welcome Admin</h1>

<h3>Manage Users</h3>

<%-- Step 1 - Create DataSourse and Connect --%>
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost/blog" 
user="root" password=""  />

<%-- Write Query --%>
<sql:query dataSource="${ds }" var="result">
select id,name,email from user 
</sql:query>
<% int i=1; %>
<h4><c:out value="${msg }"></c:out></h4>
<table border="1" bgcolor="#EEEEEE">
<tr>
<td>Sr.</td>
<td>Name</td>
<td>Email</td>
<td>Ops</td>
</tr>

<c:forEach var="row" items="${result.rows }">
<tr>
<td><%=i++ %>.</td>
<td><c:out value="${row.name }"/></td>
<td><c:out value="${row.email }"/></td>
<td><a onclick='validate()' href="<%=request.getContextPath() %>/Admin?action=delete_user&id=<c:out value="${row.id }"/>&email=<c:out value="${row.email }"/>">delete</a></td>
</tr>
</c:forEach>

</table>

</body>
</html>