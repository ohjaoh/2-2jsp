<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.FeedDAO" %>

<%
    String uid = request.getParameter("uid");
    long num = Long.parseLong(request.getParameter("num"));

    FeedDAO feedDAO = new FeedDAO();
    boolean deleted = feedDAO.delete(uid, num);

    // 삭제 성공 또는 실패에 따른 메시지를 출력합니다.
    if (deleted) {
        out.println("글이 삭제되었습니다.");
    	response.sendRedirect("main.jsp");        
    } else {
        out.println("글 삭제에 실패했습니다.");
    	response.sendRedirect("main.jsp");
    }
%>