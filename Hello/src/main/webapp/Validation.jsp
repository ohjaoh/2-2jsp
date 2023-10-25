<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Validation</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<p>	아이디 : <%=request.getParameter("id")%>
	<p>	비밀번호 : <%=request.getParameter("pw")%>
	<p> 이름 : <%=request.getParameter("name") %>
	<p> 연락처 : <%=request.getParameter("phone") %>
	<p> 이메일 : <%=request.getParameter("email") %>
</body>
</html>