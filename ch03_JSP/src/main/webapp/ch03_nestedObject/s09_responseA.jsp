<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>s10_responseB.jsp</title>
</head>
<body>
현재 페이지는 s09_responseA.jsp 입니다.
화면에 보이지지 않습니다.
</body> 
-->
<%
	response.sendRedirect("s10_responseB.jsp");
%>