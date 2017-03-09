<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}
</style>

<script type="text/javascript">

function blist(){
	var url = "./list";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	
	location.href=url;
}

function update(bbsno){
// function update(bbsno){
	var url = "./update";
	
	url += "?bbsno=" + bbsno;
	url += "&col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	url += "&oldfile=${dto.filename}";
	
	location.href=url;
	
}

function delet(bbsno){
// function delet(bbsno){
	var url = "./delete";
	
	url += "?bbsno=" + bbsno;
	url += "&col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	url += "&oldfile=&{dto.filename}";
	location.href=url;
}


function readReply(bbsno){
// function readReply(bbsno){
	var url = "./reply";
	
	url += "?bbsno=" + bbsno;
	url += "&col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	location.href=url;
	
}





</script>


<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>

	<!-- *********************************************** -->

	<DIV class="title">조회</DIV>


	<TABLE style="width: 70%; padding: 20px; margin-top: 10px">
		<TR>
			<TH>제목</TH>
			<TD>${dto.title}</TD>
		</TR>

		<TR>
			<TH>내용</TH>
			<TD>${dto.content}</TD>
		</TR>

		<TR>
			<TH>성명</TH>
			<TD>${dto.wname}</TD>
		</TR>

		<TR>
			<TH>조회수</TH>
			<TD>${dto.viewcnt}</TD>
		</TR>

		<TR>
			<TH>등록일</TH>
			<TD>${dto.wdate}</TD>
		</TR>

		<TR>
			<TH>파일명</TH>
			<TD>
			
				<c:choose>
					<c:when test="${empty dto.filename}">
						파일없음
					</c:when>
					<c:otherwise>
					<button type="button" class="btn btn-default btn-sm" onclick="location.href='${pageContext.request.contextPath }/download?dir=/views/bbs/storage&filename=${dto.filename}'">
					<span class="glyphicon glyphicon-download-alt"></span> Download</button>
					</c:otherwise>
				</c:choose>
			</TD>
		</TR>

	</TABLE>

	<DIV class='bottom'>
		<input type='button' value='등록' onclick="location.href='./create.do'">
		<input type='button' value='목록' onclick="blist()"> 
		<input type='button' value='수정' onclick="javascript:update('${dto.bbsno}')"> 
		<input type='button' value='삭제' onclick="javascript:delet('${dto.bbsno}')"> 
		<input type='button' value='답변' onclick="javascript:readReply('${dto.bbsno}')">

	</DIV>



	<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html>
