<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/style.css" type="text/css">
<title>주문 상세 정보 보기</title>
</head>
<body>
<div class="page-main">
	<h2>주문 상세 정보 보기</h2>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
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
			Date reg_date = rs.getDate("reg_date");
%>
			<ul>
				<li>주문 번호: <%= num %></li>
				<li>상품명: <%= name %></li>
				<li>금액: <%= String.format("%,d",price) %>원</li><!-- 정수형으로 표현하기 위함 -->
				<li>수량: <%= String.format("%,d",stock) %>개</li>
				<li>원산지: <%= origin %></li>
				<li>주문일: <%= reg_date %></li>
			</ul>	
			<hr width="100%" size="1" noshade="noshade">
			<div class="align-right">
				<input type="button" value="수정" onclick="location.href='updateTest.jsp?num=<%= num %>'">
				<input type="button" value="삭제" id="delete_btn">
				<input type="button" value="목록" onclick="location.href='selectTest.jsp'">
			</div>	
			<script type="text/javascript">
				window.onload = function(){
					const del = document.querySelector('input[value="삭제"]');
					del.onclick = function(){
						let choice = confirm('삭제하시겠습니까?');
			 			if(choice){
			 				location.replace('deleteTest.jsp?num=<%=num%>');
			 			}
			 		}
				};
			</script>
<%		
		}else{
%>
			<div class="result-display">
				요청된 주문 정보가 없습니다.<p>
				<input type="button" value="주문 목록" onclick="location.href='selectTest.jsp'">
			</div>
<%
		}
	}catch(Exception e){
%>
		<div class="result-display">
			오류가 발생했습니다.<p>
			<input type="button" value="주문 목록" onclick="location.href='selectTest.jsp'">
		</div>
<%		
		e.printStackTrace();
	}finally{
		DBUtil.executeClose(rs, pstmt, conn);
	}
%>		
</div>	
</body>
</html>