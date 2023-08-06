<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	// 새글(num=0)인지 답변글인지 구분하는 코드 삽입
	// 답변글인 경우 내가 쓰고자하는 번호를 가져와서 그 번호에 답변글을 씀
	// num = 글번호, ref = 원래 글번호를 참조, step = 답변글의 갯수, depth = 답변글의 깊이
	int num = 0, ref = 1, step = 0, depth = 0;
	
	try {
		if(request.getParameter("num") != null) { // 답변글일 때
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			step = Integer.parseInt(request.getParameter("step"));
			depth = Integer.parseInt(request.getParameter("depth"));
		} // end if
%>

<body bgcolor="<%= bodyback_c %>" >
	<div class="writeForm_title">
		<p>Write &#9997;</p>
	</div>
	
	<br>
	
	<form action="writeProc.jsp" name="writeForm" method="post" onsubmit="return writeSave()" class="writeForm_form">
		<input type="hidden" name="num" value="<%= num %>">
		<input type="hidden" name="ref" value="<%= ref %>">
		<input type="hidden" name="step" value="<%= step %>">
		<input type="hidden" name="depth" value="<%= depth %>">
		
		<table bgcolor="<%= bodyback_c %>" class="writeForm_table1">
			<tr class="writeForm_tr">
				<td align="right" colspan="2">
					<a href="list.jsp">list</a>
				</td>
			</tr>
		</table>
		
		<table bgcolor="<%= bodyback_c %>" class="writeForm_table2">
			<tr class="writeForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">name</td>
				<td width="450px" class="writeForm_td">
					<input type="text" size="12" maxlength="12" name="writer">
				</td>
			</tr>
			
			<tr class="writeForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">e-mail</td>
				<td width="450px" class="writeForm_td">
					<input type="text" size="40" maxlength="40" name="email">
				</td>
			</tr>
			
			<tr class="writeForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">subject</td>
				<td width="450px" class="writeForm_td">
					<% 
						if(request.getParameter("num") == null) { // 새글일 경우
					%>		
					<input type="text" size="50" maxlength="50" name="subject">
					<%
						} else { // 답변글일 경우
					%>
					<input type="text" size="50" maxlength="50" name="subject" value="[reply] ">
					<%
						}
					%>
				</td>
			</tr>
			
			<tr class="writeForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">content</td>
				<td width="450px" class="writeForm_td">
					<textarea rows="13" cols="53" name="content"></textarea>
				</td>
			</tr>
			
			<tr class="writeForm_tr">
				<td width="150px" bgcolor="<%= value_c %>" align="center">password</td>
				<td width="450px" class="writeForm_td">
					<input type="password" size="10" maxlength="10" name="pass">
				</td>
			</tr>
		</table>
		
		<table class="writeForm_table3">
			<tr class="writeForm_buttons">
				<td align="center" colspan="2">
				<input type="submit" value="Write">&nbsp;&nbsp;
				<input type="reset" value="Reset">&nbsp;&nbsp;
				<input type="button" value="list" onclick="window.location='list.jsp'">
				</td>
			</tr>
		</table>
	</form>
<%
	} catch(Exception e) {
		e.printStackTrace();
	} 
%>
</body>
</html>
