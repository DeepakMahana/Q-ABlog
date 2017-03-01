<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
<c:import url="header2.jsp"></c:import>
     
<%--
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/kitecert_ocpjp" 
     user="kitecert_admin"  password="kitecert123admin"/>
     --%> 
 
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/blog" 
     user="root"  password="" />
   
<sql:query dataSource="${ds}" var="result0">
SELECT * FROM user WHERE email ='<c:out value="${email}"/>'
</sql:query>


<sql:query dataSource="${ds}" var="result">
SELECT count(user_id) AS num_que,user.id,name,email,password,question.id,title,question.user_id FROM user,question WHERE user.id = question.user_id AND email ='<c:out value="${email}"/>'
</sql:query>

<sql:query dataSource="${ds}" var="result1">
SELECT user.id,ans,answer.user_id FROM user,answer WHERE user.id = answer.user_id AND email ='<c:out value="${email}"/>'
</sql:query>
  
<sql:query dataSource="${ds}" var="result2">
SELECT *
FROM upvote, answer, user
WHERE upvote.answer_id = answer.id
AND answer.user_id = user.id
AND user.email =  '<c:out value="${email}"/>'
</sql:query>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>

<body>
<% int i =1; 
int count =0;
int num_upvote=0;
%>

<c:forEach var="row1" items="${result1.rows}">
<% count++; %>
</c:forEach>

<c:forEach var="row2" items="${result2.rows}">
<% num_upvote++; %>
</c:forEach>
         <div id="page-wrapper">
            <div class="row">
            <BR>
                <div class="col-lg-12">
                    <div class="alert alert-info">
                                Welcome <c:out value="${email}"/>
                            </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
           
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                           My Profile
                        </div>
                        <div class="panel-body">
                            <c:forEach var="row" items="${result.rows}">
                            <% if(i == 1){  %>
                             <c:forEach var="row0" items="${result0.rows}">
                             <p>Name: <c:out value="${row0.name }"/></p>
                             
                             <p>Email: <c:out value="${row0.email }"/></p>
                             <c:choose>
                             <c:when test='${flag== "102"}'>
                             <p>Password: <c:out value="${row0.password }"/></p>
                             </c:when>
                             <c:otherwise>
                             <p>Password: ****</p>
                             <p><a href="<%=request.getContextPath() %>/Controller?action=show_password">  Show Password- I am Alone</a></p>
                            </c:otherwise>
                             </c:choose>
                             </c:forEach>
                             <hr>
                             <p>Total Questions: <c:out value="${row.num_que }"/></p>
                             <p>Total Answers: <%=count %></p>
                             <p>Total Upvotes: <%=num_upvote %></p>
                              <%  } 
                              i=2;
                              %>
                             
                            </c:forEach>
                           
						
                        </div>
                        <div class="panel-footer">
                           <a href="<%=request.getContextPath() %>/Controller?action=my_questions"> Show My Questions</a>
                        </div>
                    </div>
                </div>
                <!--  
               <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Test Performance Chart
                        </div>
                        <!-- /.panel-heading -->
                        <div class="col-lg-6">
                              <section class="panel">
                                  <header class="panel-heading">
                                     
                                  </header>
                                  <div class="panel-body text-center">
                                      <canvas id="bar" height="300" width="500"></canvas>
                                  </div>
                              </section>
                          </div>

                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                
                -->
            </div>
           
        </div>
        <!-- /#page-wrapper -->

    </div>
</body>
</html>