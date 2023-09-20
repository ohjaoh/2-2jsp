<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="welcomestyle.css">
<title>Insert title here</title>
</head>
<body>
	<div class="contian">
		<header><%@ include file="menu.jsp"%></header>
		<h1 class="soge">웹 쇼핑몰에 오신 것을 환영합니다.</h1>
		<div class="textarea">
			<div class="centertext1">Welcome to Web Marcket!</div>
			<br>
			<div class="centertext2">
				현재시간:<%=java.time.LocalDateTime.now()%></div>
			<%@ include file="footer.jsp"%>
		</div>
	</div>
</body>
</html>