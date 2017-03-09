<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/utility" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
img.img{
	
	
	width: 350px;
	height: 550px;
	
	
}

td#td1{
	
	 margin: 50px auto;
	 background-color: black;
}

</style> 

<script type="text/javascript">

	function mlist(){
		var url = "${pageContext.request.contextPath}/admin/list";
		url += "?col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		
		location.href= url;
	}

	function updateFile(){
		var url = "./updateFile";
		url += "?id=${id}";
		url += "&oldfile=${dto.fname}";
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}>";
		
		location.href = url;
		
		
	}
	function updatePw(){
		var url = "./updatePw";
		url += "?id=${id}";
		url += "&passwd=${dto.passwd}";
		
		location.href = url;
		
		
	}
	function update(){
		var url = "./update";
		url += "?id=${id}";
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href = url;
	}
	function mdelete(){
		var url = "./delete";
		url += "?id=${id}";
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href = url;
	}
	
	function downFile(){
		var url = "${pageContext.request.contextPath}/download?dir=/views/member/storage/&filename=${dto.fname}";
		location.href = url;
	}
	
	
</script>


<link href="{pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">상세정보</DIV>
  <TABLE>
   			<TR >	

      			<TD id="td1" rowspan="11" ><a href="${pageContext.request.contextPath}/views/member/storage/${dto.fname}" ><img class="img" src="${pageContext.request.contextPath}/member/storage/${dto.fname}"></a></TD>
      		</tr>
    		
    		
    		<tr>
    			<TH>아이디</TH>
      			<TD>${dto.id}</TD>
      		</tr>
      		
      		<tr>
      			<TH>이름</TH>
      			<TD>${dto.mname}</TD>
      		</tr>
    		
    		<tr>
      			<TH>전화번호</TH>
      			<TD>${dto.tel}</TD>
      		</tr>
    		<tr>
      			<TH>우편번호</TH>
      			<TD>${dto.zipcode}</TD>
      		</tr>
    		<tr>
      			<TH>주소</TH>
      			<TD>${dto.address1}</TD>
      		</tr>
    		<tr>
      			<TH>상세주소</TH>
      			<TD>${dto.address2}</TD>
      		</tr>
    		
    		<tr>
      			<TH>이메일</TH>
      			<TD>${dto.email}</TD>
			</tr>
			
			<tr>
      			<TH>직업</TH>
      			<TD>${dto.job}
      				(${util:codeValue(dto.job)})
      			</TD>
			</tr>
    		
    		<tr style="width: 25%">
      			<TH>회원등급</TH>
      			<TD>${dto.grade}</TD>
      		</tr>
    		
    		<tr>	
      			<TH>등록일</TH>
      			<TD>${fn:substring(dto.mdate,0,10) }</TD>
    		</TR>
 
  </TABLE>
  <DIV class='bottom'>
  <input type='button' value='정보수정' onclick="update()">
  	<c:choose>
  		<c:when test="${not empty id && grade == 'A' }">
  			<input type='button' value='회원목록' onclick="mlist()">
  			
  		</c:when>
  		<c:otherwise>
  			
    		<input type='button' value='사진수정' onclick="updateFile()">
    		<input type='button' value='다운로드' onclick="downFile()">
    		<input type='button' value='회원탈퇴' onclick="mdelete()">
    
		    <form action="./updatePw" method="post">	
    			<input type="hidden" name="passwd" value="${dto.passwd}">
    			<input type="submit" value="패스워드변경">
    		</form>	
  		</c:otherwise>
  	</c:choose>
	
  </DIV>
</body>
<!-- *********************************************** -->
</html> 
