package kr.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;
  
public class AdminModifyFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer) session.getAttribute("user_auth");
		if(user_auth!=9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//관리자로 로그인한 경우
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		
		OrderDAO dao = OrderDAO.getInstance();
		
		//주문정보 호출 -> get방식 데이터 전송을 받기 때문에 주소번호 조작 방지를 위해 주문자와 로그인한 사람 일치 여부 확인
		OrderVO order = dao.getOrder(order_num);
		
		request.setAttribute("order", order);
		
		return "/WEB-INF/views/order/admin_modifyForm.jsp";
	}

}
