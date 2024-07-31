package kr.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

public class FileUtil {
	//업로드 상대경로
	private static final String UPLOAD_PATH = "/upload";
	
	//파일 생성                        파일 경로를 알아내기 위함           input태그의 name파라미터
	public static String createFile(HttpServletRequest request,String param) 
									throws IllegalStateException, IOException, ServletException{
		//업로드 절대 경로
		String upload = request.getServletContext().getRealPath(UPLOAD_PATH);
		//파일 정보 얻기
		Part part = request.getPart(param);
		//파일명 구하기
		String filename = part.getSubmittedFileName();
		//filename!=null -> part객체를 사용하여 filename반환시 항상 null이 아님(파일이 업로드되지 않으면 빈 문자열을 반환)
		if(!filename.isEmpty()) {
			//파일 중복 방지를 위해 "임의의 값_원래 파일명" 형식으로 변경
			//         -> 길이가 긴 유니크한 id를 랜덤으로 생성
			// indexOf("_")를 이용하여 실제 filename을 분리할 수 있음
			filename = UUID.randomUUID()+"_"+filename;
			part.write(upload+"/"+filename);
		}
		return filename;
	}
	
	//파일 삭제 - update시에도 사용
	public static void removeFile(HttpServletRequest request, String filename) {
		if(filename!=null) {//filename이 비어있는 경우 삭제 불가
			//업로드 절대경로
			String upload = request.getServletContext().getRealPath(UPLOAD_PATH);
			File file = new File(upload+"/"+filename);
			if(file.exists()) file.delete();
		}
	}
}
