<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.employee.dao.EmployeeDAO" %>
<%@ page import="kr.employee.vo.EmployeeVO" %>
<%
	Integer emp_num = (Integer)session.getAttribute("emp_num");

	if(emp_num == null){
		response.sendRedirect("loginForm.jsp");
	}else{
		EmployeeDAO dao = EmployeeDAO.getInstance();
		EmployeeVO vo = dao.getEmployee(emp_num);
%>
		<!DOCTYPE html>
		<html>
		<head>
		<meta charset="UTF-8">
		<title>직원 상세정보</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
		</head>
		<body>
			<div class="page_main">
				<h1>상세정보</h1>
				<ul>
					<li>아이디 : <%= vo.getId() %></li>
					<li>이름 : <%= vo.getName() %></li>
					<li>급여 : <%= vo.getSalary() %></li>
					<li>직업 : <%= vo.getJob() %></li>
					<li>가입일 : <%= vo.getReg_date() %></li>
				</ul>
				<hr size="1" width="100%" noshade="noshade">
				<div class="align-right">
					<button onclick="location.href='updateEmpForm.jsp'">사원정보 수정</button>
					<button onclick="location.href='deleteEmpForm.jsp'">사원 탈퇴</button>
					<button onclick="location.href='main.jsp'">홈으로</button>
				</div>
			</div>
		</body>
		</html>
<%
	}	
%>
