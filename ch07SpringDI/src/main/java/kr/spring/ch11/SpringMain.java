package kr.spring.ch11;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringMain {
	public static void main(String[] args) {
		//스프링 컨테이너 생성
		AbstractApplicationContext context = 
				new ClassPathXmlApplicationContext("applicationContext2.xml");
		
		//DI -Map 타입 프로퍼티 설정
		ProtocolHandlerFactory phf = 
				(ProtocolHandlerFactory)context.getBean("protocolHandlerFactory");
		System.out.println(phf);
		
		context.close();
	}
}
