<%@ page contentType="text/html; charset=UTF-8" %> 
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="util" uri="/utility" %>
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
function read(no){
	var url = "read";
	url += "?no="+no;
	url += "&col=${col}";
	url += "&word=${word}";
	url += "&nowPage=${nowPage}";
	
	location.href=url;
}
function down(filename){
	var url ="${pageContext.request.contextPath}/download";
	url += "?dir=/views/teamimage/storage";
	url += "&filename="+filename;
	location.href = url;
}

</script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">게시판 목록</DIV>
 
 <div class="search">
<FORM name='frm' method='POST' action='./list'>
	<select name="col">
		<option value="name" <c:if test="${param.col == 'name'}">selected='selected'</c:if>>이름</option>
		<option value="title" <c:if test="${param.col == 'title'}">selected='selected'</c:if>>제목</option>
		<option value="total">전체출력</option>
	</select>
	<input type="text" name="word" value="${param.word}">
	<input type="submit" value="검색">
</FORM>
</div>
  <TABLE>
    <TR>
      <TH>번호</TH>
      <TH>이름</TH>
      <TH>제목</TH>
      <TH>조회수</TH>
      <TH>등록일</TH>
      <TH>파일</TH>
      <TH>사진</TH>
      
    </TR>
    	<c:choose>
    		<c:when test="${fn:length(list) == 0 }">
    			 <tr>
    				<td colspan='6'>등록된 글이 없습니다.</td>
    			</tr>
    		</c:when>
    		<c:otherwise>
    			<c:forEach items="${list}" var="dto">
    				 <tr>
	    				<td>${dto.no }</td>
	    				<td>${dto.name }</td>
	    				<td>
	    					<c:forEach begin="0" end="${dto.ino}" >
	    						&nbsp;&nbsp;
	    					</c:forEach>
	    					<c:if test="${dto.ino>0 }">
	    						<img src="../images/re.jpg" width="30px" height="30px"> 
	    					</c:if>
	    					
	    					
	    					<a href="javascript:read('${dto.no}')">${dto.title}</a>
	    					<c:if test="${util:newImg(dto.wdate) }">
	    						<img src="../images/new.gif">
	    					</c:if>
	    				</td>
	    				<td>${dto.viewcnt}</td>
	    				<td>${dto.wdate}</td>
	    				<td>
	    					<c:choose>
	    						<c:when test="${empty dto.filename }">
	    							-
	    						</c:when>
	    						<c:otherwise>
	    							<a href="javascript:down('${dto.filename}')">
    									<span class='glyphicon glyphicon-download-alt'></span>
    								</a>
	    						</c:otherwise>
	    					</c:choose>
	    				</td>
	    				<td> <img style="width:100px;heigth:100px;" src="${pageContext.request.contextPath}/teamimage/storage/${dto.filename}"></td>
	    			</tr>
    			</c:forEach>
    		</c:otherwise>
    	</c:choose>
  </TABLE>
  
  <DIV class='bottom'>
  	<input type="button" value="등록" onclick="location.href='./create'">
    ${ paging }
  </DIV>
 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html>