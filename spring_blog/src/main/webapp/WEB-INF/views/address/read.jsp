<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	*{
		text-align: center;
		font-size: 24px;
		font-family: gulim; 
	}
</style>
<script type="text/javascript">
	function update(no){
		var url = "update"
		url +="?no="+no;
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href=url;
	}
	function delet(no){
		var url = "delete"
		url +="?no="+no;
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href=url;
	}
	function alist(){
		var url = "./list";
		url += "?col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href=url;
	}
</script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div class="title">조회</div>

		<DIV CLASS="content">
		<table>
				<tr>
					<th>이름</th>
					<td>${dto.name}</td>
				</tr>			
				<tr>
					<th>전화번호</th>
					<td>${dto.phone}</td>
				</tr>			
				<tr>
					<th>우편주소</th>
					<td>${dto.zipcode}</td>
				</tr>			
				<tr>
					<th>주소</th>
					<td>${dto.address1}</td>
				</tr>			
				<tr>
					<th>상세주소</th>
					<td>${dto.address2}</td>
				</tr>			
				<tr>
					<td colspan ="2">
						<input type="button" value="목록" onclick="alist()">	
						<input type="button" value="수정" onclick="javascript:update('${dto.no}')">	
						<input type="button" value="삭제" onclick="javascript:delet('${dto.no}')">	
					</td>
				</tr>			
			</table>
		</DIV>
</body>
</html>





















