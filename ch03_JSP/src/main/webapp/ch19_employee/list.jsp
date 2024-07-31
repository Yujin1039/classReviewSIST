<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.story.dao.StoryDAO" %>
<%@ page import="kr.story.vo.StoryVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.util.PagingUtil" %>
<%
	Integer emp_num = (Integer) session.getAttribute("emp_num");
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int rowCount = 10;
	int pageCount = 10;	
	
	StoryDAO dao = StoryDAO.getInstance();
	int count = dao.getCount();
	
	PagingUtil util = new PagingUtil(currentPage,count,rowCount,pageCount,"list.jsp");
	
	List<StoryVO> list = null;
	list = dao.getList(util.getStartRow(),util.getEndRow()); 
%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>글 목록</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
	</head>
	<body>
	<div class="page-main">
		<h1>글 목록</h1>
<%
	if(emp_num == null){
%>
		<div class="align-right">
			<button onclick="location.href='main.jsp'">홈으로</button> <!-- 로그인시, 글 쓰기로 수정 -->
		</div>
<%		
	}else{
%>
		<div class="align-right">
			<button onclick="location.href='writeForm.jsp'">글쓰기</button>
			<button onclick="location.href='main.jsp'">홈으로</button> 
		</div>
<%		
	}
	
	if(count == 0){
%>
		<div class="result-display">
			작성된 글이 없습니다.
		</div>
<%		
	}else{
%>
	<table>
		<tr>
			<th>글 번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
<%		
		
		for(StoryVO vo: list){
%>
			<tr>
				<td><%= vo.getSnum() %></td>
				<td><a href="detail.jsp?snum=<%= vo.getSnum() %>"><%= vo.getTitle() %></a></td>
				<td><%= vo.getId() %></td>
				<td><%= vo.getReg_date() %></td>
			</tr>
<%			
		}
%>
	</table>
	<div class="align-center">
		<%= util.getPage() %>
	</div>
<%		
	}
%>	
	</div>
	</body>
	</html>


