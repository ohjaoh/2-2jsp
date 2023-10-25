<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--@ page import="java.util.Date"--%>
<%--@ page import="java.text.SimpleDateFormat"--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String uid = request.getParameter("id");
		if(uid == null){
			out.print("로그인 정보가 없습니다.");
		}
		else {
			session.setAttribute("id", uid);
			response.sendRedirect("welcome.jsp");
		}
	%>
	<%--
		Date now = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String date =df.format(now);
		
		if(date.endsWith("12")){
			response.sendRedirect("underCheck.jsp");
			return;
		}
		
		String uid = request.getParameter("id");
		String res = "<h3>사용자 아이디:"+uid+"</h3>";
		res += "<br>로그인 시간:"+ now.toString();
		out.print(res);
	--%>

	<% request.setCharacterEncoding("utf-8");%>
	<h3>
		User ID:<%= request.getParameter("id") %></h3>
	<h3>
		User PW:<%= request.getParameter("password") %></h3>
</body>
</html>