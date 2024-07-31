package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");

		if(user_num == null) {//로그인 실패시
			return "redirect:/member/loginForm.do";
		}
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardVO db_board = dao.getBoard(board_num);
		
		//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
		if(user_num!=db_board.getMem_num()) {			
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//로그인한 회원번호와 작성자 회원번호 일치
		dao.deleteBoard(board_num);
		//파일 삭제
		FileUtil.removeFile(request, db_board.getFilename());
		
		request.setAttribute("notice_msg", "글 삭제 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/board/list.do");
		
		//JSP 경로 반환
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
