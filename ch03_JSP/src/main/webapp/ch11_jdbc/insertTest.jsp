<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 처리</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	int price = Integer.parseInt(request.getParameter("price"));
	int stock = Integer.parseInt(request.getParameter("stock")); 
	String origin = request.getParameter("origin");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "";
	
	try{
		//Connection 객체에 연결하기
		conn = DBUtil.getConnection();
		//SQL문 작성
		sql = "INSERT INTO product(num,name,price,stock,origin,reg_date) VALUES (product_seq.nextval,?,?,?,?,SYSDATE)";
		
		//JDBC 수행 3단계 : PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);
		//?에 데이터 바인딩
		pstmt.setString(1, name);
		pstmt.setInt(2, price);
		pstmt.setInt(3, stock);
		pstmt.setString(4, origin);
		
		//JDBC 수행 4단계 : SQL문 실행
		pstmt.executeUpdate();
		
%>
		<div class="result-display">
			주문이 성공적으로 완료되었습니다.<p>
			<div class="align-center">
				<input type="button" value="주문 목록" onclick="location.href='selectTest.jsp">
			</div>
		</div>
<%		
	}catch(Exception e){
		e.printStackTrace();
%>
		<div class="result-display">
			오류 발생! 주문이 실패했습니다.
			<div class="align-center">
				<input type="button" value="주문 등록" onclick="location.href='insertTest.jsp">
			</div>
		</div>
<%		
	}finally{
		DBUtil.executeClose(null, pstmt, conn);
	}
%>
</body>
</html>