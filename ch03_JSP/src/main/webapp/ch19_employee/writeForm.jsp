<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 쓰기</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<script type="text/javascript">
window.onload = function(){
	const write_form = document.getElementById('write_form');
	write_form.onsubmit = function(){
		const items = document.querySelectorAll('.input_check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim() == ''){
				const label = document.querySelector('label[for="'+items[i].id+'"]')
				alert(label.textContent+' 항목 필수 입력!');
				items[i].value = '';
				items[i].focus();
				return false;
			}
		}
	};
};
</script>
</head>
<body>
<div class="page-main">
	<h1>글 쓰기</h1>
	<form id="write_form" action="write.jsp" method="post">
		<ul>
			<li>
				<label for="title">제목</label>
				<input type="text" name="title" id="title" class="input_check">
			</li>
			<li>
				<label for="content">내용</label>
				<textarea rows="5" cols="40" name="content" id="content" class="input_check"></textarea>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="글 등록">
		</div>		
	</form>
</div>
</body>
</html>