package kr.spring.ch01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

//모델클래스로 인식하기 위해 어노테이션 작성
@Controller
public class HelloController {
	//요청URL과 실행 메서드 연결
	@RequestMapping("/hello.do")//요청URL
	public ModelAndView hello() {//실행 메서드 -> 기존 MVC: Action인터페이스에 execute 메서드만 생성
		//servlet-context.xml파일이 controller임을 인식함
		ModelAndView mav = new ModelAndView();
		//뷰 이름 지정
		mav.setViewName("hello");// viewResolver에서 "/WEB-INF/views/hello.jsp"로 경로 지정
		//뷰에서 사용할 데이터 세팅 -> request에 저장됨
		mav.addObject("greeting","안녕하세요!");
		
		return mav;
	}
}
