package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class MemberDAO {
	//싱글톤 패턴
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private MemberDAO() {}
	
	//회원 가입
	public void insertMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0; //시퀀스 번호 저장
		
		try{
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//auto commit 해제
			conn.setAutoCommit(false);
			
			//회원 번호(mem_num)생성 
			//-> "똑같은" 번호를 두 테이블에 넣어야 하므로 단순 nextval 메서드로는 해결 불가
			sql = "SELECT zmember_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
			sql = "INSERT INTO zmember(mem_num,id) VALUES(?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);//시퀀스 번호
			pstmt2.setString(2, member.getId());//아이디
			pstmt2.executeUpdate();
			
			sql = "INSERT INTO zmember_detail(mem_num,name,passwd,phone,"
					+ "email,zipcode,address1,address2) "
					+ "VALUES (?,?,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, num);
			pstmt3.setString(2, member.getName());
			pstmt3.setString(3, member.getPasswd());
			pstmt3.setString(4, member.getPhone());
			pstmt3.setString(5, member.getEmail());
			pstmt3.setString(6, member.getZipcode());
			pstmt3.setString(7, member.getAddress1());
			pstmt3.setString(8, member.getAddress2());
			pstmt3.executeUpdate();
			
			//SQL 실행시 모두 성공하면 commit
			conn.commit();
			
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면 rollback
			conn.rollback();
			
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt3, conn);
			DBUtil.executeClose(null, pstmt2, conn);
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	
	//ID 중복 체크 및 로그인 처리
	public MemberVO checkMember(String id)throws Exception{
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문
			//zmember와 zmember_detail 테이블을 조인할 때, 누락된 데이터가 보여야 id 중복체크 가능
			//mem_num을 이용하여 조인 후, id와 passwd비교  (LEFT OUTER JOIN) 그러지 않으면 탈퇴회원의 ID가 사용 가능함 
			sql = "SELECT * FROM zmember LEFT OUTER JOIN "
					+ "zmember_detail USING(mem_num) WHERE id=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, id);		
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setId(rs.getString("id"));
				member.setAuth(rs.getInt("auth"));
				member.setPasswd(rs.getString("passwd"));
				member.setPhoto(rs.getString("photo"));
				member.setEmail(rs.getString("email"));//회원탈퇴시 이용
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return member;
	}
	
	//회원상세 정보               조인 최소화를 위해 매개변수로 mem_num 사용
	public MemberVO getMember(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM zmember JOIN zmember_detail USING(mem_num) "
					+ "WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setId(rs.getString("id"));
				member.setAuth(rs.getInt("auth"));
				member.setName(rs.getString("name"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhoto(rs.getString("photo"));
				member.setReg_date(rs.getDate("reg_date"));//가입일
				member.setModify_date(rs.getDate("modify_date"));//수정일
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	
	//회원정보 수정
	public void updateMember(MemberVO member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE zmember_detail SET name=?,phone=?,email=?, "
					+ "zipcode=?,address1=?,address2=?,modify_date=SYSDATE "
					+ "WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getPhone());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getZipcode());
			pstmt.setString(5, member.getAddress1());
			pstmt.setString(6, member.getAddress2());
			pstmt.setInt(7, member.getMem_num());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
		
	//비밀번호 수정
	public void updatePassword(String passwd,int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE zmember_detail SET passwd=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, passwd);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//프로필 사진 수정
	public void updateMyPhoto(String photo,int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE zmember_detail SET photo=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, photo);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//회원탈퇴(회원정보 삭제)
	public void deleteMember(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//auto commit 해제
			conn.setAutoCommit(false);
			
			//zmember의 auth값 변경
			sql = "UPDATE zmember SET auth=0 WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.executeUpdate();
			
			//zmember_detail의 레코드 삭제
			sql = "DELETE FROM zmember_detail WHERE mem_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, mem_num);
			pstmt2.executeUpdate();
			
			//모든 SQL문의 실행이 성공하면 커밋 
			conn.commit();
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면 롤백
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, conn);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//관리자
	//전체 내용 개수, 검색 내용 개수
	public int getMemberCountByAdmin(String keyfield,String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = ""; //검색하기 위한 추가 sql문
		int count = 0;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE id LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE name LIKE '%' || ? || '%'";
				else if(keyfield.equals("3")) sub_sql += "WHERE email LIKE '%' || ? || '%'";
			}
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM zmember LEFT OUTER JOIN "
					+ "zmember_detail USING(mem_num) " + sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(1, keyword);
			}
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	//목록, 검색 목록 (sub_sql사용)
	public List<MemberVO> getListMemberByAdmin(int start,int end,
									String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt=0;
		
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE id LIKE '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE name LIKE '%' || ? || '%'";
				else if(keyfield.equals("3")) sub_sql += "WHERE email LIKE '%' || ? || '%'";
			}
			
			//SQL문 작성 - LEFT OUTER JOIN: 탈퇴회원을 불러오기 위함
			sql = "SELECT * FROM (SELECT a.*,rownum rnum FROM "
					+ "(SELECT * FROM zmember LEFT OUTER JOIN "
					+ "zmember_detail USING(mem_num) "+sub_sql+" ORDER BY mem_num DESC) a) "
					+ "WHERE rnum >= ? AND rnum <= ?" ;
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<MemberVO>();
			while(rs.next()) {
				MemberVO member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setId(rs.getString("id"));
				member.setAuth(rs.getInt("auth"));
				member.setName(rs.getString("name"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setReg_date(rs.getDate("reg_date"));
				
				list.add(member);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//회원등급 수정
	public void updateMemberByAdmin(int auth,int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE zmember SET auth=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, auth);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e); 
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
