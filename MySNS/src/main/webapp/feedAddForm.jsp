<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
String uid = (String) session.getAttribute("id");
if (uid == null) {// 로그인여부
	response.sendRedirect("loginForm.jsp");
	return;
}
session.setAttribute("id", uid);
%>
<%
UserDAO dao = new UserDAO();
UserBean ub = new UserBean();
ub = dao.getUser(uid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function addpoint() {
		alert("글작성완료");
	}
</script>
<link rel="stylesheet" type="text/css" href="gradecss.css">
</head>
<body class="grade-<%=ub.getGrade()%>">
	<form action="feedAdd.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" value="<%=ub.getId()%>">
		<table align=center>
			<tr>
				<td colspan=2 align=center height=40><b>글작성</b>
				<td>
			</tr>
			<tr>
				<td align=right>아이디&nbsp;</td>
				<td><span><%=ub.getId()%></span></td>
			</tr>
			<tr>
				<td align=right>작성글&nbsp;</td>
				<td><textarea style="width: 300px; height: 150px;"
						name="content" rows=5 cols=20></textarea></td>
			</tr>
			<tr>
				<td align=right>이미지&nbsp;</td>
				<td><input type="file" name="image"></td>
			</tr>
			<tr>
				<td colspan=2 align=center height=50><input type="submit"
					value="업로드하기" onclick="addpoint()"></td>
			</tr>
			<tr>
				<td colspan=2 align=center><a href="main.jsp">
						<button type="button">메인으로</button>
				</a></td>
			</tr>
		</table>
	</form>
</body>
</html>