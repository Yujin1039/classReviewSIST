<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.util.DBUtil" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 수정</title>
<link rel="stylesheet" href="../css/style.css" style="text/css">
</head>
<body>
<%
	int num = Integer.parseInt(request.getParameter("num")); 
	Connection conn = null; 
	PreparedStatement pstmt = null; 
	ResultSet rs = null; String sql = ""; 
	try{ 
		conn = DBUtil.getConnection(); 
		sql = "SELECT * FROM product WHERE num=?"; 
		pstmt = conn.prepareStatement(sql); 
		pstmt.setInt(1,num); 
		rs = pstmt.executeQuery(); 
		if(rs.next()){ 
			String name = rs.getString("name"); 
			int price = rs.getInt("price"); 
			int stock = rs.getInt("stock"); 
			String origin = rs.getString("origin"); 
%>
			<form action="updateTest.jsp" method="post">
				<input type="hidden" value="<%= num %>" name="num">
				<ul>
					<li>
						<label for="name">상품명</label>
						<input type="text" value="<%= name %>" id="name" name="name">
					</li>
					<li>
						<label for="price">금액</label>
						<input type="text" value="<%= price %>" id="price" name="price">
					</li>
					<li>
						<label for="stock">수량</label>
						<input type="text" value="<%= stock %>" id="stock" name="stock">
					</li>
					<li>
						<label for="origin">원산지</label>
						<input type="text" value="<%= origin %>" id="origin" name="origin">
					</li>
				</ul>
				<input type="submit" value="전송" onclick="loaction.href='updateTest.jsp'">
				<input type="submit" value="주문 목록" onclick="loaction.href='selectTest.jsp'">
			</form>
<%
		}
	}catch(Exception e){ 
%>
		<div class="result-display">
			<div class="align-center">
			</div>
		</div>
<%		
		e.printStackTrace();
	}finally{ 
		DBUtil.executeClose(rs, pstmt, conn); 
	} 
%>
</body>
</html>