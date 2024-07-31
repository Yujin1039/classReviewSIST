package kr.spring.ch10.controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DownloadController {
	@RequestMapping("/file.do")
	public ModelAndView download(HttpSession session) {
		//file.txt의 컨텍스트 경로 상의 절대 경로를 구하기
		// -> 직접적인 절대 경로 접근 가능 여부가 제각기 다르므로 servlet Context 경로 정보를 담고 있는 session을 매개변수로 사용
		String path = session.getServletContext().getRealPath("/WEB-INF/file.txt");
		File downloadFile = new File(path);
		//view이름: 데이터를 전달할 view의 이름 생성, 속성값:view로 전달될 데이터 객체
		//                       view이름    model이름(속성명)  model객체(속성값)
		return new ModelAndView("download","downloadFile",downloadFile);
	}
}
