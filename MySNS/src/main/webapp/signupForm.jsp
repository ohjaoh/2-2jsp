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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	// 중복확인 버튼을 누르면 작동시켜야함
	function id_check(id) {
		if (id == "") {
			alert("ID를 입력하세요");
			return;
		}
		url = "confirmId.jsp?id=" + id;
		window.open(url, "confirm", "width=300, height=200");
	}
</script>
<script type="text/javascript">
	function check() {
		var form = document.signupForm; // 폼을 불러온다
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
		if (form.ps2.value != form.ps.value) {
			alert("비밀번호 확인하세요");
			form.ps2.select();
			return false;
		}
		if(!gol.test(form.email.value)){
			alert("이메일에는 @가 필요합니다.");
			err=true;	
			return false;
		}if (!num.test(form.phone.value)) {
		    alert("전화번호는 숫자만 포함해야 합니다.");
		    err = true;
		    form.phone.select();
		    return false;
		}
		form.submit();
	}
</script>
</head>


<body>
	<form action="signup.jsp" method="post" name="signupForm">
		<table align=center>
			<tr>
				<td colspan=2 align=center height=40><b>회원가입</b>
				<td></td>
			</tr>
			<tr>
				<td align=right>아이디&nbsp;</td>
				<td><input type="text" name="id" placeholder="ID"> <input
					type="button" onclick="id_check(this.form.id.value);" value="중복확인"></td>
			</tr>
			<tr>
				<td>비밀번호조건</td>
				<td><p style="font-size: 9px">비밀번호는 숫자와 대문자를 포함하며 4자이상 15자
						이하</p></td>
			</tr>
			<tr>
				<td align=right>패스워드 &nbsp;</td>
				<td><input type="password" name="ps"></td>
			</tr>
			<tr>
				<td align=right>패스워드(확인)&nbsp;</td>
				<td><input type="password" name="ps2"></td>
			</tr>
			<tr>
				<td align=right>이름&nbsp;</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td align=right>전화번호&nbsp;</td>
				<td><input type="text" name="phone"></td>
			</tr>
			<tr>
				<td align=right>이메일&nbsp;</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td colspan=2 align=center height=50><input type="button"
					value="회원가입하기" onclick="check()"></td>
			</tr>
			<tr>
				<td colspan=2 align=center height=50><a href="main.jsp">
						<button type="button">메인으로</button>
				</a></td>
			</tr>
		</table>
	</form>
</body>
</html>