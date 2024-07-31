<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//전송된 데이터 인코딩 타입 지정
	request.setCharacterEncoding("utf-8");
%>
                        <%-- import 여부와 관계 없이 전체 경로 작성! --%>
<jsp:useBean id="member" class="kr.web.member.MemberVO"/>
<%-- 
 * = 모든 property 
기능: property(MemberVO의 멤버변수)와 일치하는 parameter(jsp:getProperty의 name)가 존재하면 전부 허용
--%>
<jsp:setProperty name="member" property="*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
아이디 : <jsp:getProperty property="id" name="member"/><br>
비밀번호 : <jsp:getProperty property="password" name="member"/><br>
이름 : <jsp:getProperty property="name" name="member"/><br>
이메일 : <jsp:getProperty property="email" name="member"/><br>
주소 : <jsp:getProperty property="address" name="member"/>
</body>
</html>