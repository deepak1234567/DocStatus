<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create an account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    
    
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/datatables.min.css"/>
 
	<script type="text/javascript" src="${contextPath}/resources/js/datatables.min.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="container">

    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        
         

        <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Doc Status Tracking</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="#">Home</a></li>
      <li><a href="${contextPath}/createDocumentTrack">Create Doc</a></li>
      <li><a href="${contextPath}/documentStatus">Doc Status</a></li>
      
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a a onclick="document.forms['logoutForm'].submit()"><span class="glyphicon glyphicon-user"></span> Logout</a></li>
      <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> ${pageContext.request.userPrincipal.name}</a></li>
    </ul>
  </div>
</nav>
        
        
		<table>
		  <c:forEach items="${list}" var="item">
		    <tr>
		      <td><c:out value="${item}" /></td>
		    </tr>
		  </c:forEach>
		</table>

    </c:if>

</div>
<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
