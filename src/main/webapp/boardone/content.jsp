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
	// list.jsp 제목 td에 잇는,,, ?num, &pageNum
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	try {
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO article = dbPro.getArticle(num);
		
		int ref = article.getRef();
		int step = article.getStep();
		int depth = article.getDepth();

%>

<body>
	<div class="content_div">
		<p>Read &#128209;</p>
		
		<br>
		
		<form action="" class="content_form">
			<table class="content_table">
				<tr class="content_table_tr">
					<td class="content_table_td" width="150px;" bgcolor="<%= value_c %>">ip</td>
					<td class="content_table_td3"><%= article.getIp() %></td>
					
					<td class="content_table_td" bgcolor="<%= value_c %>">view</td>
					<td class="content_table_td3"><%= article.getReadcount() %></td>
				</tr>
				
				<tr class="content_table_tr">
					<td class="content_table_td" bgcolor="<%= value_c %>">name</td>
					<td class="content_table_td3"><%= article.getWriter() %></td>
					
					<td class="content_table_td" bgcolor="<%= value_c %>">date</td>
					<td class="content_table_td3"><%= sdf.format(article.getRegdate()) %></td>
				</tr>
				
				<tr class="content_table_tr">
					<td class="content_table_td" bgcolor="<%= value_c %>">subject</td>
					<td class="content_table_td2" colspan="3"><%= article.getSubject() %></td>
				</tr>
				
				<tr class="content_table_tr">
					<td class="content_table_td" bgcolor="<%= value_c %>">content</td>
					<td class="content_table_td2" colspan="3">
						<pre><%= article.getContent() %></pre>
					</td>
				</tr>
			</table>
			
			<table class="content_table2">	
				<tr class="content_table_tr">
					<td align="right" colspan="4">
						<input type="button" value="Modify" onclick="document.location.href='updateForm.jsp?num=<%= article.getNum() %>&pageNum=<%= pageNum %>'">
						&nbsp;&nbsp;
						
						<input type="button" value="Delete" onclick="document.location.href='deleteForm.jsp?num=<%= article.getNum() %>&pageNum=<%= pageNum %>'">
						&nbsp;&nbsp;
						
						<input type="button" value="Reply" onclick="document.location.href='writeForm.jsp?num=<%= num %>&ref=<%= ref %>&step=<%= step %>&depth=<%= depth %>'">
						&nbsp;&nbsp;
						
						<input type="button" value="List" onclick="document.location.href='list.jsp?pageNum=<%= pageNum %>'">
						&nbsp;
					</td>
				</tr>
			</table>
<%
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
		</form>
	</div>
</body>
</html>