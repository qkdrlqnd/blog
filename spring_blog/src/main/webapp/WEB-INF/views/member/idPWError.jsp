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
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">로그인 처리</DIV>
 
<DIV class="content"></DIV>
	<c:choose>
		<c:when test="${flag}">
			로그인되었습니다.
		</c:when>
		<c:otherwise>
			로그인이 실패되었습니다. 아이디나 패스워드가 잘못 입력되었습니다.
		</c:otherwise>
	</c:choose>
 
  <DIV class='bottom'>
  
  	<c:choose>
		<c:when test="${flag}">
			 <input type='button' value='홈' onclick="location.href='../index.jsp'">
		</c:when>
		<c:otherwise>
			  <input type='button' value='다시시도' onclick="history.back()">
		</c:otherwise>
	</c:choose>
  </DIV>
</body>

</html> 
