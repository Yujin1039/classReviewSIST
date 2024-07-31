package kr.spring.ch10.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView{
	
	public DownloadView() {
		//             application의 범주에서 download 처리, 인코딩 타입 지정
		setContentType("application/download;charset=utf-8");
	}
	
	//model을 map형태(속성명,속성값)로 가져옴
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//다운로드 하는 파일의 경로 정보가 저장된 File 객체 반환
		File file = (File) model.get("downloadFile");
		
		//컨텐츠 타입 지정
		response.setContentType(getContentType());
		//컨텐츠의 용량 지정
		response.setContentLength((int)file.length());
		//파일명 구하기
		String fileName = new String(file.getName().getBytes("utf-8"),"iso-8859-1");
		
		//HTTP 응답 메시지 헤더 셋팅
		response.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		//파일 쓰기
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);//파일 읽기
			//읽어온 데이터를 outputStream 객체에 전송(읽은 정보(=fis)를 쓰기 정보(=out)로 변환)
			FileCopyUtils.copy(fis, out); 
			//catch문 미작성 -> 메서드 자체에 throws Exception이 있으므로 갈음
		}finally {
			if(fis!=null) try {fis.close();}catch(IOException e) {}
		}
		out.flush();//파일 전송
	}

}
