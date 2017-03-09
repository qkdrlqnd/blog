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
	font-size: 24px;
}
</style>
</head>
<body>

	<div style="text-align: center;">수정</div>
	<form name="frm" method="POST" action="./update"
		onsubmit="return input(this)">
		<input type="hidden" name="memono" value="${dto.memono}" >		
		<input type="hidden" name="col" value="${param.col}" >		
		<input type="hidden" name="word" value="${param.word}" >		
		<input type="hidden" name="nowPage" value="${param.nowPage}" >		

		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" size="30"
					value="${dto.title}" /></td>
					
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="30" name="content">${dto.content}</textarea>
				</td>
			</tr>
		</table>
		<div>
			<input type="submit" value="전송">
		</div>
	</form>
	


</body>
</html>



