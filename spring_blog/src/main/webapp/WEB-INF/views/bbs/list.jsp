<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fnnew" uri="/utility" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}

.search{
	width : 80%;
	text-align: center;
	margin: 1px auto;
}

</style>

<script type="text/javascript">
	function read(bbsno){
		var url = "./read";
		url += "?bbsno="+bbsno;
		url += "&col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";
		location.href=url;
	}

</script>


<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
	
	<!-- *********************************************** -->

	<DIV class="title">게시판목록</DIV>
	
	
	<div class="search">
	<form method="post" action ="./list">
		<select name="col">
		
			<option value="name" 	<c:if test="${col == 'name'}">selected='selected' </c:if>>성명</option>
			<option value="title" 	<c:if test="${col == 'title'}">selected='selected' </c:if>>제목</option>
			<option value="content" <c:if test="${col == 'content'}">selected='selected' </c:if>>내용</option>
			<option value="total">전체출력</option>
		
		</select>
		<input type="text" name="word" value="${word}" >
		<input type='submit' value="검색">
		<input type='button' value='등록'	onclick="location.href='./create'">
	
	</form>
</div>

	<TABLE>
		<TR>
			<TH>번호</TH>
			<TH>제목</TH>
			<TH>성명</TH>
			<TH>조회수</TH>
			<TH>등록일</TH>
			<TH>파일명</TH>
 
		</TR>
		
		
			<c:if test="${fn:length(list) != 0 }">

				<c:forEach items="${list}" var="dto">
						<tr>
							<td>
								<c:if test="${fnnew:newImg(fn:substring(dto.wdate,0,10))}">
									<img src="${pageContext.request.contextPath}/images/new.gif">
								</c:if>
								${dto.bbsno}
							</td>
						
							<td>
								<c:forEach var="i" begin="0" end="${dto.indent}">
									<c:out value="&nbsp;&nbsp;" escapeXml="false" />
								</c:forEach>
								<c:if test="${dto.indent > 0 }">
									<img src='${pageContext.request.contextPath}/images/re.jpg'>
								</c:if>
								<a href="javascript:read('${dto.bbsno}')">${dto.title}</a>
							</td>
							<td>${dto.wname}</td>
							<td>${dto.viewcnt}</td>
							<td>${fn:substring(dto.wdate,0,10)}</td>
							<td>
								<c:choose>
									<c:when test="${empty dto.filename}">
										 파일없음
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-default btn-sm" onclick="location.href='${pageContext.request.contextPath}/download?dir=/views/bbs/storage&filename=${dto.filename}'"><span class="glyphicon glyphicon-download-alt"></span> Download</button>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
				</c:forEach>			
			</c:if>					
		
	</TABLE> 
	<DIV class='bottom'>
		<input type='button' value='등록'	onclick="location.href='./create'">
		${paging}
	</DIV>

<!-- *********************************************** -->
	
</body>
<!-- *********************************************** -->
</html>
