<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    session.invalidate();
   	out.print("로그아웃 하였습니다.");
   	// 희망사항 여기서 2~5초대기넣고싶음
   	response.sendRedirect("loginForm.jsp");
%>
