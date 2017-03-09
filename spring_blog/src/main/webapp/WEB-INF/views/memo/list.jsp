<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 24px;
}

div {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

table {
	width: 60%;
	margin: 0 auto;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	padding: 10px
}



.search{

	width: 80%;
	text-align: center;
	margin: 1px auto;
}


</style>

<script type="text/javascript">

function read(memono) {
	var url="read";
	url+= "?memono="+memono;
	url+= "&col=${col}";
	url+= "&word=${word}";
	url+= "&nowPage=${nowPage}";
	location.href=url;

}



</script>

</head>

 <body>
 
	<div>메모목록</div>
	
	<div class="search">
	<form method="post" action ="./list">
		<select name="col">
					
			
			<option value="title"	<c:if test="${col == 'title'}">	selected='selected' </c:if>>제목</option>
			<option value="content" <c:if test="${col == 'content'}">	selected='selected' </c:if>>내용</option>
			<option value="total">전체출력</option>
		
		</select>
		<input type="text" name="word" value="${word}" >
		<input type='submit' value="검색">
		<input type='button' value='등록'	onclick="location.href='./create'">
	
	</form>
</div>
	
	
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
			<th>조회수</th>
		</tr>
		
		<c:choose>
			<c:when test="${fn:length(list) == 0 }">
				<tr>
					<td colspan="4">등록된 메모가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.memono}</td>
						<td><a href="javascript:read('${dto.memono}')"> ${dto.title}</a></td> 
						<td>${dto.wdate}</td>
						<td>${dto.viewcnt}</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<div>
		<input type="button" value="등록"
			onclick="location.href='./create'">
			${paging}
	</div>
	
</body>
</html>