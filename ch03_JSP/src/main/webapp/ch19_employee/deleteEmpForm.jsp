<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Integer emp_num = (Integer) session.getAttribute("emp_num");
	if(emp_num == null){
		response.sendRedirect("loginForm.jsp");
	}else{
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원탈퇴</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#delete_form').submit(function(){
		if($('#id').val().trim() == ''){
			alert('아이디를 입력하세요.');
			$('#id').val('').focus();
			return false;
		}
		if($('#passwd').val().trim() == ''){
			alert('비밀번호를 입력하세요.');
			$('#passwd').val('').focus();
			return false;
		}
		if($('#pw').val().trim() == ''){
			alert('비밀번호 확인을 입력하세요.');
			$('#pw').val('').focus();
			return false;
		}
		
		if($('#passwd').val() != $('#pw').val()){
			alert('비밀번호와 비밀번호 확인이 불일치합니다.');
			$('#passwd').val('');
			$('#pw').val('').focus();
			return false;
		}
	});
});
</script>
</head>
<body>
<div class="page-main">
	<h1>사원탈퇴</h1>
	<form id="delete_form" action="deleteEmp.jsp" method="post">
		<ul>
			<li>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id" maxlength="12">
			</li>
			<li>
				<label for="passwd">비밀번호</label>
				<input type="password" name="passwd" id="passwd" maxlength="12">
			</li>
			<li>
				<label for="pw">비밀번호 확인</label>
				<input type="password" id="pw" maxlength="12">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="탈퇴">
			<input type="button" value="홈으로" onclick="location.href='main.jsp'">
		</div>
	</form>
</div>
</body>
</html>
<%		
	}
%>
