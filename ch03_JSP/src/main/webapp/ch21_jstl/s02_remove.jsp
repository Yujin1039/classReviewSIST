<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>remove 태그</title>
</head>
<body>
<c:set var="city" value="인천"/>
데이터 삭제 전 : ${city}<br>
-----------------------<br>
<c:remove var="city"/>
데이터 삭제 후 : ${city}
</body>
</html>