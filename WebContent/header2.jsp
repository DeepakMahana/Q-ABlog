<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>My Blog </title>

	<!-- Bootstrap Core CSS -->
    <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		 
</head>

<body>

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

<div id="wrapper">

        <!-- Navigation -->
        
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<%=request.getContextPath() %>/Controller"><font size="5">MY BLOG</font></a>
            </div>
            
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
               
                </li>
               
                <!-- /.dropdown -->
                
                <c:if test="${email == null }">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="<%=request.getContextPath() %>/Controller?action=login"><i class="fa fa-user fa-fw"></i> Login</a>
                        </li>
                        
                        </li>
                    </ul>
                    
                    <!-- /.dropdown-user -->
                </li>
                
                </c:if>
                
                <c:if test="${email != null }">
                <li class="dropdown">
                
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="<%=request.getContextPath() %>/Controller?action=profile"><i class="fa fa-user fa-fw"></i> My Profile</a>
                        </li>
                        
                        <li class="divider"></li>
                        <li><a href="<%=request.getContextPath() %>/Controller?action=logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    
                    <!-- /.dropdown-user -->
                    
                </li>
                </c:if>
                
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                          
                            <!-- /input-group -->
                        </li>
                        <li>
                            <a href="<%=request.getContextPath() %>/Controller"><i class="fa fa-dashboard fa-fw"></i> Home Page</a>
                        </li>
                        <c:forEach var="row1" items="${result1.rows }">
                        <li>
                            <a href="#"> <c:out value="${row1.name }"></c:out><span class="fa arrow"></span></a>
                            <c:forEach var="row" items="${result.rows }">
                            <ul class="nav nav-second-level">
                                <li>
                                   <c:if test="${row.category_id == row1.id }">
 <a href="Controller?action=view_questions&id=<c:out value="${row.id }"></c:out> "><c:out value="${row.sname }"></c:out> </a>

</c:if>
                                </li>
                               
                            </ul>
                            </c:forEach>
                            <!-- /.nav-second-level -->
                        </li>

</c:forEach>
                        
                      
                    
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>
</div>

   <!-- jQuery -->
    <script src="bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="dist/js/sb-admin-2.js"></script>
    
    <script src="js/scripts.js"></script>
</body>
</html>