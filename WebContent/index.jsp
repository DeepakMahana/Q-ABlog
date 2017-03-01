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
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost/blog" 
user="root" password=""  />

<%-- Write Query --%>
<% 
int count = 0;
int i=0;
%>
<sql:query dataSource="${ds }" var="result3">
select question.id as id ,title,date,user_id,name,count from sub_cat,question,user where question.sub_cat_id = sub_cat.id AND question.user_id = user.id AND featured = 'YES' </sql:query>


<div id="page-wrapper">
            <div class="row">
            <BR>
               
                <div class="col-lg-12">
                    <div class="alert alert-info">
                                 Welcome 
                                <c:if test="${email == null }"> Blogger &nbsp;<a href="<%=request.getContextPath() %>/Controller?action=login" >Login</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
                                
                                <c:if test="${email != null }"> <c:out value="${email}"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
                                <a href="<%=request.getContextPath() %>/Controller?action=postque" > Post Question</a>
                            </div>
                </div>
                
                <div class="col-lg-12">
                    <div class="alert alert-success ">
                                Featured Questions
                            </div>
                </div>
               <!--  /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-4">
                <c:forEach var="row3" items="${result3.rows }">
                    <div class="panel panel-primary">
                        
                    
                        <div class="panel-heading">
                            <c:out value="${row3.title }"></c:out>
                        </div>
                        <div class="panel-body">
                           Views: <c:out value="${row3.count }"></c:out>
<BR>
Posted On: <c:out value="${row3.date }"></c:out> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Asked By: <c:out value="${row3.name }"></c:out>
                        
                        <BR>
<a href="<%=request.getContextPath() %>/Controller?action=view_answer&id=<c:out value="${row3.id }"/>&u=<c:out value="${row3.name }"/> ">
<c:forEach var="a" items="${list }">
<c:if test="${row3.id == a.question_id  }">
<% count++; %>
</c:if>

</c:forEach>
View Answers(<%=count %>)</a> 
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath() %>/Controller?action=post_ans&u=<c:out value="${row3.name }"></c:out>&qid=<c:out value="${row3.id }"/>">Post Answer</a>
</div>
</div>
<% count=0; %>
                       </c:forEach>
                    
                </div>
                
              
            </div>
           
        </div>


</body>
</html>


</body>
</html>





