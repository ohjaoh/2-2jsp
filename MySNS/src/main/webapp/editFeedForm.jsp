<%@page import="dao.UserBean"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="util.FileUtil"%>
<%@ page import="dao.FeedDAO"%>
<%
request.setCharacterEncoding("utf-8");
String uid = (String) session.getAttribute("id");
if (uid == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}
session.setAttribute("id", uid);

String numStr = request.getParameter("num");

long num = 0; // 기본값 설정

if (numStr != null && !numStr.trim().isEmpty()) {
	// numStr이 숫자로 변환 가능한지 확인
	try {
		num = Long.parseLong(numStr);
	} catch (NumberFormatException e) {
		out.print("게시물 번호가 올바르지 않습니다. numStr: " + numStr);
		e.printStackTrace(); // 예외 정보 출력
		return;
	}
}

UserDAO dao = new UserDAO();
UserBean ub = dao.getUser(uid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Feed</title>
<link rel="stylesheet" type="text/css" href="gradecss.css">
</head>
<body class="grade-<%=ub.getGrade()%>">
	<form action="editFeed.jsp?uid=<%=uid%>&num=<%=num%>" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="uid" value="<%=uid%>"> <input
			type="hidden" name="num" value="<%=num%>">
		<table align=center>
			<tr>
				<td colspan=2 align=center height=40><b>게시물 수정</b></td>
			</tr>
			<tr>
				<td align=right>아이디&nbsp;</td>
				<td><span><%=ub.getId()%></span></td>
			</tr>
			<tr>
				<td align=right>수정 내용&nbsp;</td>
				<td><textarea style="width: 300px; height: 150px;"
						name="content" rows=5 cols=20></textarea></td>
			</tr>
			<tr>
				<td align=right>수정 이미지&nbsp;</td>
				<td><input type="file" name="image"></td>
			</tr>
			<tr>
				<td colspan=2 align=center height=50><input type="submit"
					value="수정하기"></td>
			</tr>
			<tr>
				<td colspan=2 align=center><a href="main.jsp"><button
							type="button">메인으로</button></a></td>
			</tr>
		</table>
	</form>
</body>
</html>
