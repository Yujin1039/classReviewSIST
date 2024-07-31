package kr.spring.ch09;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.spring.ch09.UploadController;

public class SpringMain {
	public static void main(String[] args) {
		//applicationContext2.xml 설정파일을 읽어들여 스프링 컨테이너를 생성
		AbstractApplicationContext context = 
				new ClassPathXmlApplicationContext("applicationContext2.xml");
		
		//DI 프로퍼티 설정방식 - 여러 개의 프로퍼티
		UploadController upload = (UploadController) context.getBean("upload");
		System.out.println(upload);
		
		context.close();
	}
}
