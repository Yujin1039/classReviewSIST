<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.employee.dao.EmployeeDAO" %>
<%@ page import="kr.employee.vo.EmployeeVO" %>
<%
	String emp_id = (String) session.getAttribute("emp_id");
	
	if(emp_id == null){
		response.sendRedirect("loginForm.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		EmployeeDAO dao = EmployeeDAO.getInstance();
		EmployeeVO vo = dao.checkEmployee(id);
		boolean check = false;
		
		//아이디가 등록되어 있고 로그인한 아이디와 일치할 경우 (로그인하지 않은 등록된 아이디 삭제 방지)
		if(vo != null && emp_id.equals(id)){
			//비밀번호 일치 여부 체크
			check = vo.isCheckedPassword(passwd);
		}
		if(check){
			dao.deleteEmployee(vo.getNum());
			//로그아웃
			session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 탈퇴 처리</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="page-main">
	<h1>사원 탈퇴</h1>
	<div class="result-display">
		<div class="align-center">
			사원 탈퇴 처리가 완료되었습니다.<p>
			<button onclick="location.href='main.jsp'">홈으로</button>
		</div> 
	</div>
</div>
</body>
</html>
<%			
		}else{
%>
			<script type="text/javascript">
				alert('아이디 또는 비밀번호가 불일치합니다.');
				history.go(-1);
			</script>
<%
		}
	}
%>