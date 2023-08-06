<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="view/color.jsp" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body>
	<div class="updateForm_div">
		<p>Delete &#128298;</p>
	</div>
	
	<br>
	
	<form action="deleteProc.jsp?pageNum=<%= pageNum %>" class="deleteForm_form" method="post" name="delForm" onsubmit="return deleteSave()">
		<table class="deleteForm_table">			
			<tr>
				<td class="deleteForm_td_01">PW</td>
				<td class="deleteForm_td_02">
					<input type="password" name="pass" size="20">
					<input type="hidden" name="num" value="<%= num %>">
				</td>
			</tr>
			
			<tr>
				<td align="center" colspan="2">
					<input type="submit" value="Delete">&nbsp;&nbsp;
					<input type="button" value="List" onclick="document.location.href='list.jsp?pageNum=<%= pageNum %>'"> 
				</td>
			</tr>
		</table>

	</form>
</body>
</html>