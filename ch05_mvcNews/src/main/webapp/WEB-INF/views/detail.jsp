<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<h2>뉴스 상세</h2>
	<ul>
		<li>뉴스 번호: ${vo.num}</li>
		<li>제목: ${vo.title}</li>
		<li>작성자: ${vo.writer}</li>
		<li>이메일: ${vo.email}</li>		
	</ul>
	<hr size="1" width="100%" noshade="noshade">
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${vo.filename}" style="max-width:500px;">
	</div>		
	<p>${vo.article}</p>
	<hr size="1" width="100%" noshade="noshade">
	<div class="align-right">
		작성일: ${vo.reg_date}
		<input type="button" value="수정" onclick="location.href='updateForm.do?num=${vo.num}'">
		<input type="button" value="삭제" onclick="location.href='deleteForm.do?num=${vo.num}'">
		<input type="button" value="목록" onclick="location.href='list.do'">
	</div>
</div>
</body>
</html>