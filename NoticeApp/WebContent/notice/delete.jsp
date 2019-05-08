<%@page import="notice.model.Notice"%>
<%@page import="notice.model.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	NoticeDAO noticeDAO=new NoticeDAO();
	Notice notice=new Notice();
%>    
<%
	//삭제 처리 후 list.jsp를 요청하기 때문에 현재 jsp는 디자인을 담당하지 않는다..
	int notice_id=Integer.parseInt(request.getParameter("notice_id"));
	notice.setNotice_id(notice_id);
	
	int result=noticeDAO.delete(notice);
	
	if(result==0){
		out.print("<script>");
		out.print("alert('삭제 실패.....')");
		out.print("history.back()");
		out.print("</script>");
	}else{
		response.sendRedirect("/notice/list.jsp");
	}
%>