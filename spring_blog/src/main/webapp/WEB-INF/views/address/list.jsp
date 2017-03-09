<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fnn" uri="/utility" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}
.search{
	width: 80%;
	text-align: center;
}
</style>

<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/javascript">
	function aread(no) {
		var url = "./read";
		url += "?no=" + no;
		url += "&col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";
		location.href = url;
	}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<form method="post" action="./list">
	<div class="title">주소록 목록</div>
	
	<div class="search">
			<select name="col">
				<option value ="name" <c:if test="${param.col == 'name'}"> selected="selected"</c:if>>이름</option>	
				<option value ="phone" <c:if test="${param.col == 'phone'}"> selected="selected"</c:if>>전화번호</option>	
				<option value ="wdate" <c:if test="${param.col == 'wdate'}"> selected="selected"</c:if>>작성일</option>	
				<option value ="total" >전체목록</option>	
			</select>
			<input type="text" name="word" value="${word}">	
			<input type="submit" value="검색">	
	</div>	
	
	
	<div class="content">
		
			<table>
				<tr id="tcolor">
					<th>no</th>
					<th>name</th>
					<th>phone</th>
					<th colspan="2">wdate</th>
				</tr>
				<c:choose>
					<c:when test="${fn:length(list) != 0}">
						<c:forEach items="${list}" var="dto">
				
							<tr>
								<td><c:if test="${fnn:newImg(fn:substring(dto.wdate,0,10))}">
									<img src="${pageContext.request.contextPath}/images/new.gif">
									</c:if>${dto.no}
								</td>
								<td> <a href="javascript:aread('${dto.no}')"> ${dto.name}</a></td>
								<td>${dto.phone}</td>
								<td>${dto.wdate}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">생성된 주소록이 없습니다.</td></tr>
					
					</c:otherwise>
				</c:choose>
			</table>
			<br>
			<br>
			<br> 
			<input type="button" value="생성" onclick="location.href='./create'">
			 ${paging}
	</div>
	</form>
	
</body>
</html>

