<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 구매</title>
<script type="text/javascript">
	window.onload = function(){
		const myForm = document.getElementById('myForm');		
		
		
		myForm.onsubmit = function(){
			let name = document.getElementById('name');
			if(name.value.trim() == ''){
				alert('이름 필수 입력');
				name.value = '';
				name.focus(); 
				return false;
			}
			
			const order_date = document.getElementById('order_date');
			if(order_date.value == ''){
				alert('배송희망일 필수 선택');
				order_date.focus(); 
				return false;
			}
			
			const item = document.querySelectorAll('input[type="checkbox"]');
			let check = false;
			for(let i=0;i<item.length;i++){
				if(item[i].checked){
					check = true;
					break;
				}
			}
			if(!check){
				alert('상품은 하나 이상 꼭 선택하세요!!');
				return false;
			}
		};		
	};
</script>
</head>
<body>
<%--
이름, 배송희망일 필수 입력, 상품은 하나 이상 꼭 선택
[출력예시]
구매 금액이 30만원 미만이면 배송비 5천원 추가
이름: 홍길동
배송희망일: 2024-04-23
구입 내용 : 가방,옷
배송비 : 5,000원
총구매비용(배송비 포함) : 255,000원
 --%>
<form action="s08_order.jsp" method="post" id="myForm">
	<ul>
		<li>
			<label for="name">이름</label>
			<input type="text" name="name" id="name">
		</li>
		<li>
			<label for="order_date">배송희망일</label>
			<input type="date" name="order_date" id="order_date">
		</li>
		<li>
			<label>상품(30만원 미만 배송비 5천원 추가)</label>
			<br>
			<input type="checkbox" name="item" value="가방">가방(20만원)
			<input type="checkbox" name="item" value="신발">신발(10만원)
			<input type="checkbox" name="item" value="옷">옷(5만원)
			<input type="checkbox" name="item" value="식사권">식사권(15만원)
		</li>
	</ul>
	<input type="submit" value="전송">
</form>
</body>
</html>