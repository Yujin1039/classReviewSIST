<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.employee.dao.EmployeeDAO"%>
<%@ page import="kr.employee.vo.EmployeeVO"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");

	EmployeeDAO dao = EmployeeDAO.getInstance();
	EmployeeVO vo = dao.checkEmployee(id);
	boolean check = false;
	
	if(vo!=null){
		check = vo.isCheckedPassword(passwd);
	}
	
	if(check){
		//로그인 처리 
		session.setAttribute("emp_num",vo.getNum());		
		session.setAttribute("emp_id",id);
		response.sendRedirect("main.jsp");		
	}else{
%>
		<script>
			alert('아이디 또는 비밀번호가 불일치합니다.');
			history.go(-1);
		</script>
<%		
	}
%>