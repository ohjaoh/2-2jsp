<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		session.invalidate();
		out.print("로그아웃 하였습니다.");
		//response.sendRedirect("login.html");
	%>
	
   	<form action="login.html">
   		<input type="submit" value="로그인사이트로">
   	</form>