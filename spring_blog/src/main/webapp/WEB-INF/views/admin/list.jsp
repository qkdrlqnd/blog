<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html>  
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 15px; 
} 

img.img{
	
	
	width: 170px;
	height: 200px;
	
	
}

td#td1{
	 margin: 50px auto;
	 background-color: black;
}


</style> 

<script type="text/javascript">


	function mlist(){
		
		var url = "./list";
		url += "?col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";

		location.href= url;		 
	}
	
	function read(id){	
		var url = "${pageContext.request.contextPath}/member/read";
		url += "?id="+id;
		url += "&col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";

		location.href= url;		
		
	}

	
	function img(fname){	
		
		
		var url ="${pageContext.request.contextPath}/views/member/storage/"+fname;
		
		
		location.href= url;
		wr = window.open(url,"사진보기","width=500,height=400");
	}

	
	

</script>

 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">회원목록</DIV>
 
	<TABLE>
    		<c:choose>
				<c:when test="${not empty iter}">	    		
	    		
		    		<c:forEach items="${iter}" var="dto">
						<tr>
			      			<TD id="td1" rowspan="7" ><a onclick="javascript:img('${dto.fname}')"><img class="img" src="${pageContext.request.contextPath}/member/storage/${dto.fname}"></a></TD>
			      		</tr>
			    		
			    		<tr>
			    			<TH>아이디</TH>
			      			<TD><a href="javascript:read('${dto.id}')">${dto.id}</a></TD>
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
			      			<TH>이메일</TH>
			      			<TD>${dto.email}</TD>
						</tr>
			    		
			    		<tr>
			      			<TH>회원등급</TH>
			      			<TD>${dto.grade}</TD>
			      		</tr>
			    		
			    		<tr>	
			      			<TH>등록일</TH>
			      			<TD>${dto.mdate}</TD>
			    		</TR>
								    			
		    		</c:forEach>
	    		</c:when>
	    		<c:otherwise>
	    			<tr colspan = "4">
	    				<td>
	    					등록된 회원이 없습니다.
	    				</td>
	    			</tr>
	    		</c:otherwise>
    		</c:choose>
	</TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='....'>
    <input type='button' value='회원탈퇴' onclick="location.href=''">
  </DIV>

	
	<div class="content">
	<form name="frm" action="./list" method="post">
		<select name="col">
			<option value="id" 		<c:if test="${param.col =='id'}"> selected='selected' </c:if>>아이디</option>
			<option value="mname" 	<c:if test="${param.col =='mname'}"> selected='selected' </c:if>>이름</option>
			<option value="email"	<c:if test="${param.col =='email'}"> selected='selected' </c:if>>email</option>
			<option value="total"	>전체</option>
		</select>
		<input type="text" name="word" value="${param.word}" >
		<input type="submit" value="검색" >
	</form>
 	</div>
 	
	<div>${paging}</div>
 
 
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 
