package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;

public class ModifyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//자바빈(VO) 생성
		BoardVO boardVO = new BoardVO();
		//자바빈에 내용 넣어주기
		boardVO.setNum(Integer.parseInt(request.getParameter("num")));
		boardVO.setTitle(request.getParameter("title"));
		boardVO.setName(request.getParameter("name"));
		boardVO.setPasswd(request.getParameter("passwd"));
		boardVO.setEmail(request.getParameter("email"));
		boardVO.setContent(request.getParameter("content"));
		boardVO.setIp(request.getRemoteAddr());
		
		//DAO 객체 생성 - 수정 메서드 실행
		BoardDAO dao = BoardDAO.getInstance();
		
		//비밀번호 인증을 위해 한 건의 자바빈(VO)에 담아서 반환
		BoardVO db_board = dao.getBoard(boardVO.getNum());
		boolean check = false;
		if(db_board != null) {
			//비밀번호 일치 여부 체크
			check = db_board.isCheckedPassword(boardVO.getPasswd());
		}
		if(check) {//비밀번호 일치
			dao.update(boardVO);//글 수정
			//상세페이지로 이동하기 위해 글 번호 저장
			request.setAttribute("num", boardVO.getNum());
		}
		
		//check값에 따라 다른 UI를 만들기 위해 request에 attribute 설정
		request.setAttribute("check", check);
		
		//JSP 경로 반환
		return "/WEB-INF/views/modify.jsp";
	}

}
