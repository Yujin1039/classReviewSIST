package kr.board.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardFavVO;
import kr.controller.Action;

public class GetFavAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		//전송된 데이터 반환
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
			      //string,integer를 모두 value로 받으므로
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");				
		BoardDAO dao = BoardDAO.getInstance();
		if(user_num==null) {//로그인이 되지 않은 경우
			mapAjax.put("status", "noFav");
		}else {//로그인이 된 경우
			BoardFavVO boardFav = dao.selectFav(new BoardFavVO(board_num,user_num));			
			if(boardFav!=null) {//로그인한 회원이 좋아요를 클릭한 경우
				mapAjax.put("status","yesFav");
			}else {
				//로그인한 회원이 좋아요를 미클릭
				mapAjax.put("status", "noFav");
			}
		}
		
		//좋아요 개수
		mapAjax.put("count", dao.selectFavCount(board_num));
		
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
