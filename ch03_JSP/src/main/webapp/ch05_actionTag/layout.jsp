<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지 모듈화</title>
<style type="text/css">
table{
	width:500px;
	margin:0 auto;
	border:solid 1px #000;
	border-collapse:collapse;
}
td{
	border:solid 1px #000;
	text-align:center;
	vertical-align:middle;
	height:40px;
}
td.td-middle{
	text-align:left;
	vertical-align:top;
	height:20px;
}
td.td-width{
	width:100px;
}
</style>
</head>
<body>
<table>
	<tr>
		<td colspan="2">
			<%-- 
			include 태그의 내용으로 html 주석, jsp 주석 전부 사용 불가 
			해결방법: include태그 바깥에 주석 작성하기
			--%>
			<%--최초의 request 접근은 모듈 파일이 아닌 main파일 --%>
			<jsp:include page="/ch05_actionTag/module/top.jsp">								
				<jsp:param value="국제상사" name="company"/>
			</jsp:include>
		</td>
	</tr>
	<tr>
		<td class="td-middle td-width">
			<%-- <태그></태그>는 <태그/>로 축약 가능 (단,내용이 없을 경우 사용)--%>			
			<jsp:include page="/ch05_actionTag/module/left.jsp"/> 
		</td>
		<td class="td-middle">
			<!-- 내용 시작 -->
			레이아웃1
			<!-- 내용 끝 --> 
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<jsp:include page="/ch05_actionTag/module/bottom.jsp"/>
		</td>
	</tr>
</table>
</body>
</html>