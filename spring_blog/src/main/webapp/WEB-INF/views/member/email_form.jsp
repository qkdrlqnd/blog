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
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">email 중복 확인</DIV>
<div class="content">
<FORM name='frm' method='POST' action='./email_proc.do'>
email를입력해주세요 
  <TABLE>
    <TR>
      <TH>ID</TH>
      <TD><input type="text" name="email" size="20"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='중복확인'>
    <input type='button' value='취소' onclick="window.close()">
  </DIV>
</FORM>
 </div>
 
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 
