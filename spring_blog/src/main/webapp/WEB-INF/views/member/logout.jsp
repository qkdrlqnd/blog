<%@ page contentType="text/html; charset=UTF-8" %> 

<% request.setCharacterEncoding("utf-8"); 
	session.invalidate();	
	String root= request.getContextPath();
// 	response.sendRedirect(root+"/index.jsp");
%> 
 
 <script>
 var url="${pageContext.request.contextPath}/index.jsp";
 location.href=url;
</script>

