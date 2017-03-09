<%@ page contentType="text/html; charset=UTF-8"%>

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

div{
	text-align: center;
	margin-top : 20px;
	margin-bottom: 20px; 
}
</style>
<script type="text/javascript">
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
	<div>삭제 확인</div>
	<form action="delete" method="post">
	
	
		<input type="hidden" name="col" value="${param.col}" >
		<input type="hidden" name="word" value="${param.word}" >
		<input type="hidden" name="nowPage" value="${param.nowPage}" >
		<input type="hidden" name="memono" value="${param.memono}" >
		<div>
		삭제를 하면 복구 될 수 없습니다.<br><br>
		삭제하시려면 삭제버튼을 클릭하세요<br><br>
		취소는 '목록'버튼을 누르세요<br><br>
		<input type="submit" value="삭제" >
		<input type="button" value="목록" onclick="mlist()" >
		</div>
	
	</form>

</body>
</html>
