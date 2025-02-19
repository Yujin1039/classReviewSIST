<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('modify_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const radio = document.querySelectorAll(
				              'input[type=radio]:checked');
		if(radio.length < 1){
			alert('상품표시여부를 지정하세요!');
			return false;
		}
		
		const items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				const label = document.querySelector(
						       'label[for="'+items[i].id+'"]');
				alert(label.textContent + ' 항목은 필수 입력');
				items[i].value = '';
				items[i].focus();
				return false;
			}
		}
	};
	
	//이미지 미리보기
	$('#photo1,#photo2').change(function(){
		let my_photo = this.files[0]; //input[type="file"]태그
		let $item_photo = $(this).parent().find('.my-photo'); //img태그
		
		//input[type="file"]태그 클릭 후 사진을 미선택했을 때
		if(!my_photo){
			$item_photo.attr('src','${pageContext.request.contextPath}/upload/'+$item_photo.attr('data-img'));
			return;
		}
		
		//업로드 파일 사이즈 제한
		if(my_photo.size > 1024*1024){
			alert(Math.round(my_photo.size/1024)+'kbytes(1024kbytes까지만 업로드 가능)');
			$item_photo.attr('src','${pageContext.request.contextPath}/upload/'+$item_photo.attr('data-img'));
			$(this).val('');
			return;
		}
		
		
		//이미지를 선택했을 때
		const reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload = function(){
			$item_photo.attr('src',reader.result);
		};
	});
};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>상품 수정</h2>
		<form id="modify_form" action="adminWrite.do" method="post"
		                     enctype="multipart/form-data">
			<ul>
				<li>
					<label>상품표시여부</label>
					<input type="radio" name="status" value="1" id="status1"
						<c:if test="${item.status == 1}">checked</c:if>>미표시
					<input type="radio" name="status" value="2" id="status2"
						<c:if test="${item.status == 2}">checked</c:if>>표시                             
				</li>
				<li>
					<label for="name">상품명</label>
					<input type="text" name="name" id="name" value="${item.name}"
					                maxlength="10" class="input-check">
				</li>
				<li>
					<label for="price">가격</label>
					<input type="number" name="price" id="price" value="${item.price}"
					   min="1" max="999999999" class="input-check">
				</li>
				<li>
					<label for="quantity">수량</label>
					<input type="number" name="quantity" id="quantity" value="${item.quantity}"
					   min="0" max="9999999" class="input-check">
				</li>
				<li>
					<label for="photo1">상품사진1</label>
					<img src="${pageContext.request.contextPath}/upload/${item.photo1}"
						data-img="${item.photo1}" width="50" height="50" class="my-photo"/>
					<br>
					<input type="file" name="photo1" class="input-check form-notice" id="photo1" 
						accept="image/gif,image/png,image/jpeg">
				</li>
				<li>
					<label for="photo2">상품사진2</label>
					<img src="${pageContext.request.contextPath}/upload/${item.photo2}"
						data-img="${item.photo2}" width="50" height="50" class="my-photo"/>
					<br>
					<input type="file" name="photo2" class="input-check form-notice"
					  id="photo2" accept="image/gif,image/png,image/jpeg">
				</li>
				<li>
					<label for="detail">상품설명</label>
					<textarea rows="5" cols="30"
					  name="detail" id="detail"
					  class="input-check">${item.detail}</textarea>
				</li>
			</ul>   
			<div class="align-center">
				<input type="submit" value="수정">
				<input type="button" value="삭제" onclick="location.href='adminList.do?item_num=${item.item_num}'">
				<input type="button" value="목록" onclick="location.href='adminList.do'">
			</div>                     
		</form>
	</div>
</div>
</body>
</html>