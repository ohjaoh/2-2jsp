<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%
    ArrayList<FeedObj> feeds = (new FeedDAO()).getList();
    UserDAO userDAO = new UserDAO();
    
    String str = "<table align=center>";
    str += "<tr><th colspan=3>작성글 리스트</th></tr>";
    for (FeedObj feed : feeds) {
        UserBean user = userDAO.getUser(feed.getId());
        String grade = (user != null) ? String.valueOf(user.getGrade()) : "N/A";

        str += "<tr><td colspan=3><hr></td></tr>";
        str += "<tr>";
        str += "<td><small>" + feed.getId() + " (등급: " + grade + ")</small></td>";
        str += "<td><small>&nbsp;(" + feed.getTs() + ")</small></td>";
        str += "</tr>";
        str += "<tr><td colspan=3>" + feed.getContent() + "</td></tr>";
    }
    str += "</table>";
    out.print(str);
%>
