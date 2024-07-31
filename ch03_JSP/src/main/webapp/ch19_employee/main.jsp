<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리 메인</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" type="text/css">
</head>
<body>
<%
	String emp_id = (String)session.getAttribute("emp_id");
%>
<div class="page-main">
	<h1>사원관리 메인</h1>
	<div class="align-right">
		<a href="list.jsp">사원이야기</a>
<%
		if(emp_id == null){
%>		
			<span><a href="loginForm.jsp">로그인</a></span>
			<span><a href="registerEmpForm.jsp">사원등록</a></span>		
<%		
	}else{
%>
			<a href="myPage.jsp">myPage</a>
			[<b><%= emp_id %></b>님이 로그인 중]
			<a href="logout.jsp">로그아웃</a>		
<%		
	}
%>
	</div>	
</div>
</body>
</html>