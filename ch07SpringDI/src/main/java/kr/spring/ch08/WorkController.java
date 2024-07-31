package kr.spring.ch08;

public class WorkController {
	//프로퍼티(=멤버 변수,필드)
	private long periodTime;
	private EmailSender email;
	
	public void setPeriodTime(long periodTime) {
		this.periodTime = periodTime;
	}
	public void setEmail(EmailSender email) {
		this.email = email;
	}
	
	@Override
	public String toString() {
		return "WorkController [periodTime=" + periodTime + ", email=" + email + "]";
	}
}
