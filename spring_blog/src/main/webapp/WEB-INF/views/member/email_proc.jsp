<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 

<script>

	function use(){
		
		
		opener.frm.email.value = "${param.email}";
		window.close();
		
	}

</script>

<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">email중복확인</DIV>

<div class="content">
	<table>
		<tr>
			<th>email</th>
			<td>${param.email }</td>
		</tr>
	</table>
	<c:choose>
		<c:when test="${flag}">
			중복된 email입니다.<br> 사용 할 수 없습니다.<br><br>
		</c:when>
		<c:otherwise>
			중복된 아이디가 아닙니다. 사용 할 수 있습니다.<br><br>
			<input type="button" value="사용" onclick="use()" >
		</c:otherwise>
	</c:choose>
</div>

<DIV class='bottom'>
    <input type='button' value='다시시도' onclick="location.href='email_form.do'">
    <input type='button' value='닫기' onclick="window.close()">
</DIV>

 
 
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 
