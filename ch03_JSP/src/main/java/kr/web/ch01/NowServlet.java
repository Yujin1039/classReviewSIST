package kr.web.ch01;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/now")
public class NowServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException,IOException{
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
		
		//문서 타입 및 캐릭터셋 지정
		response.setContentType("text/html;charset=utf-8");
		
		//HTML 출력을 위한 출력 스트림 생성
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>현재 날짜와 시간</title></head>");
		out.println("<body>");
		out.println("현재 날짜와 시간: "+sf.format(now));//내부 변수나 메서드는 ""에 넣지 않는다.
		out.println("</body>");
		out.println("</html>");
		
		//자원 정리
		out.close();
	}
}
