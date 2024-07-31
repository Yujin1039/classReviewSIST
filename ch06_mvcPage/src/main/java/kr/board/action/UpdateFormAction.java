package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class UpdateFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");

		if(user_num == null) {//로그인 실패시
			return "redirect:/member/loginForm.do";
		}
		
		//로그인 된 경우
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardVO board = dao.getBoard(board_num);
		
		//로그인한 아이디와 글 작성자가 일치하는지 확인
		if(user_num!=board.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//큰 따옴표 처리
		//수정폼의 input 태그에서 큰 따옴표 오류 보정
		board.setTitle(StringUtil.parseQuot(board.getTitle()));
		
		//로그인이 되어있고 로그인한 회원번호와 작성자 회원번호가 일치
		request.setAttribute("board", board);
		
		//JSP 경로 반환
		return "/WEB-INF/views/board/updateForm.jsp";
	}

}
