package kr.spring.ch04;

public class WriteArticleService {
	private WriteArticleDAO writeArticleDAO;
	
	//생성자
	public WriteArticleService(WriteArticleDAO writeArticleDAO) {
		super();//있든 없든 상관 없음
		this.writeArticleDAO = writeArticleDAO;
	}
	
	public void write() {
		System.out.println("WriteArticleService의 write()메서드 호출");
		writeArticleDAO.insert();
	}	
}
