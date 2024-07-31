package kr.web.ch03;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/score")
public class ScoreServlet extends HttpServlet{
	@Override
	public void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException,IOException{
		//성적 처리
		//국어,영어,수학,총점,평균,등급 출력
		
		response.setContentType("text/html;charset=utf-8");
		
		request.setCharacterEncoding("utf-8");
		
		int korean = Integer.parseInt(request.getParameter("korean"));
		int english = Integer.parseInt(request.getParameter("english"));
		int math = Integer.parseInt(request.getParameter("math"));
		int sum = korean+english+math;
		double avg = sum/3.0;
		String grade;
		if(avg>=90) {
			grade = "A";
		}else if(avg>=80) {
			grade = "B";
		}else if(avg>=70) {
			grade = "C";
		}else if(avg>=60) {
			grade = "D";
		}else {grade = "F";}
		
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>성적 처리</title></head>");
		out.println("<body>");
		out.println("국어 성적 : "+korean+"<br>");
		out.println("영어 성적 : "+english+"<br>");
		out.println("수학 성적 : "+math+"<br>");
		out.println("총점 : "+sum+"<br>");
		out.println("평균 : "+avg);
		out.println("등급 : "+grade);
		out.println("</body>");
		out.println("</html>");
		out.close();
	}
}
