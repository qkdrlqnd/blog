<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}
</style>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
	
	<!-- *********************************************** -->

	<DIV class="title">등록</DIV>

	<FORM name='frm' method='POST' action='./create' enctype="multipart/form-data" >
		<TABLE>
			<TR>
				<TH>성명</TH>
				<TD><input type="text" name="wname"></TD>
			</TR>
			<tr>
				<TH>제목</TH>
				<TD><input type="text" name="title"></TD>

			</tr>
			<tr>
				<TH>내용</TH>
				<TD><textarea rows="10" cols="45" name="content"></textarea></TD>

			</tr>
			<tr>
				<TH>파일명</TH>
				<TD><input type="file" name="fileMF"></TD>

			</tr>
			<tr>
				<TH>비밀번호</TH>
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
