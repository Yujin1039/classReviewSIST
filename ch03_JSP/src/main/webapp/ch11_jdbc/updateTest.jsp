<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 수정 처리</title>
<link rel="stylesheet" href="../css/style.css" style="text/css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	int price = Integer.parseInt(request.getParameter("price"));
	int stock = Integer.parseInt(request.getParameter("stock"));
	String origin = request.getParameter("origin");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "";
	
	try{
		conn = DBUtil.getConnection();
		sql = "UPDATE product SET name=?,price=?,stock=?,origin=? WHERE num=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setInt(2,price);
		pstmt.setInt(3, price);
		pstmt.setString(4, origin);		
		pstmt.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBUtil.executeClose(null, pstmt, conn);
	}
%>
</body>
</html>