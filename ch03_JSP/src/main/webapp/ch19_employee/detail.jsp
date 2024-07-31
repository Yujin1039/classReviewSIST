<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.story.vo.StoryVO" %>
<%@ page import="kr.story.dao.StoryDAO" %>
<%
	Integer emp_num = (Integer) session.getAttribute("emp_num");
	
	int num = Integer.parseInt(request.getParameter("snum"));
	StoryDAO dao = StoryDAO.getInstance();
	StoryVO vo = dao.getStory(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="page-main">
	<h1>글 상세</h1>
	<ul>
		<li>글 번호 : <%= vo.getSnum() %></li>
		<li>작성자 : <%= vo.getId() %></li>
		<li>제목 : <%= vo.getTitle() %></li>		
		<li>작성일 : <%= vo.getReg_date() %></li>
	</ul>
	<hr size="1" width="100%" noshade="noshade">
	<p> <%= vo.getContent() %> </p>
	<hr size="1" width="100%" noshade="noshade">
	<div class="align-right">
<%
	if(emp_num != null && emp_num == vo.getNum()){
%>
		<button onclick="location.href='updateForm.jsp?snum=<%= vo.getSnum() %>'">수정</button>
		<button onclick="location.href='deleteForm.jsp?snum=<%= vo.getSnum() %>'">삭제</button>
<%
	}
%>
		<button onclick="location.href='list.jsp'">목록</button>
	</div>	
</div>
</body>
</html>