<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "com.boardone.BoardDAO" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="article" class="com.boardone.BoardVO" scope="page">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pass = request.getParameter("pass");
	BoardDAO dbPro = BoardDAO.getInstance();
	
	int check = dbPro.deleteArticle(num, pass); // 위 자바빈 VO의 article
	
	if(check == 1) {
		
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%= pageNum %>">
<title></title>
</head>
<body>
<% } else { // 수정실패 %> 
	<script type="text/javascript">
	alert("비밀번호가 틀렸습니다.");
	history.go(-1);
	</script>
<% } %>
</body>
</html>