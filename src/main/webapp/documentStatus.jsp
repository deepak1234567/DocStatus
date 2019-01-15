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
    <script type="text/javascript">
    var statusObj = {
   	     'Initiate Document':'101',
   	     'Post Document':'102',
   	    'Received But not verified':'103',
   	    'Closed':'104'
   	};
   
    function callMe(val1,val2){ 
    	  $(".modal-body #status").val(statusObj[val1]);
    	  $(".modal-body #docId").val(val2);
     
    }
   
function refreshPage(){
    window.location.reload();
} 
</script>
	 
}
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

      
        <span>${msg}</span>
 
       <table class="table table-sm table-dark">
  <thead>
    <tr>
      <th scope="col">Document Name</th>
      <th scope="col">Status</th>
      <th scope="col">From User</th>
      <th scope="col">To User</th>
      <th scope="col">Source Address</th>
      <th scope="col">Destination Address</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
		  <c:forEach items="${list}" var="item">
		    <tr>
		      <td><c:out value="${item.documentName}" /></td>
		       <td><c:out value="${item.entryPoint}" /></td> 
		         <td><c:out value="${item.fromUser}" /></td> 
		         <td><c:out value="${item.toUser}" /></td> 
		         <td><c:out value="${item.source}" /></td>
		         <td><c:out value="${item.destination}" /></td>
		         <td>  
            		<button type="button" id="${item}" onclick="callMe('${item.entryPoint}','${item.id}');"
class="open-Dialog btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Edit</button>
        		 
       			 </td>
		      
		    </tr>
		  </c:forEach>
		</tbody>
</table>
   

</div>
<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Update Status</h4>
        </div>
        <div class="modal-body">
        <form action="${contextPath}/editStatus">
          <select   path="status" id="status" name="status" class="form-control">
   			<option value="NONE">--- Entry Point ---</option> 
   			<option value="101">Initiate Document</option>
   			<option value="102">Post Document</option>
   			<option value="103">Received But not verified</option>
   			<option value="104">Closed</option> 
			 
			 </select>
			 <input type="hidden" name="docId" id="docId"/>
            <span>${error}</span> 
            
            
      
   			 
 
        </div>
        <div class="modal-footer">
        <button class="btn btn-lg btn-primary btn-block" type="submit">Save</button>
          
        </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
 </c:if> 
</html>

<script type="text/javascript">
var statusObj = {
	     'Initiate Document':'101',
	     'Post Document':'102',
	    'Received But not verified':'103',
	    'Closed':'104'
	};
statusObj[bla]

/* $(document).on("click", ".open-Dialog", function (value) {
	var bla = $(".modal-body #EntryPoint");
    console.log('id',bla.id);
    console.log('id',bla.entryPoint);
     $(".modal-body #EntryPoint").val(statusObj[bla]);
      
}); */
</script>