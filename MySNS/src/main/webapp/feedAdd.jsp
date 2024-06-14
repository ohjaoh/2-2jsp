<%@page import="dao.UserBean"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="util.FileUtil" %>
<%@ page import="dao.FeedDAO" %>
<%
    request.setCharacterEncoding("utf-8");

    String uid = null, ucon = null, ufname = null;
    byte[] ufile = null;

    ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
    List items = sfu.parseRequest(request);

    Iterator iter = items.iterator();
    while(iter.hasNext()) {
        FileItem item = (FileItem) iter.next();
        String name = item.getFieldName();
        if(item.isFormField()) {
//            String value = item.getString(); 
           String value = new String((item.getString()).getBytes("8859_1"),"utf-8");
            if (name.equals("id")) uid = value;
            else if (name.equals("content")) ucon = value;
            
            out.print("id: "+uid+"<br>");
            out.print("ucon: "+ucon+"<br>");
            
        }
        else {
            if (name.equals("image")) {
                ufname = item.getName();
                ufile = item.get();
             // 파일이 존재하는지 확인
                if (ufname != null && !ufname.trim().isEmpty() && ufile.length > 0) {
                    // 파일이 있는 경우에만 파일 저장 처리
                    String root = application.getRealPath(java.io.File.separator);
                    FileUtil.saveImage(root, ufname, ufile);
                }
                else{// 파일이 없는 경우, 빈값을 넘겨서 깨진 이미지가 안보이게 함
                	ufname = null; // 빈 문자열을 할당
                    ufile = null;
                }
            }
        }
    }

    UserDAO udao = new UserDAO(); // 게시글 작성 시 포인트 추가 로직
    UserBean ub = udao.getUser(uid); // 사용자 정보를 데이터베이스에서 가져옴
    udao.addpoint(uid, ub.getPoint()+5); // 변경된 포인트를 데이터베이스에 저장
    udao.updateGrade(uid); // 변경된 점수에 따라서 등급이 변화

    
    FeedDAO dao = new FeedDAO();
    if (dao.insert(uid, ucon, ufname)) {
        response.sendRedirect("main.jsp");
    }
    else {
        out.print("작성 글의 업로드 중 오류가 발생하였습니다.");
    }
%>