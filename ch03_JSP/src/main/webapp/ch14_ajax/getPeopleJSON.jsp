<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="kr.util.DBUtil"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%-- 배열 형태 --%>
[<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	try{
		//Connection 객체 반환
		conn = DBUtil.getConnection();
		//SQL문 작성
		sql = "SELECT * FROM people ORDER BY reg_date DESC";
		//JDBC 수행 3단계 : PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);
		//JDBC 수행 4단계 : SQL문 실행
		rs = pstmt.executeQuery();
		while(rs.next()){
			String id = rs.getString("id");
			String name = rs.getString("name");
			String job = rs.getString("job");
			String address = rs.getString("address");
			String blood_type = rs.getString("blood_type");
			String reg_date = rs.getString("reg_date");
			
			if(rs.getRow()>1) out.println(",");
			%>
			<%-- js에서는 자바처럼 문자열 변수를 인식하지 못함(" "처리된 것만 인식) --%>
			{
				"id":"<%= id %>",
				"name":"<%= name %>",
				"job":"<%= job %>",
				"address":"<%= address %>",
				"blood_type":"<%= blood_type %>",
				"reg_date":"<%= reg_date %>"
			}
			<%
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		//자원 정리
		DBUtil.executeClose(rs, pstmt, conn);
	}
%>]