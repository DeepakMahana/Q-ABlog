<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<c:if test='${msg == "abc" }'>
<script type="text/javascript">
alert("U have already answered this question");
</script>
</c:if>
<c:if test="${flag == 200 }">
<script>
$(document).ready(function(){
    $("#myModal-2").modal('show');
});
</script>

</c:if>


<c:if test='${num == "1" }'>
<script type="text/javascript">
alert("Answer Upvoted.");
</script>
</c:if>

<c:if test='${num == "2" }'>
<script type="text/javascript">
alert("Answer Downvoted.");
</script>
</c:if>

</head>
<body>
<c:import url="header2.jsp"></c:import>
<%-- Step 1 - Create DataSourse and Connect --%>
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost/blog" 
user="root" password=""  />

<%-- Write Query --%>
<sql:query dataSource="${ds }" var="result">
select * from sub_cat 
</sql:query>

<sql:query dataSource="${ds }" var="result1">
select * from category 
</sql:query>

<sql:query dataSource="${ds }" var="result3">
select * from user,question,answer where question.id = answer.question_id AND  answer.user_id = user.id AND question_id = <c:out value="${question_id }"></c:out> ORDER BY answer.id desc
</sql:query>

<sql:query dataSource="${ds }" var="result4">
select * from upvote
</sql:query>


<sql:query dataSource="${ds }" var="result5">
select * from comment,user where comment.user_email = user.email
</sql:query>


<% int i =1; 
int count = 0;
%>

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
               <!--  /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-4">
                 <% String s=""; %>
                    <div class="panel panel-primary">
                        <c:forEach var="row3" items="${result3.rows }">
                    <% if( i ==1){
							%>
                        <div class="panel-heading">
                           
							<c:out value="${row3.title }"></c:out> 
                        <a href="<%=request.getContextPath() %>/Controller?action=post_ans&u=<c:out value="${row3.name }"></c:out>&qid=<c:out value="${row3.id }"/>">Post Answer</a>
<BR>
Posted On: <c:out value="${row3.date }"></c:out> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Asked By: <c:out value="${u }"/>

                        </div><%	
} %>
                       
                        <div class="panel-body">
                          

<% i=2; %>
<div class="panel-group m-bot20" id="accordion">
                          <div class="panel panel-default">
                              <div class="panel-heading">
                                  <h4 class="panel-title">
                                      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse<c:out value="${row3.id }"/>">
                                          <c:out value="${row3.name }"/> says,
                                         
                                      </a>

                                  </h4>
                              </div>
                             
                             <c:if test="${row3.id == '7'}  ">
                             <%  s="in"; %>
                             </c:if>
                             
                             <div id="collapse<c:out value="${row3.id }"/>" class="panel-collapse collapse <%=s %>">
                                  <div class="panel-body">
<c:out value="${row3.ans }" escapeXml="false"></c:out>

<BR><BR>
<c:forEach var="row4" items="${result4.rows }">
<c:if test="${row3.id == row4.answer_id }">
<% count++; %>
</c:if>
</c:forEach>
<c:choose>
								<c:when test="${email != null }">
								
								<a class="btn  btn-primary" href="<%=request.getContextPath() %>/Controller?action=upvote&ans_id=<c:out value="${row3.id }"></c:out>&qid=<c:out value="${question_id }"></c:out>&u=<c:out value="${u }"/> ">
Upvote(<%=count %>)</a>

</c:when>
								<c:otherwise>
								     <a href="#myModal-1" data-toggle="modal" class="btn  btn-primary">
                                  Upvote(<%=count %>)
                              </a>
								</c:otherwise>
								</c:choose>

<c:choose>
								<c:when test="${email != null }">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse1<c:out value="${row3.id }"/>">Comments</a>
 
								
</c:when>
								<c:otherwise>
								    <a href="#myModal-3" data-toggle="modal" class="btn  btn-primary">
                                  Comment
                              </a>
 
								</c:otherwise>
								</c:choose>

 <% count=0; %>                                     
 </div>
                              </div>
                          </div>
                          </div>
<div id="collapse1<c:out value="${row3.id }"/>" class="panel-collapse collapse">
                                  <div class="panel-body">
                                  
  <form class="form-horizontal" role="form" method="post" action="<%=request.getContextPath() %>/Controller">
                                                   <input type="hidden" name="action" value="comments_form" />
 <input type="hidden" name="ans_id" value="<c:out value="${row3.id }"></c:out>" />
  <input type="hidden" name="email" value="<c:out value="${row3.email }"></c:out>" />
 <input type="hidden" name="qid" value="<c:out value="${question_id }"></c:out>" />
 <input type="hidden" name="u" value="<c:out value="${u }"></c:out>" />
                                                
                                                  <div class="form-group">
                                                         <div class="col-lg-10">
                                                         <textarea name="comment" placeholder="Write your comment here" class="form-control" required="required"></textarea>
                                                     	<button type="submit" class="btn btn-info">Add Comment</button>
														</div>
                                                  </div>
                                                    </form>
                                                 <hr>                                  
