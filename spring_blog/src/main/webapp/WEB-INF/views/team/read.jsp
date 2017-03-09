<%@ page contentType="text/html; charset=UTF-8" %> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function tlist(){
	var url = "list";
	url +="?col=${param.col}";
	url +="&word=${param.word}";
	url +="&nowPage=${param.nowPage}";
	
	location.href=url;
}
function update(no){
	var url = "update";
	url +="?col=${param.col}";
	url +="&word=${param.word}";
	url +="&nowPage=${param.nowPage}";
	url +="&no=${param.no}";
	
	location.href=url;
}

</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
}
div{
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}
table{
	width: 60%;
	margin:auto;
}
table,th,td{
	border:1px solid black;
	border-collapse: collapse;
}
th,td{
	padding:10px;
}
img{
	width:400px;
	height: 400px;

}
#ftd{
	text-align: center;
}
</style> 
</head> 
<body> 
<div>조회</div>
<table>
    <tr>
    	<td colspan="2" id="ftd">
    	<img src='${pageContext.request.contextPath}/team/storage/${dto.filename}'>
    	</td>
    </tr>
	<tr>
		<th>이름</th>
		<td>${dto.name}</td>
	</tr>
	<tr>
		<th>성별</th>
		<td>${dto.gender}</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>${dto.phone}</td>
	</tr>
	<tr>
		<th>주소</th>
		<td>
			${dto.address1}<br>
		    ${dto.address2}
		    (${dto.zipcode})
		</td>
	</tr>
	<tr>
		<th>보유기술</th>
		<td>${dto.skillstr}</td>
	</tr>
	<tr>
		<th>취미</th>
		<td>${dto.hobby}</td>
	</tr>
</table>
<div>
	<input type="button" value="생성" 
		onclick="location.href='./create'">
	<input type="button" value="목록" 
		onclick="tlist()">
	<input type='button' value='다운로드' onclick="location.href='${pageContext.request.contextPath}/download?dir=/team/storage&filename=${dto.filename}'">
	<input type="button" value="수정" onclick="update('${dto.no}')"> 

</div>
</body> 
</html> 












