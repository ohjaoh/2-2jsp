<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="user" class="dao.UserBean">
	<jsp:setProperty name="user" property="*" />
</jsp:useBean>
<%
UserDAO dao = new UserDAO();

if (dao.update(user)) {
	response.sendRedirect("updateForm.jsp");
} else {
	out.print("회원정보 수정 중 오류가 발생하었습니다.");
}
%>