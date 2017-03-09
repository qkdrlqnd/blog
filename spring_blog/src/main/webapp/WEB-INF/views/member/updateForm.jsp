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

<script>
	function inCheck(f){
		if(f.fname.value==""){
			alert("파일을 선택해주세요");
			f.fname.focus();
			return false;
		}
		
	}


</script>


<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">사진 수정</DIV>
 
<FORM name='frm' method='POST' action='./updateFile' enctype="multipart/form-data" onsubmit="return inCheck(this)">
  <input type="hidden" name="oldfile"  value="${param.oldfile}">
  <input type="hidden" name="id" value="${id}">
  
  <TABLE>
    <TR>
      <TH>원본파일</TH>
      <TD><img style="width:300px; height: 400px" src="${pageContext.request.contextPath}/member/storage/${param.oldfile}"></TD>
    </TR>
    <TR>
      <TH>변경파일</TH>
      <TD><input type="file" name="fileMF" accept=".gif, .jpg, .png"></TD>
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
