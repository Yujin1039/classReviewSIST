package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");

		if(user_num == null) {//로그인 실패시
			return "redirect:/member/loginForm.do";
		}
		
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		//자바빈(VO)를 생성한 후 전송된 데이터 반환
		BoardVO board = new BoardVO();
		board.setTitle(request.getParameter("title"));
		board.setContent(request.getParameter("content"));
		board.setIp(request.getRemoteAddr());
		board.setFilename(FileUtil.createFile(request, "filename"));
		board.setMem_num(user_num);
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.insertBoard(board);
		
		request.setAttribute("notice_msg", "글쓰기 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/board/list.do");
		
		//JSP경로 반환
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
