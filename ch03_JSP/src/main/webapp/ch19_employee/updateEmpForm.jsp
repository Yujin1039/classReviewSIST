<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.employee.dao.EmployeeDAO" %>
<%@ page import="kr.employee.vo.EmployeeVO" %>
<%
	Integer emp_num = (Integer) session.getAttribute("emp_num");
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
		<title>사원정보 수정</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
		<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.7.1.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#update_form').submit(function(){
					const items = document.querySelectorAll('.input_check');
					for(let i=0;i<items.length;i++){
						if(items[i].value.trim() == ''){
							const label = document.querySelector('label[for="'+items[i].id+'"]');
							alert(label.textContent+' 항목 필수 입력!');
							items[i].value = '';
							items[i].focus();
							return false;
						}						
					}
				});
			});
		</script>
		</head>
		<body>
		<div class="page-main">
			<h1>사원정보 수정</h1>
			<form action="updateEmp.jsp" method="post" id="update_form">
				<ul>				
					<li>
					 	<label for="name">이름</label> 
						<input type="text" name="name" value="<%= vo.getName() %>" id="name" class="input_check">
					</li>
					<li>
					 	<label for="passwd">비밀번호</label> 
						<input type="password" name="passwd" id="passwd" class="input_check">
					</li>
					<li>
					 	<label for="salary">급여</label> 
						<input type="number" name="salary" value="<%= vo.getSalary() %>" id="salary" class="input_check">
					</li>
					<li>
					 	<label for="job">업무</label> 
						<input type="text" name="job" value="<%= vo.getJob() %>" id="job" class="input_check">
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="수정">
					<input type="button" value="홈으로" onclick="location.href='main.jsp'">
				</div>
			</form>
		</div>
		</body>
		</html>
<%		
	}
%>
