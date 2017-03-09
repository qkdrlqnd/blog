<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}
</style>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
	
	<!-- *********************************************** -->

	<DIV class="title">회원가입 처리</DIV>

	<div class="content">
	
		<c:choose>
			<c:when test="${!idCheck}">
				아이디 중복확인을 해주세요.
			</c:when>
			<c:when test="${!emailCheck }">
				이메일 중복확인을 해주세요.
			</c:when>
			<c:when test="${flag}">
				회원가입을 했습니다.
			</c:when>
			<c:otherwise>
				회원가입을 실패 했습니다.
			</c:otherwise>
		</c:choose>
	</div>
	
	<c:choose>
		<c:when test="${flag}">
		<DIV class='bottom'>
			<input type='button' value='로그인' onclick="location.href='login.do'"> 
			<input type='button' value='홈' onclick="location.href='${pageContext.request.contextPath}'">
		</DIV>
		</c:when>
		<c:otherwise>
		<DIV class='bottom'>
			<input type='button' value='다시시도' onclick="history.back()"> 
			<input type='button' value='홈' onclick="location.href='${pageContext.request.contextPath}'">
		</DIV>
		</c:otherwise>
	</c:choose>
	

	<!-- *********************************************** -->
	
</body>
<!-- *********************************************** -->
</html>
