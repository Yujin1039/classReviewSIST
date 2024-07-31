package kr.util;

import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBUtil {
	
	//Connection 객체를 생성해서 반환
	public static Connection getConnection() throws Exception{
		/*
		//JDBC 수행 1단계 : 드라이버 로드 
		Class.forName(DB_DRIVER); 
		//JDBC 수행 2단계 : Connection 객체 생성 -> 매번 생성시 부하가 발생하여 속도이슈 
		return DriverManager.getConnection(DB_URL,DB_ID,DB_PASSWORD);
		*/
		Context initCtx = new InitialContext();
		DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/xe");
		return ds.getConnection();
	}
	//자원 정리
	public static void executeClose(ResultSet rs, PreparedStatement pstmt,Connection conn) {
		if(rs!=null)try {rs.close();}catch(SQLException e) {}
		if(pstmt!=null)try {pstmt.close();}catch(SQLException e) {}
		if(conn!=null)try {conn.close();}catch(SQLException e) {}
	}
}
