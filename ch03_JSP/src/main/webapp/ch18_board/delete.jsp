<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.board.dao.BoardDAO" %>
<%@ page import="kr.board.vo.BoardVO" %>
<%
	//전송된 데이터 인코딩 타입 지정
	request.setCharacterEncoding("utf-8");
	//전송된 데이터 반환
	int num = Integer.parseInt(request.getParameter("num"));
	String passwd = request.getParameter("passwd");
	
	BoardDAO dao = BoardDAO.getInstance();
	//비밀번호 인증을 위해 기본키를 전달해서 한 건의 레코드를 전달받음
	BoardVO db_board = dao.getBoard(num);
	boolean check = false;
	if(db_board!=null){
		//비밀번호 체크
		check = db_board.isCheckedPassword(passwd);
	}
	if(check){//인증 성공
		dao.delete(num);//글 삭제
%>
		<script>
			alert('글 삭제를 완료했습니다.');
			location.replace('list.jsp');//기존 정보를 지우고 명시한 페이지로 돌아감 
		</script>
<%
	}else{//인증 실패
%>
		<script>
			alert('비밀번호 불일치');
			history.go(-1);
		</script>
<%		
	}
%>