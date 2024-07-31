<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body>
<div class="page-main">
	<h2>주문</h2>
	<form action="insertTest.jsp" method="post" id="myForm">
		<ul>
			<li>
				<label for="name">상품명</label>
				<input type="text" name="name" id="name" size="20" maxlength="10">
			</li>
			<li>
				<label for="price">금액</label>
				<input type="number" name="price" id="price" min="0">원
			</li>
			<li>
				<label for="stock">수량</label>
				<input type="number" name="stock" id="stock" min="0">개
			</li>
			<li>
				<label for="origin">원산지</label>
				<input type="text" name="origin" id="origin" size="20" maxlength="10">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="전송">
			<input type="button" value="목록" onclick="location.href='selectTest.jsp'">
		</div>		
	</form>
</div>
</body>
</html>