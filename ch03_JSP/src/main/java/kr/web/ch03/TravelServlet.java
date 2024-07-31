package kr.web.ch03;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/travel")
public class TravelServlet extends HttpServlet{
	@Override
	public void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException,IOException{
		//여행지 출력시 출력형식
		//서울,뉴욕,파리
		
		//문서 타입 및 캐릭터셋 지정
		response.setContentType("text/html;charset=utf-8");
		
		//POST방식으로 전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		String name = request.getParameter("name");
		
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>선택한 여행지</title></head>");
		out.println("<body>");
		out.println("<h3>여행지 선택</h3>");
		out.println("여행자 : "+name+"<br>");
		String[] values = request.getParameterValues("city");
		if(values != null) {
			for(int i=0;i<values.length;i++) {
				out.print(values[i]);//print든 println이든 html문서 상에서는 <br>이 없으면 줄바꿈 불가
				if(i != values.length-1) {
					out.print(",");
				}
			}
		}else {
			out.println("선택한 여행지가 없습니다.");
		}
		
		out.println("</body>");
		out.println("</html>");
		out.close();
	}
}
