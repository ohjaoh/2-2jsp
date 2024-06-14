<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
<%
if (session.getAttribute("id") != null) {
	response.sendRedirect("main.jsp"); // 이미 로그인된 경우 메인 페이지로 리디렉션
	return;
}
session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<form action="login.jsp">
		<table align=center>
			<tr>
				<td colspan=2 align=center height=40><b>로그인</b>
				<td>
			</tr>
			<tr>
				<td align=right>아이디&nbsp;</td>
				<td><input type="text" name="id" placeholder="ID" required></td>
			</tr>
			<tr>
				<td align=right>패스워드&nbsp;</td>
				<td><input type="password" name="ps" required></td>
			</tr>
			<tr>
				<td colspan=2 align=center height=50><input type="submit"
					value="로그인하기"></td>
			</tr>
		</table>
	</form>
	<form action="signupForm.jsp" align=center>
		<h3>무료회원가입</h3>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>