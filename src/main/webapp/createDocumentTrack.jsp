<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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

    <title>Log in with your account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

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
        
         

        <h2>Welcome ${pageContext.request.userPrincipal.name} |
         <a onclick="document.forms['logoutForm'].submit()">Logout</a>
          |<a href="${contextPath}/documentStatus"> Doc Status</a>

</h2>
</c:if>
<span>${msg}</span>
    <form:form method="POST" modelAttribute="documentTrack"  action="${contextPath}/createDocumentTrack" class="form-signin">
        <h2 class="form-heading">Create Document Track</h2>

        <div class="form-group ${error != null ? 'has-error' : ''}">
            <span>${message}</span>
               <spring:bind path="fromUser">
            <form:select id="fromUser" name="fromUser" path="fromUser" class="form-control">
   			<option value="NONE">--- From User ---</option> 
   			<c:forEach items="${userList}" var="item"> 
   				<option value="${item.id}">${item.username}</option> 
			</c:forEach>
			 </form:select>
			 </spring:bind>
			 <br/>
		  <spring:bind path="toUser" >
		  
			<form:select path="toUser" id="toUser" name="toUser" class="form-control">
			<option value="NONE">--- To User ---</option> 
			 <c:forEach items="${userList}" var="item"> 
   				<option value="${item.id}">${item.username}</option> 
			</c:forEach>
			</form:select>
			</spring:bind>
		  
			 <br/>
			 <spring:bind path="source">
            <form:input name="source" path="source" type="text" class="form-control" placeholder="Source Location"
                   autofocus="true"/> 
                   
             </spring:bind>
                    <br/>
             <spring:bind path="destination">
            <form:input name="destination" path="destination" type="text" class="form-control" placeholder="Destination Location"
                   autofocus="true"/> 
                   
             </spring:bind>
                   <br/>
             <spring:bind path="documentName">
            <form:input name="documentName" type="text" path="documentName" class="form-control" placeholder="Document Name"
                   autofocus="true"/>
                   
                    <br/>
                    
             </spring:bind>
             <spring:bind  path="entryPoint"> 
           <form:select   path="entryPoint" id="EntryPoint" name="EntryPoint" class="form-control">
   			<option value="NONE">--- Entry Point ---</option> 
   			<option value="101">Initiate Document</option>
   			<option value="102">Post Document</option>
   			<option value="103">Received But not verified</option>
   			<option value="104">Closed</option>
			</form:select>
			</spring:bind>   
            <span>${error}</span>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            

            <button class="btn btn-lg btn-primary btn-block" type="submit">Post</button>
            
        </div>

   </form:form>

</div>
<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
