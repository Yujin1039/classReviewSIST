<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.employee.dao.EmployeeDAO" %>
<%
	request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="employee" class="kr.employee.vo.EmployeeVO"/>
	<jsp:setProperty property="*" name="employee"/>
<%
	EmployeeDAO dao = EmployeeDAO.getInstance();
	dao.insertEmployee(employee);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 등록 완료</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="page-main">
	<h1>직원 등록 완료</h1>
	<div class="result-display">
		<div class="align-center">
			직원 등록을 완료했습니다.<p>
			<button onclick="location.href='main.jsp'">홈으로</button>
		</div>
	</div>	
</div>
</body>
</html>