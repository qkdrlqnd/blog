<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>
* {
	font-size: 24px;
	font-family: gulim;
}
div{
	margin: 0 auto;
	margin-top: 100px;
	margin-botton: 100px;
	text-align: center;
}
</style>



<script type="text/javascript">


function alist(){
	
	var url = "./list.do";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	location.href=url;	
	
	
}


</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
	<c:choose>
		<c:when test="${flag}">
			삭제되었습니다.
		</c:when>
		<c:otherwise>
			삭제가 실패되었습니다.
		</c:otherwise>
	</c:choose>
		
		<br>
		<br> <input type="button" value="확인"	onclick="alist()">
	</div>
</body>
</html>
