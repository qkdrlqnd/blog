<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:choose>
	<c:when test="${empty sessionScope.id}">
		<c:set var="str">SPRING MVC Blog Test 페이지 입니다.</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="str">안녕하세요 ${sessionScope.id} 님!</c:set>
	</c:otherwise>
</c:choose>

<c:set var="title">나의 여행블로그 MVC</c:set>
<c:if test="${ not empty sessionScope.id && sessionScope.grade == 'A'}">
	<c:set var="title">관리자페이지</c:set>
</c:if>


<html>
<head>
	<title>Home</title>
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="title"><h1><em><marquee>${str} ${title}</marquee></em></h1></div>

	<DIV class="content">

<img src = "${pageContext.request.contextPath}/images/t_12.jpg" width="50%">
	<br>
	<c:choose> 
		<c:when test="${empty sessionScope.id }">
			<input type="button" value="로그인" onclick="location.href='./member/login'">
		</c:when>
		<c:otherwise>
			<input type="button" value="로그아웃" onclick="location.href='./member/logout'">
		</c:otherwise>
	</c:choose>

	
	<br>
	
	<br>
	</DIV>

<P>  The time on the server is ${serverTime}. </P>




</body>
</html>
