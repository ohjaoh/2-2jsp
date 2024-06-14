<%@ page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}
String uid = (String) session.getAttribute("id");
if (uid == null || uid == "") {
	response.sendRedirect("loginForm.jsp");
	return;
}
session.setAttribute("id", uid);
UserDAO userDAO = new UserDAO();
UserBean ub = userDAO.getUser(uid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="gradecss.css">
</head>
<body class="grade-<%=ub.getGrade()%>">
	<%@ include file="menu.jsp"%>
	<%
	ArrayList<FeedObj> feeds = (new FeedDAO()).getList();
	String str = "<table align=center>";
	str += "<tr height=40><td colspan=3 align='center'><b style='font-size: 24px;'>작성글 리스트</b></td></tr>";

	for (FeedObj feed : feeds) {
		String img = feed.getImages(), imgstr = "";
		if (img != null && !img.isEmpty()) {
			imgstr = "<img src='images/" + img + "' width=240>";
		}
		UserBean feedUser = userDAO.getUser(feed.getId());
		String gradeName;
		switch (feedUser.getGrade()) {
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
			gradeName = "미정"; // 혹은 적절한 기본 값
		}

		str += "<tr><td colspan=3><hr></td></tr>";
		str += "<tr>";
		str += "<td><small class='text'>" + feed.getId() + " (" + gradeName + ")</small></td>";
		str += "<td><small>(" + feed.getTs() + ")</small></td>";
		str += "</tr>";
		str += "<tr><td colspan=2>" + imgstr + "</td></tr>";
		str += "<tr><td colspan=3>" + feed.getContent() + "</td></tr>";
		// 버튼을 보여줄지 여부를 결정하는 조건문을 추가합니다.
		if (feed.getId().equals(uid)) {
			// 클릭 시 글 수정 페이지로 이동하는 버튼을 생성합니다. 수정은 미구현
			str += "<td><button onclick=\"window.location.href='editFeedForm.jsp?uid=" + uid + "&num=" + feed.getNo()
			+ "';\">수정</button></td>";
			// 클릭 시 글 삭제 JSP 페이지로 이동하는 버튼을 생성합니다.
			str += "<td><button onclick=\"window.location.href='deleteFeed.jsp?uid=" + uid + "&num=" + feed.getNo()
			+ "';\">삭제</button></td>";
		} else {
			str += "<td></td>"; // 버튼이 없는 행에 빈 셀을 추가하여 테이블의 열을 맞춥니다.
			str += "<td></td>"; // 버튼이 없는 행에 빈 셀을 추가하여 테이블의 열을 맞춥니다.
		}
		str += "</tr>";
	}

	str += "</table>";
	out.print(str);
	%>
</body>
</html>
