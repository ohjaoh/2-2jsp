<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
String uid = (String) session.getAttribute("id");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies

UserDAO dao = new UserDAO();
UserBean ub = new UserBean();
ub = dao.getUser(uid);
if (session.getAttribute("id") == null) {
	response.sendRedirect("loginForm.jsp"); // 로그아웃이면 접근못하게하기
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var count = 0;
	var parps = "<%=ub.getPs()%>"; // 이거 자꾸 자동정렬하면 다음줄로 밀려가서 작동안함 제발 확인해줘라
	var passwordValue = 0;

	function real(id) {
		count += 1;
		if (count < 3) {
			alert(count + "회 탈퇴를 누르셨습니다. 3번 누르시면 탈퇴가 진행됩니다.");
		} else if (count >= 3) {
			document.getElementById("passtr").style.display = ""; // 숨겨둔 비밀번호입력이 들어나게함
			passwordValue = document.getElementById("deleteForm").elements["password"].value;
			if (passwordValue === parps) {
				alert("축하한다. 넌 탈퇴에 성공했다.");
				document.getElementById("deleteForm").submit(); // 폼 제출
			} else if (count > 4) {
				alert("비밀번호가 틀렸습니다.");
				form.password.select();
			}

		}

	}
</script>
<link rel="stylesheet" type="text/css" href="gradecss.css">
</head>
<body class="grade-<%= ub.getGrade() %>">
	<form action="withdraw.jsp" id="deleteForm" method="post">
		<input type="hidden" name="id" value="<%=ub.getId()%>">
		<table align=center>
			<tr>
				<td colspan=2 align=center height=40><b>회원탈퇴</b>
				<td>
			</tr>
			<tr>
				<td align=right>아이디&nbsp;</td>
				<td><span><%=ub.getId()%></span></td>
			</tr>
			<tr style="display: none;" id="passtr">
				<td align=right>비밀번호&nbsp;</td>
				<td><input type="password" id="password" name="password"></input></td>
			</tr>
			<tr>
				<td colspan=2 align=center height=50><input type="button"
					onclick="real(this.form.id.value);" value="회원탈퇴하기"></td>
			</tr>
			<tr>
				<td colspan=2><a href="main.jsp">
						<button type="button">메인으로</button>
				</a></td>
			</tr>
		</table>
	</form>
</body>
</html>