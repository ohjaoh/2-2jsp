<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header><%@ include file="menu.jsp"%></header>
	<form action="login1.jsp" method="post" name="loginForm">
		<table align="center">
			<tr>
				<td colspan="2" align="center" height="40"><b>로그인</b></td>
			</tr>
			<tr>
				<td align="right">아이디 &nbsp;</td>
				<td><input type="text" name="id" placeholder="Email address"
					required></td>
			</tr>
			<tr>
				<td align="right">패스워드 &nbsp;</td>
				<td><input type="password" name="password" required></td>
			</tr>
			<tr>
				<td colspan="2" align="center" height="50"><input type="submit"
					value="로그인하기" onclick="checkLogin()"></td>
			</tr>
		</table>
	</form>
	<%@ include file="footer.jsp"%>
</body>

</html>