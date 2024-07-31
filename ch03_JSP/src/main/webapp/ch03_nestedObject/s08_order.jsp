<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ page import="java.util.HashMap" %>
<% 
request.setCharacterEncoding("utf-8");  
 
HashMap<String,Integer> priceList = new HashMap<String,Integer>(); 
priceList.put("가방",200000);
priceList.put("신발",100000);
priceList.put("옷",50000);
priceList.put("식사권",150000);

//배송비
int delivery_fee = 5000;
int sum = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 구매</title>
</head>
<body>
이름: <%= request.getParameter("name") %><br>
배송희망일: <%= request.getParameter("order_date") %><br>
<%
	String[] items = request.getParameterValues("item");
	if(items != null){
%>
	구입 내용 : 
<% 		
		for(int i=0;i<items.length;i++){
			if(i>0) out.print(",");
%>
			<%= items[i] %>
<% 		
			sum += priceList.get(items[i]);
		}
	}
%><br>

<%
	if(sum>=300000) delivery_fee=0;
	else sum += delivery_fee;
%>
	배송비 : <%= String.format("%,d",delivery_fee) %>원<br>
	총구매비용(배송비 포함) : <%= String.format("%,d",sum) %> 원 
</body>
</html>