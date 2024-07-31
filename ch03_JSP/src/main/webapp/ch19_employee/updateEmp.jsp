<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.employee.dao.EmployeeDAO" %>
<%
	Integer emp_num = (Integer) session.getAttribute("emp_num");
	if(emp_num == null){
		response.sendRedirect("loginForm.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="vo" class="kr.employee.vo.EmployeeVO"/>
	<jsp:setProperty property="*" name="vo"/>
<%		
		vo.setNum(emp_num);
		EmployeeDAO dao = EmployeeDAO.getInstance();
		dao.updateEmployee(vo);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원정보 수정 완료</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="page-main">
	<h1>사원정보 수정 완료</h1>
	<div class="result-display">
		<div class="align-center">
			사원정보를 수정 완료했습니다.<p>
			<button onclick="location.href='main.jsp'">홈으로</button>
		</div>
	</div>
</div>
</body>
</html>