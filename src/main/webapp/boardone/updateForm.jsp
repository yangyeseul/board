<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="com.boardone.BoardDAO" %>
<%@ page import="com.boardone.BoardVO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="view/color.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<%
	// content의 ?num, &pageNum 에서 넘어옴
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	try{
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO article = dbPro.updateGetArticle(num);
%>

<body>
	<div class="updateForm_div">
		<p>Mordify &#9997;</p>
	</div>
	
	<br>
	
	<form action="updateProc.jsp?pageNum=<%= pageNum %>" class="updateForm_form" method="post" name="writeForm" onsubmit="return writeSave()">
	
		<table bgcolor="<%= bodyback_c %>" class="writeForm_table1">
			<tr class="updateForm_tr">
				<td align="right" colspan="2">
					<a href="list.jsp">list</a>
				</td>
			</tr>
		</table>
		
		<table bgcolor="<%= bodyback_c %>" class="updateForm_table2">
			<tr class="updateForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">name</td>
				<td width="450px" class="updateForm_td">
					<input type="text" size="12" maxlength="12" name="writer" value="<%= article.getWriter() %>">
					<input type="hidden" name="num" value="<%= article.getNum() %>">
				</td>
			</tr>
			
			<tr class="updateForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">subject</td>
				<td width="450px" class="updateForm_td">
					<input type="text" size="50" maxlength="50" name="subject" value="<%= article.getSubject() %>">
				</td>
			</tr>
			
			<tr class="updateForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">e-mail</td>
				<td width="450px" class="updateForm_td">
					<input type="text" size="40" maxlength="40" name="email" value="<%= article.getEmail() %>">
				</td>
			</tr>
			
			<tr class="updateForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">content</td>
				<td width="450px" class="updateForm_td">
					<textarea rows="13" cols="53" name="content"><%= article.getContent() %></textarea>
				</td>
			</tr>
			
			<tr class="updateForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">password</td>
				<td width="450px" class="updateForm_td">
					<input type="password" size="10" maxlength="10" name="pass">
				</td>
			</tr>
		</table>
		
		<table class="updateForm_table3">
			<tr class="updateForm_buttons">
				<td align="center" colspan="2">
				<input type="submit" value="Modify">&nbsp;&nbsp;
				<input type="reset" value="Reset">&nbsp;&nbsp;
				<input type="button" value="list" onclick="document.location.href='list.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
<%
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</html>