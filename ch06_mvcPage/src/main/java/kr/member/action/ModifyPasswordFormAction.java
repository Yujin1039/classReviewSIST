package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class ModifyPasswordFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		if(user_num == null) {//로그인이 안된 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인 된 경우
		return "/WEB-INF/views/member/modifyPasswordForm.jsp";
	}

}
