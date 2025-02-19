package kr.web.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//request에 데이터 저장
		request.setAttribute("delete", "글 삭제가 완료되었습니다.");
		//JSP 경로 반환
		return "/views/delete.jsp";
	}

}
