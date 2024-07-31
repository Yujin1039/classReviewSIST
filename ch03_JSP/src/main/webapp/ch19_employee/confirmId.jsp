<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="kr.employee.dao.EmployeeDAO"%>
<%@ page import="kr.employee.vo.EmployeeVO"%>
<%
	request.setCharacterEncoding("utf-8");
	//전송된 데이터 반환
	String id = request.getParameter("id");
	
	//checkEmployee메서드의 결과값에 따라 JSON객체 생성
	EmployeeDAO dao = EmployeeDAO.getInstance();
	EmployeeVO vo = dao.checkEmployee(id);
	if(vo!=null){
		%>
		{"result":"idDuplicated"}
		<%
	}else{
		%>
		{"result":"idNotFound"}
		<%
	}
%>