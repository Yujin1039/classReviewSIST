<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload = function(){
	const myForm = document.getElementById('write_form');
	//이벤트 연결
	myForm.onsubmit = function(){
		const title = document.getElementById('title');
		if(title.value.trim()==''){
			alert('제목을 입력하세요!');
			title.value = '';
			title.focus();
			return false;
		}
		const content = document.getElementById('content');
		if(content.value.trim()==''){
			alert('내용을 입력하세요!');
			content.value = '';
			content.focus();
			return false;
		}
	};
};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>글쓰기</h2>
		<form action="write.do" method="post" enctype="multipart/form-data" id="write_form">
			<ul>
				<li>
					<label for="title">제목</label>
					<input type="text" name="title" id="title" maxlength="50">
				</li>
				<li>
					<label for="content">내용</label>
					<textarea rows="5" cols="40" name="content" id="content"></textarea>
				</li>
				<li>
					<label for="filename">이미지</label>
					<input type="file" name="filename" id="filename" 
						accept="image/gif,image/png,image/jpeg">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>