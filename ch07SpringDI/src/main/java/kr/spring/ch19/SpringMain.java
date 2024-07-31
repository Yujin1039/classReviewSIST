package kr.spring.ch19;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringMain {
	public static void main(String[] args) {
		//스프링 컨테이너 생성
		AbstractApplicationContext context =
				new ClassPathXmlApplicationContext("applicationContextScan.xml");
		
		//@Component 어노테이션을 이용한 빈 객체 생성
		HomeController home = (HomeController)context.getBean("home");
		System.out.println(home);
		
		context.close();
	}
}
