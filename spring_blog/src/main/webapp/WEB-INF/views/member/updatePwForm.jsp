<%@ page contentType="text/html; charset=UTF-8" %>
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

	function pwCheck(f){
		if(f.passwd.value == ""){
			alert("변경됣 패스워드를 입력해주세요");
			f.passwd.focus();
			return false;
		}
		
		if(f.repasswd.value == ""){
			alert("변경됣 패스워드 확인를 입력 해주세요");
			f.repasswd.focus();
			return false;
		}
		
		if(f.passwd.value != f.repasswd.value){
			alert("패스워드가 일치하지 않습니다.");
			f.passwd.value = "";
			f.repasswd.value = "";
			f.passwd.focus();
			return false;
		}
		
	}

</script>


<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title"></DIV>
 
<FORM name='frm' method='POST' action='./updatePwProc.do' onsubmit="return pwCheck(this)">
	<input type="hidden" name="id" value="${id}">
  <TABLE>
    <TR>
      <TH>패스워드</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>패스워드 확인</TH>
      <TD><input type="password" name="repasswd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='변경'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 
