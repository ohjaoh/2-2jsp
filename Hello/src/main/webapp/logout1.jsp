<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		session.invalidate();
		out.print("로그아웃 하였습니다.");
		response.sendRedirect("welcome.jsp");
	%>
	

</body>
</html>