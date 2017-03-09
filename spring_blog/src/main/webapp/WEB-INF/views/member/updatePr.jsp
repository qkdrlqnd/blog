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

	function mread(){
		var url = "read.do";
		
		
		location.href = url;
	}

</script>


<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">정보수정</DIV>

<div class="content">
<c:choose>
	<c:when test="${flag}">
		정보수정이 성공적으로 되었습니다.
	</c:when>
	<c:otherwise>
		정보수정이 실패 되었습니다.
	</c:otherwise>
</c:choose>
</div>

  <DIV class='bottom'>
  
  <c:choose>
	<c:when test="${not empty id}">
		<input type='button' value='정보확인' onclick="mread()">
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
