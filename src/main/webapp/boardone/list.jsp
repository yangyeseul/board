<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.boardone.BoardDAO" %>
<%@ page import="com.boardone.BoardVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="view/color.jsp" %>

<%! 
	// 한 페이지에 보여줄 게시물 수를 지정
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<% 
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null) {
		pageNum = "1";
	} 
	
	int currentPage = Integer.parseInt(pageNum);
	
	// 시작행
	int startRow = (currentPage - 1) * pageSize + 1;
	// 마지막행
	int endRow = currentPage * pageSize;
	
	int count = 0;
	int number = 0;
	
	List<BoardVO> articleList = null;
	
	BoardDAO dbPro = BoardDAO.getInstance();
	
	// 전체 글 수
	count = dbPro.getArticleCount(); 
	
	if(count > 0) {
		articleList = dbPro.getArticles(startRow, endRow);
	}
	
	number = count - (currentPage - 1) * pageSize;
%>

<%
	String option = request.getParameter("option");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="<%= bodyback_c %>">
	<div class="list_title">
		<p>&#11088; List &#11088;</p>
	</div>
	
	<br>
	
	<div class="list_button_write">
		<p>total : <%= count %></p>
		<a href="writeForm.jsp">Write</a>
	</div>
	
	<div class="list_container">
		<form class="list_form">
	<% 
		if(count == 0) { // 글이 없을 때 
	%>
			<table class="list_table_02">
				<tr>
					<td align="center">게시판에 저장된 글이 없습니다.</td>
				</tr>
			</table>
	<% 
		} else { // 글이 있을 때 
	%>
			<table class="list_table_03">
				<tr height="30" bgcolor="<%= value_c %>">
					<td align="center" width="50">no</td>
					<td align="center" width="300">subject</td>
					<td align="center" width="75">name</td>
					<td align="center" width="125">date</td>
					<td align="center" width="50">view</td>
					<td align="center" width="100">ip</td>
				</tr>
		<%
			for(int i = 0; i < articleList.size(); i++) {
				BoardVO article = (BoardVO)articleList.get(i);
		%>
				<tr height="30">
					<td class="list_table_03_td"><%= number-- %></td>
					<td width="300px" class="list_table_03_td">
					
						<%
							int wid = 0;
							if(article.getDepth() > 0) {
								wid = 5 * (article.getDepth());
						%>
						<img alt="" src="img/level.gif" width="<%= wid %>" height="16">
						<img alt="" src="img/re.gif">
						<%
							} else {
						%>
						<img alt="" src="img/level.gif" width="<%= wid %>" height="16">
						<%
							}
						%>
						
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%= currentPage %>">
							<%= article.getSubject() %>
						</a>
						
						<% if(article.getReadcount() >= 5) { %>
							<img alt="" src="img/hot.gif" border="0" height="16">
						<% } %>	
					</td>
					<td align="center" width="75" class="list_table_03_td">
						<a href="mailto:<%= article.getEmail() %>">
							<%= article.getWriter() %>
						</a>
					</td>
					<td align="center" width="125" class="list_table_03_td, list_date">
						<%= sdf.format(article.getRegdate()) %>
					</td>
					<td align="center" width="50" class="list_table_03_td">
						<%= article.getReadcount() %>
					</td>
					<td align="center" width="100" class="list_table_03_td, list_ip">
						<%= article.getIp() %>
					</td>
				</tr>
		<%
			}
		%>
			</table>
	<% 
		} 
	%>
			<div class="list_bottom_div">
	<%
		// 페이징 처리
		if(count > 0) {
			int pageBlock = 5; // 페이지 목록 넘기는 버튼 갯수
			int imsi = count % pageSize == 0 ? 0: 1; // 0이면 페이지가 딱 떨어짐 1이면 남은게 다음페이지로 넘어감
			int pageCount = count / pageSize + imsi;
			
			int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
			if(startPage > pageBlock) {
	%>
				<a href="list.jsp?pageNum=<%= startPage - pageBlock %>">[prev]</a>
	<%
			}
			
			for(int i = startPage; i <= endPage; i++) {
	%>
				<a href="list.jsp?pageNum=<%= i %>"><%= i %></a>
	<%		}
			
			if(endPage < pageCount) {
	%>
				<a href="list.jsp?pageNum=<%= startPage + pageBlock %>">[next]</a>
	<%		
			}
		}
	%>
			</div>
		</form>
		
		<form action="list.jsp" method="post" class="list_form2" name="listForm2">
			<select name="selectbox">
				<option value="0">select</option>
				<option value="writer">name</option>
				<option value="subject">subject</option>
				<option value="content">content</option>
			</select>
			&nbsp;&nbsp;
			<input type="text">&nbsp;&nbsp;
			<input type="button" value="Search" onclick="searchWord()" name="searchbar">
		</form>
	</div>
</body>
</html>