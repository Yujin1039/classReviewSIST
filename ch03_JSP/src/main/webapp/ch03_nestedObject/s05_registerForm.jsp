<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[실습]회원가입</title>
<script type="text/javascript">
window.onload = function(){
	const myForm = document.getElementById('myForm');
	myForm.onsubmit = function(){
		const items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				const label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent + '항목은 필수 입력');
				items[i].value = '';
				items[i].focus();
				return false;
			}
			if(items[i].id == 'id' && 
					!/^[A-Za-z0-9]{4,12}$/.test(items[i].value)){
				alert('영문 또는 숫자 사용, 최소 4자 ~ 최대 10자 사용');
				items[i].value = '';
				items[i].focus();
				return false;
			}
		}
	};
};

	/*
	window.onload = function(){
		const myForm = document.getElementById('myForm');
		myForm.onsubmit = function(){
			const name = document.getElementById('name');
			const id = document.getElementById('id');
			const password = document.getElementById('password');
			if(!check(name)||!check(id)||!check(password)){
				return false;
			}
		};
		function check(values){
			if(values.value.trim() == ''){
				let lab = document.querySelector('label[for="'+values.id+'"]');
				alert(lab.textContent+' 필수 입력');
				values.value = '';
				values.focus();
				return false;
			}
		}
		
	};
	*/
</script>
</head>
<body>
<%-- 
이름(name),아이디(id),비밀번호(password),전화번호(phone), [전부 text]
취미(hobby) - 영화보기, 음악감상, 등산, 낚시, 춤 [checkbox]
자기소개(content) [textarea]

s06_register.jsp로 전송하고 전송방식은 post

조건체크 - 필수입력(원하는 항목) 유효성 체크

출력예시
이름 : 홍길동             * 필수 입력
아이디 : dragon         *
비밀번호 : 1234          *
전화번호 : 010-1234-5678
취미 : 
자기소개 : 서울에서 태어나서 계속 서울 거주

--%>
<form action="s06_register.jsp" method="post" id="myForm">
	<label for="name">이름</label> 
	<input type="text" name="name" id="name" class="input-check"><br>
	<label for="id">아이디</label> 
	<input type="text" name="id" id="id" class="input-check"><br>
	<label for="password">비밀번호 </label>
	<input type="password" name="password" id="password" class="input-check"><br>
	<label for="phone">전화번호</label> 
	<input type="text" name="phone" id="phone"><br>
	취미
	<input type="checkbox" name="hobby" value="movie">영화보기
	<input type="checkbox" name="hobby" value="music">음악감상
	<input type="checkbox" name="hobby" value="mount">등산
	<input type="checkbox" name="hobby" value="fishing">낚시
	<input type="checkbox" name="hobby" value="dance">춤<br>
	자기소개<br> <textarea rows="5" cols="70" name="content"></textarea><br>
	<input type="submit" value="전송">
</form>
</body>
</html>