<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 삭제 처리</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<body>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "";
	
	try{
		
	}catch(Exception e){
		
	}finally{
		DBUtil.executeClose(null, pstmt, conn);
	}
%>	
</body>
</html>
