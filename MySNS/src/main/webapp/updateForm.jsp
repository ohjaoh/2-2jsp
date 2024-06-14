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
<script type="text/javascript">
	function check() {
		var form = document.updateform; // 폼을 불러온다
		var total = /^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{4,15}$/; //숫자를 포함한 4자이상 15자 이하 , 대문자 포함 
		var gol = /[@]/;
		var num = /^\d+$/; // 문자열이 숫자만으로 구성되어 있는지 확인하는 정규 표현식
		// 숫자를 포함한 4자이상 15자 이하 , 대문자 포함
		if (!total.test(form.ps.value)) {
			alert("비밀번호조건을 확인하세요");
			form.ps.select();
			return false;
		}
		if (form.name.value == "") {
			alert("이름입력");
			form.name.select();
			return false;
		}
		if (form.phone.value == "") {
			alert("전화번호입력");
			form.name.select();
			return false;
		}
		if (form.email.value == "") {
			alert("이메일입력");
			form.name.select();
			return false;
		}
		if (!gol.test(form.email.value)) {
			alert("이메일에는 @가 필요합니다.");
			err = true;
			return false;
		}
		if (!num.test(form.phone.value)) {
			alert("전화번호는 숫자만 포함해야 합니다.");
			err = true;
			form.phone.select();
			return false;
		}
		form.submit();
	}
</script>
<link rel="stylesheet" type="text/css" href="gradecss.css">
</head>

<body class="grade-<%=ub.getGrade()%>">

	<form action="update.jsp" method="post" name="updateform">
		<input type="hidden" name="id" value="<%=ub.getId()%>"></input>
		<table align=center>
			<tr>
				<td colspan=2 align=center height=40><b>회원정보수정</b>
				<td>
			</tr>
			<tr>
				<td align=right>아이디&nbsp;</td>
				<td><span><%=ub.getId()%> </span></td>
			</tr>
			<tr>
				<td align=right>패스워드&nbsp;</td>
				<td><input type="password" name="ps" value="<%=ub.getPs()%>"
					required></td>
			</tr>
			<tr>
				<td align=right>이름&nbsp;</td>
				<td><input type="text" name="name" value="<%=ub.getName()%>"
					required></td>
			</tr>
			<tr>
				<td align=right>전화번호&nbsp;</td>
				<td><input type="text" name="phone" value="<%=ub.getPhone()%>"></td>
			</tr>
			<tr>
				<td align=right>이메일&nbsp;</td>
				<td><input type="text" name="email" value="<%=ub.getEmail()%>"></td>
			</tr>
			<tr>
				<td align=right>활동점수&nbsp;</td>
				<td><span><%=ub.getPoint()%></span></td>
			</tr>
			<tr>
				<td align=right>회원등급&nbsp;</td>
				<td><span>
						<%
						int grade = ub.getGrade();
						String gradeName = "";

						switch (grade) {
						case 0:
							gradeName = "브론즈";
							break;
						case 1:
							gradeName = "실버";
							break;
						case 2:
							gradeName = "골드";
							break;
						case 3:
							gradeName = "플래티넘";
							break;
						default:
							gradeName = "알 수 없음";
							break;
						}

						out.println(gradeName);
						%>
				</span></td>
			</tr>
			<tr>
				<td><a href="main.jsp">
						<button type="button">메인으로</button>
				</a></td>
				<td align=center height=50><input type="button"
					value="회원정보수정" onclick="check()"></td>
			</tr>
		</table>
	</form>

</body>
</html>