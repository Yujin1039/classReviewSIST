package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;

public class UserOrderFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		if(user_num == null) {//로그인 실패시
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//POST방식의 접근만 허용(GET 방식 정보 전송 불허)
		if(request.getMethod().toUpperCase().equals("GET")) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		CartDAO dao = CartDAO.getInstance();
		int all_total = dao.getTotalByMem_num(user_num);
		if(all_total<=0) {//구매창에서 강제로 이전 페이지로 돌아가서 다시 구매하는 경우
			request.setAttribute("notice_msg", "정상적인 주문이 아니거나 상품의 수량이 부족합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/item/itemList.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		//장바구니에 담겨있는 상품 정보 호출
		List<CartVO> cartList = dao.getListCart(user_num);
		ItemDAO itemDAO = ItemDAO.getInstance();
		for(CartVO cart: cartList) {
			ItemVO item = itemDAO.getItem(cart.getItem_num());
			if(item.getStatus()==1) {//상품 미표시			
				request.setAttribute("notice_msg", "["+item.getName()+"]상품 판매 중지");
				request.setAttribute("notice_url", request.getContextPath()+"/cart/list.do");
				return "/WEB-INF/views/common/alert_view.jsp";
			}
			if(item.getQuantity() < cart.getOrder_quantity()) {//상품 재고 수량 부족
				request.setAttribute("notice_msg", "["+item.getName()+"]재고수량 부족으로 주문 불가");
				request.setAttribute("notice_url", request.getContextPath()+"/cart/list.do");
				return "/WEB-INF/views/common/alert_view.jsp";
			}
		}
		
		request.setAttribute("list", cartList);
		request.setAttribute("all_total", all_total);
		
		return "/WEB-INF/views/order/user_orderForm.jsp";
	}

}
