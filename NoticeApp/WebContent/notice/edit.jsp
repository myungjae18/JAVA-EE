<%@page import="notice.model.Notice"%>
<%@page import="notice.model.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!
	NoticeDAO noticeDAO=new NoticeDAO();
	Notice notice=new Notice();	
%>	
<%
	//수정 후, 다시 content.jsp 페이지를 요청할 것이므로
	//이 파일은 html을 포함할 필요가 없다.(디자인 미필요)
	request.setCharacterEncoding("utf-8");

	int notice_id=Integer.parseInt(request.getParameter("notice_id"));
	String writer=request.getParameter("writer");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	notice.setNotice_id(notice_id);
	notice.setWriter(writer);
	notice.setTitle(title);
	notice.setContent(content);
	
	int result=noticeDAO.update(notice); //수정
	
	if(result==0){
		out.print("<script>");
		out.print("alert('수정 실패....');");
		out.print("history.back();");
		out.print("</script>");
	}else{
		response.sendRedirect("/notice/content.jsp?notice_id=	"+notice_id); //지정한 url로 다시 접속
	}
%>	