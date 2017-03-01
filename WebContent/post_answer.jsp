<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
select title from question where id=<c:out value="${qid }"/>
</sql:query>


<div id="page-wrapper">
            <div class="row">
            <BR>
               
                <div class="col-lg-12">
                    <div class="alert alert-info">
                                Welcome <c:out value="${email}"/>
                                <a href="<%=request.getContextPath() %>/Controller?action=postque">Post Question</a>
                            </div>
                </div>
                <c:if test="${msg != null}">
                <div class="col-lg-12">
                    <div class="alert alert-warning">
                                <c:out value="${msg }"></c:out>
                            </div>
                </div>
                </c:if>
               <!--  /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                          <c:forEach var="row" items="${result.rows }">
<c:out value="${row.title }"/>
</c:forEach>
                        </div>
                        <div class="panel-body">
                           <form method="post" action="<%=request.getContextPath() %>/Controller">
                            <div class="form_details">
<input type="hidden" name="qid" value="<c:out value="${qid }"/>" />
<input type="hidden" name="u" value="<c:out value="${u }"/>" />

<input type="hidden" name="action" value="post_ans_form" />

Write Your answer here:
<BR>
<textarea name="ans" rows="10" cols="50" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Your Answer';}" required><c:out value="${ans }"></c:out></textarea>
        


<BR><BR>
<input type="text" class="text" name="code" value="Enter Code" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Enter Code';}" required />
<button class="btn" > <img src="<%=request.getContextPath() %>/CaptchaServlet"> </button>
  <BR><BR>       
<button class="btn" type="submit">Post Answer</button>

</div>
</form>
                        </div>
                       
                    </div>
                </div>
                
              
            </div>
           
        </div>



















