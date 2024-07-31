<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.story.dao.StoryDAO" %>
<%
	Integer emp_num = (Integer) session.getAttribute("emp_num");
	
	if(emp_num == null){
		response.sendRedirect("loginForm.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
%>
		<jsp:useBean id="vo" class="kr.story.vo.StoryVO"/>
		<jsp:setProperty property="*" name="vo"/>
<%
		vo.setNum(emp_num);
		vo.setIp(request.getRemoteAddr());
		StoryDAO dao = StoryDAO.getInstance();
		dao.insert(vo);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성 완료</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="page-main">
	<h1>글 작성 완료</h1>
	<div class="result-display">
		<div class="align-center">
			글이 성공적으로 등록 완료되었습니다.<p>
			<button onclick="location.href='list.jsp'">목록</button>
		</div>
	</div>
</div>
</body>
</html>