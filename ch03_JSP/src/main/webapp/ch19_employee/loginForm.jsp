<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#login_form').submit(function(){
		if($('#id').val().trim() == ''){
			alert('아이디를 입력하세요!');
			$('#id').val('').focus();
			return false;
		}
		if($('#passwd').val().trim() == ''){
			alert('비밀번호를 입력하세요!');
			$('#passwd').val('').focus();
			return false;
		}
	});
});
</script>
</head>
<body>
<div class="page-main">
	<h1>로그인</h1>
	<form action="login.jsp" method="post" id="login_form">
		<ul>
			<li>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id">
			</li>
			<li>
				<label for="passwd">비밀번호</label>
				<input type="password" name="passwd" id="passwd">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="로그인">
			<button type="button" onclick="location.href='main.jsp'">홈으로</button>
		</div>
	</form>
</div>
</body>
</html>