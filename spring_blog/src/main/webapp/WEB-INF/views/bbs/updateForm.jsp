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
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

	<!-- *********************************************** -->

	<DIV class="title">수정</DIV>

	<FORM name='frm' method='POST' action='./update' enctype="multipart/form-data">
	
		<input type="hidden" name="bbsno" 		value="${dto.bbsno}" >
		<input type="hidden" name="col" 		value="${param.col}" >
		<input type="hidden" name="word" 		value="${param.word}" >
		<input type="hidden" name="nowPage" 	value="${param.nowPage}" >
		<input type="hidden" name="oldfile" 	value="${dto.filename}" >
		<TABLE>
			<TR>
				<TH>성명</TH>
				<TD><input type="text" name="wname" value="${dto.wname}"></TD>
			</TR>
			<tr>
				<TH>제목</TH>
				<TD><input type="text" name="title" value="${dto.title}"></TD>

			</tr>
			<tr>
				<TH>내용</TH>
				<TD><textarea rows="10" cols="45" name="content" >${dto.content}</textarea></TD>

			</tr>
			
			<tr>
				<TH>내용</TH>
				<TD><input type="file" name="fileMF"  >${dto.filename}</TD>

			</tr>
			
			
			<tr>
				<TH>비밀버호</TH>
				<TD><input type="password" name="passwd"></TD>

			</tr>

		</TABLE>

		<DIV class='bottom'>
			<input type='submit' value='등록'> 
			<input type='button' value='취소' onclick="history.back()">
		</DIV>
	</FORM>


	<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 
