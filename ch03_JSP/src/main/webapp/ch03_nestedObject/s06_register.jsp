<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[실습]회원가입</title>
</head>
<body>

이름 : <%= request.getParameter("name") %><br>
아이디 : <%= request.getParameter("id") %><br>
비밀번호 : <%= request.getParameter("password") %><br>
전화번호 : <%= request.getParameter("phone") %><br> 
<% 
	String[] hobbies = request.getParameterValues("hobby");
	if(hobbies != null){
%>		
		취미 :
<%
		for(int i=0;i<hobbies.length;i++){
			if(i>0) out.print(",");
%>
			<%= hobbies[i] %>
<% 
		}
	}
%>		
<br>
자기소개 : <%= request.getParameter("content") %>
</body>
</html>