<%@page import="dao.FeedDAO"%>
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
String numStr = request.getParameter("num");
if (numStr == null || numStr.isEmpty()) {
    out.print("게시물 번호가 누락되었습니다.");
    return;
}
long num = 0; // 기본값 설정

// numStr이 숫자로 변환 가능한지 확인
try {
	num = Long.parseLong(numStr);
} catch (NumberFormatException e) {
	out.print("게시물 번호가 올바르지 않습니다. numStr: " + numStr);
	e.printStackTrace(); // 예외 정보 출력
	return;
}

String ucon = null, ufname = null;
byte[] ufile = null;

ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
List items = sfu.parseRequest(request);

Iterator iter = items.iterator();
while (iter.hasNext()) {
	FileItem item = (FileItem) iter.next();
	String name = item.getFieldName();
	if (item.isFormField()) {
		String value = new String((item.getString()).getBytes("8859_1"), "utf-8");
		if (name.equals("content"))
	ucon = value;
	} else {
		if (name.equals("image")) {
	ufname = item.getName();
	ufile = item.get();
	// 파일이 존재하는지 확인
	if (ufname != null && !ufname.trim().isEmpty() && ufile.length > 0) {
		// 파일이 있는 경우에만 파일 저장 처리
		String root = application.getRealPath(java.io.File.separator);
		FileUtil.saveImage(root, ufname, ufile);
	} else {
		// 파일이 없는 경우, 빈값을 넘겨서 이미지가 안보이게 함
		ufname = null; // 빈 문자열을 할당
		ufile = null;
	}
		}
	}
}

FeedDAO dao = new FeedDAO();
if (dao.editFeed(num, uid, ucon, ufname)) {
	response.sendRedirect("main.jsp");
} else {
	out.print("게시물 수정 중 오류가 발생하였습니다.");
}
%>
