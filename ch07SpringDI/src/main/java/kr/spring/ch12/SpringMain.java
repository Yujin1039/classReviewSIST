package kr.spring.ch12;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringMain {
	public static void main(String[] args) {
		//스프링 컨테이너를 생성
		AbstractApplicationContext context = 
				new ClassPathXmlApplicationContext("applicationContext2.xml");
		
		//DI - Properties 타입 프로퍼티 설정
		BookClient book = (BookClient)context.getBean("bookClient");
		System.out.println(book);
		
		context.close();
	}
}
