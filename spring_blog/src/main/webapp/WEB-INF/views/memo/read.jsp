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
</style>

<script type="text/javascript">
	function mcreate() {
		var url = "create";
		location.href = url;

	}
	function mupdate(memono) {
		var url = "update";
		url += "?memono=" + memono;
		url += "&col=${col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}"
		location.href = url;
	}
	function mdelete(memono) {
		var url = "delete";
		url += "?memono=" + memono;
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}"
		location.href = url;
	}
	function mlist() {
		var url = "list";
		url += "?col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}"
		location.href = url;
	}
</script>

</head>
<body>
	<div>
		<div class="title">조회</div>
		
		
		<table>
			<tr>
				<th>제목</th>
				<td>${dto.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${dto.content}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${dto.viewcnt}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>${dto.wdate}</td>
			</tr>
		</table>



		<input type="button" value="등록"		onclick="mcreate()"> 
		<input type="button" value="수정"  	onclick="mupdate('${dto.memono}')">
		<input type="button" value="삭제" 	onclick="mdelete('${dto.memono}')"> 
		<input type="button" value="목록" 	onclick="mlist()">


	</div>




</body>
</html>
