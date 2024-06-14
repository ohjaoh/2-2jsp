<%@page import="dao.*"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="util.FileUtil"%>
<%
request.setCharacterEncoding("utf-8");
String uid = request.getParameter("uid");
String pointString = request.getParameter("point"); // point 값을 문자열로 받음
String calcValue = request.getParameter("calcValue");

// point 값을 정수로 변환 (에러 처리 필요)
int point = 0;
try {
	point = Integer.parseInt(pointString);
} catch (NumberFormatException e) {
	// point 값이 잘못된 경우의 처리 (예: 에러 메시지 출력)
	out.println("Invalid point value");
}
//calcValue에 따른 사칙연산 적용
int randomValue = (int) (Math.random() * 21) - 10; // -10에서 10 사이의 랜덤값 생성 확률 조작가능
switch (calcValue) {
case "p":
	point += randomValue;
	break;
case "m":
	point -= randomValue;
	break;
case "g":
	point *= randomValue;
	break;
case "n":
	if (randomValue != 0) { // 0으로 나누는 것을 방지
		point /= randomValue;
	}
	break;
}

if (point <= 0) {
	point = 0;
}

out.print("UID: " + uid + "<br>");
out.print("Point: " + point + "<br>");
out.print("Random Value: " + randomValue + "<br>");

UserDAO dao = new UserDAO();
UserBean ub = dao.getUser(uid); // 사용자 정보를 데이터베이스에서 가져옴

// 변경된 포인트를 데이터베이스에 저장 (point를 사용)
dao.addpoint(uid, point);

// 변경된 점수에 따라서 등급이 변화
dao.updateGrade(uid);

// 유저정보로 가서 점수확인
// response.sendRedirect("updateForm.jsp");
%>
<script>
    setTimeout(function() {
        window.location.href = "updateForm.jsp";
    }, 2000); // 2000 밀리초 후에 페이지 이동
</script>