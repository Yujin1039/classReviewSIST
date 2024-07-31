package kr.item.action;

import java.util.List;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.PagingUtil;

public class UserListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = 
				(Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
				
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		ItemDAO dao = ItemDAO.getInstance();
		//status가 1이면 표시(2)인 상품만 개수 반환
		int count = dao.getItemCount(keyfield,keyword,1);
		
		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,
						Integer.parseInt(pageNum),count,20,10,"itemList.do");
		
		List<ItemVO> list = null;
		if(count > 0) {
			list = dao.getListItem(page.getStartRow(), 
					               page.getEndRow(), 
					               keyfield, keyword, 0);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/item/user_list.jsp";
	}

}