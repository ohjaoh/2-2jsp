<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%
    // 브라우저 캐시 방지
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
request.setCharacterEncoding("utf-8");

String uid = request.getParameter("id");

UserDAO dao = new UserDAO();
if (dao.exists(uid) == false) { // 중복된 아이디를 못찾으면 없다는 뜻
	out.print("회원 정보를 찾을 수 없습니다.");
	return;
}

if (dao.delete(uid)) {
	session.invalidate(); // 사용자의 세션을 무효화합니다.
	response.sendRedirect("loginForm.jsp");
	return;
} else {
	out.print("회원 탈퇴 주 오류가 발생하였습니다.");
}
%>