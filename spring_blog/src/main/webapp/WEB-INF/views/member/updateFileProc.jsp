<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 

<script type="text/javascript">

	function read(){
		
		var url = "./read.do";
		url += "?id=${id}";
		location.href= url;
	}

</script>


<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">사진 변경</DIV>
 
 	<div class="content">
 		<c:choose>
 			<c:when test="${flag}">
 				사진 변경 성공
 			</c:when>
 			<c:otherwise>
 				사진 변경 실패
 			</c:otherwise>
 		</c:choose>
	</div>
  <DIV class='bottom'>
  		<c:choose>
 			<c:when test="${flag}">
 				<input type='button' value='나의 정보' onclick="read()">
 			</c:when>
 			<c:otherwise>
 				<input type='button' value='다시시도' onclick="history.back()">
 			</c:otherwise>
 		</c:choose>
  </DIV>

 
 
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 
