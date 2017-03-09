<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script type="text/javascript">


function incheck(f){
	if(f.passwd.value==""){
		
		alert("패스워드를 입력");
		f.passwd.focus();
		return false;
	}
	
}


</script>



<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>


 
<DIV class="title">삭제</DIV>
 
<c:choose>
	<c:when test="${flag}">
	답변있는 글입니다.<br>
	삭제 할 수 없습니다.<br>
	<input type ="button" value="확인" onclick="history.back()" >
	</c:when>
	<c:otherwise>
	<div class="content">정말로 삭제하시겠습니까? </div>
	  <form action="./delete" method="post" >
	  <input type="hidden" name="bbsno" value="${param.bbsno}">
	  <input type="hidden" name="col" value="${param.col}">
	  <input type="hidden" name="word" value="${param.word}">
	  <input type="hidden" name="nowPage" value="${param.nowPage}">
	  <input type="hidden" name="oldfile" value="${param.oldfile}">
	  <table> 
	  		<tr>
	  			<th>비밀번호</th>
	  			<td><input type = "password" name="passwd"></td>
	  		</tr>
	  </table>
	  
	  <DIV class='bottom'>
	    <input type='submit' value='확인' >
	    <input type='button' value='취소' onclick="history.back()">
	  </DIV>
	  </form>
	</c:otherwise>
</c:choose>
</body>
</html>