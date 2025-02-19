package kr.web.ch02;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/gugudan")
public class GugudanServlet extends HttpServlet{
	@Override
	public void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException,IOException{
		//문서 타입 및 캐릭터셋 지정
		response.setContentType("text/html;charset=utf-8");
		
		//전송된 데이터 반환: int형으로 변환 <- 항상 string으로 값 반환
		int dan = Integer.parseInt(request.getParameter("dan"));
		
		//HTML 출력을 위한 출력 스트림 생성
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>구구단</title></head>");
		out.println("<body>");
		out.println(dan + "단<br>");
		out.println("-------------------<br>");
		
		for(int i=1;i<=9;i++) {
			out.println(dan+" * "+i+" = "+ dan*i + "<br>");
		}
		
		out.println("</body>");
		out.println("</html>");
		
		out.close();
	}
}
