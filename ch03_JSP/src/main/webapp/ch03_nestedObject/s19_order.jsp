<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 확인</title>
</head>
<body>
<%
	int[] orderArray = {4000,5000,6000};
			
	request.setCharacterEncoding("utf-8");
	int total = 0;
	String orderName = "";
	
	//짜장면
	int food_c0 = Integer.parseInt(request.getParameter("food_c0"));
	if(food_c0 > 0){
		total += orderArray[0] * food_c0;
		orderName += "짜장면" + food_c0 + "개<br>";
	}
	//짬뽕
	int food_c1 = Integer.parseInt(request.getParameter("food_c1"));
	if(food_c1 > 0){
		total += orderArray[1] * food_c1;
		orderName += "짬뽕" + food_c1 + "개<br>";
	}
	//볶음밥
	int food_c2 = Integer.parseInt(request.getParameter("food_c2"));
	if(food_c2 > 0){
		total += orderArray[2] * food_c2;
		orderName += "볶음밥" + food_c2 + "개<br>";
	}
%>
[주문 음식]<br>
<%= orderName %>
총 지불금액 : <%= String.format("%,d",total) %>원 
<%-- 
<%@ page import="java.util.HashMap" %> 
<% 
	request.setCharacterEncoding("utf-8");
	HashMap<String,Integer> price = new HashMap<String,Integer>();
	price.put("food_c0",4000);
	price.put("food_c1",5000);
	price.put("food_c2",6000);
	
	String[] foods = {"짜장면","짬뽕","볶음밥"};
	
	int sum = 0;
		
	for(int i=0;i<price.size();i++){
		int item = Integer.parseInt(request.getParameter("food_c"+i));
		if(item != 0){
			out.println(foods[i]);
			
%>
			<%= item %>개<br>
<%			
			sum += item * price.get("food_c"+i);
		}		
	} 
%>
총 지불금액 : <%= String.format("%,d",sum) %>원 
--%>
</body>
</html>