<c:forEach var="row5" items="${result5.rows }">
<c:if test="${row3.id == row5.answer_id }">
<c:out value="${row5.name }" escapeXml="false"/> says, <BR>
<c:out value="${row5.comm }" escapeXml="false"></c:out>
<hr>
</c:if>
</c:forEach>

<BR><BR>


                                 
 </div>
                              </div>
 
<!--  Login Modal -->
 <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal-1" class="modal fade">
                                  <div class="modal-dialog">
                                      <div class="modal-content">
                                          <div class="modal-header">
                                              <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                                              <h4 class="modal-title">Login</h4>
                                          </div>
                                          <div class="modal-body">
													
                                              <form class="form-horizontal" role="form" method="post" action="<%=request.getContextPath() %>/Controller">
                                                   <input type="hidden" name="action" value="login_form" />
 <input type="hidden" name="ans_id" value="<c:out value="${row3.id }"></c:out>" />
 <input type="hidden" name="qid" value="<c:out value="${question_id }"></c:out>" />
 <input type="hidden" name="u" value="<c:out value="${u }"></c:out>" />
 
 <input type="hidden" name="flag" value="2" />
                                                 
                                                  <div class="form-group">
                                                      <label for="inputEmail1" class="col-lg-2 control-label" >Email</label>
                                                      <div class="col-lg-10">
                                                          <input type="text" class="form-control" id="inputEmail4"  name="email">
                                                      </div>
                                                  </div>
                                                  <div class="form-group">
                                                      <label for="inputPassword1" class="col-lg-2 control-label" >Password</label>
                                                      <div class="col-lg-10">
                                                          <input type="password" class="form-control" id="inputPassword4"  name="password">
                                                      </div>
                                                  </div>
                                                 
                                                  <div class="form-group">
                                                      <div class="col-lg-offset-2 col-lg-10">
                                                          <button type="submit" class="btn btn-info">Sign in</button>
                                                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                         <a href="<%=request.getContextPath() %>/Controller?action=sign_up" class="forgot-password">Register</a>
                                                      </div>
                                                     
                                                  </div>
                                              </form>

                                          </div>

                                      </div>
                                  </div>
                              </div>
<!-- comment modal -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal-3" class="modal fade">
                                  <div class="modal-dialog">
                                      <div class="modal-content">
                                          <div class="modal-header">
                                              <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                                              <h4 class="modal-title">Login</h4>
                                          </div>
                                          <div class="modal-body">
													
                                              <form class="form-horizontal" role="form" method="post" action="<%=request.getContextPath() %>/Controller">
                                                   <input type="hidden" name="action" value="comment_login" />
 <input type="hidden" name="ans_id" value="<c:out value="${row3.id }"></c:out>" />
 <input type="hidden" name="qid" value="<c:out value="${question_id }"></c:out>" />
 <input type="hidden" name="u" value="<c:out value="${u }"></c:out>" />
 
                                                 
                                                  <div class="form-group">
                                                      <label for="inputEmail1" class="col-lg-2 control-label" >Email</label>
                                                      <div class="col-lg-10">
                                                          <input type="text" class="form-control" id="inputEmail4"  name="email">
                                                      </div>
                                                  </div>
                                                  <div class="form-group">
                                                      <label for="inputPassword1" class="col-lg-2 control-label" >Password</label>
                                                      <div class="col-lg-10">
                                                          <input type="password" class="form-control" id="inputPassword4"  name="password">
                                                      </div>
                                                  </div>
                                                 
                                                  <div class="form-group">
                                                      <div class="col-lg-offset-2 col-lg-10">
                                                          <button type="submit" class="btn btn-info">Sign in</button>
                                                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                         <a href="<%=request.getContextPath() %>/Controller?action=sign_up" class="forgot-password">Register</a>
                                                      </div>
                                                     
                                                  </div>
                                              </form>

                                          </div>

                                      </div>
                                  </div>
                              </div>


						</div>
						 </c:forEach>
						</div>
                       
                    
                </div>
                
              
            </div>
           
        </div>


</body>
</html>