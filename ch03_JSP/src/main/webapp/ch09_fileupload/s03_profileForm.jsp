<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 사진 업로드 폼</title>
<script type="text/javascript">
	window.onload = function(){
		//미리 보기 이미지 호출
		const image = document.getElementById('image');
		//전송 버튼 호출
		let submit = document.getElementById('submit_btn');
		
		//파일 선택시 이벤트 연결
		const file = document.getElementById('file');
		file.onchange = function(){
			if(!file.files[0]){//선택한 이미지가 없는 경우
				image.src = '../images/face.png';//기본 이미지로 지정
				submit_btn.style.display = 'none';//전송 버튼이 안 보이게
				return;//이벤트 제거
			}
			//선택한 이미지 읽기
			const reader = new FileReader();
			reader.readAsDataURL(file.files[0]);
			
			reader.onload = function(){
				image.src = reader.result;
				submit_btn.style.display = '';
			};
		};
	};
</script>
</head>
<body>
<h2>프로필 사진 업로드하기</h2>
<img src="../images/face.png" id="image" width="200" height="200">
<form action="/ch03_JSP/profile" method="post" enctype="multipart/form-data">
                                                          <!-- 허용 파일 형식 -->
	<input type="file" name="file" id="file" accept="image/png,image/jpeg,image/gif">
	<input type="submit" value="전송" id="submit_btn" style="display:none;">	
</form>
</body>
</html>