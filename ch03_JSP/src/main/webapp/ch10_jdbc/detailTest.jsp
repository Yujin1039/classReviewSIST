<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%-- java.util.Date -> DB와 상관없이 날짜정보를 처리하고 싶을 때 사용 --%>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세 정보 보기</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<h2>글 상세 정보</h2>
<%
	int num = Integer.parseInt(request.getParameter("num"));//Q.getParameter: form의 name, 쿼리스트링 값을 가져옴
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	try{
		//Connection 객체 반환
		conn = DBUtil.getConnection();
		//SQL문 작성
		sql = "SELECT * FROM tboard WHERE num=?";
		
		//JDBC 수행 3단계 : PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);
		//?에 데이터 바인딩
		pstmt.setInt(1,num);
		
		//JDBC 수행 4단계 : SQL문을 테이블에 반영하고 결과행을 ResultSet에 담아서 반환
		rs = pstmt.executeQuery();
		if(rs.next()){
			String name = rs.getString("name");
			String title = rs.getString("title");
			String content = rs.getString("content");
			Date reg_date = rs.getDate("reg_date");
%>
			<ul>
				<li>글 번호 : <%= num %></li>
				<li>제목 : <%= title %></li>
				<li>작성자 : <%= name %></li>
				<li>작성일 : <%= reg_date %></li>
			</ul>
			<hr width="100%" size="1" noshade="noshade">
			<p>
				<%= content %>
			</p>
			<hr width="100%" size="1" noshade="noshade">
			<div class="align-right">
				<input type="button" value="수정" 
					   onclick="location.href='updateTestForm.jsp?num=<%=num%>'">
				<input type="button" value="삭제" 
					   onclick="location.href='deleteTestForm.jsp?num=<%=num%>'">
				<input type="button" value="목록"
					   onclick="location.href='selectTest.jsp'">
			</div>			
<%
		}else{//주소의 num 번호를 조작하는 경우
%>
			<div class="result-display">
				<div class="align-center">
					글 상세 정보가 없습니다.<p>
					<input type="button" value="목록" onclick="location.href='selectTest.jsp'">
				</div>
			</div>
<%
		}
	}catch(Exception e){//오류발생시 빈 화면이 나오지 않도록 함
%>
		<div class="result-display">
			<div class="align-center">
				오류 발생! 글 상세 정보 호출 실패<p>
				<input type="button" value="목록" onclick="location.href='selectTest.jsp'">
			</div>
		</div>
<% 
		e.printStackTrace();
	}finally{
		//자원 정리
		DBUtil.executeClose(rs, pstmt, conn);
	}
%>	
</div>
</body>
</html>