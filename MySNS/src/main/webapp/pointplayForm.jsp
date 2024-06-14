<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page import="dao.UserBean"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="util.FileUtil"%>
<%@ page import="dao.*"%>
<%
request.setCharacterEncoding("utf-8");
String uid = (String) session.getAttribute("id");
if (uid == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}
session.setAttribute("id", uid);

long num = 0; // 기본값 설정

UserDAO dao = new UserDAO();
UserBean ub = dao.getUser(uid);
int point = ub.getPoint();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function setCalcValue() {
		// 'calc' 선택 필드의 현재 값을 'calcValue' 숨겨진 필드에 설정합니다
		document.getElementById('calcValue').value = document
				.getElementById('calc').value;

	}
</script>
<link rel="stylesheet" type="text/css" href="gradecss.css">
</head>
<body class="grade-<%=ub.getGrade()%>">
	<form action="pointplay.jsp" method="post" onsubmit="setCalcValue()">
		<input type="hidden" name="uid" value="<%=uid%>"> <input
			type="hidden" name="point" value="<%=point%>"> <input
			type="hidden" name="calcValue" id="calcValue">
		<table align=center>
			<tr>
				<td colspan=2 align=center height=40><b>즐거운 놀이터</b></td>
			</tr>
			<tr>
				<td colspan=2 align=center>규칙은 항상 올인!</td>
			</tr>
			<tr>
				<td align=right>아이디&nbsp;</td>
				<td><span><%=ub.getId()%></span></td>
			</tr>
			<tr>
				<td align=right>잘고르시게</td>
				<td><select name="fornum" id="calc">
						<option value="p">+</option>
						<option value="m">-</option>
						<option value="g">*</option>
						<option value="n">/</option>
				</select></td>
			</tr>
			<tr>
				<td colspan=2 align=center height=50><input type="submit"
					value="플래이"></td>
			</tr>
			<tr>
				<td colspan=2 align=center><a href="main.jsp"><button
							type="button">메인으로</button></a></td>
			</tr>
		</table>
	</form>
</body>
</html>