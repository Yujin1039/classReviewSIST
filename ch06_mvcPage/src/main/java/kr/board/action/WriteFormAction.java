package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class WriteFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		if(user_num == null) {//로그인 실패시
			return "redirect:/member/loginForm.do";
		}
		
		//로그인 된 경우
		return "/WEB-INF/views/board/writeForm.jsp";
	}

}
