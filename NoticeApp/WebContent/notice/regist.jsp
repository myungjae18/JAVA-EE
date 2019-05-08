<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="notice.model.NoticeDAO"%>
<%@page import="notice.model.Notice"%>
<%!NoticeDAO noticeDAO = new NoticeDAO();
	Notice notice = new Notice();%>
<%
	//이 페이지에서는 오라클에 넣는 역할만을 수행하고, 오라클에 글 등록 직후
	//list.jsp가 보여줘야 되므로 이 페이지는 디자인이 들어갈 필요가 없다...

	//파라미터 받기
	request.setCharacterEncoding("utf-8"); //다국어 지원
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	//DAO의 insert 메서드 호출 후 list.jsp를 요청한다
	notice.setWriter(writer);
	notice.setTitle(title);
	notice.setContent(content);
	int result=noticeDAO.insert(notice);
	if(result==0){
		out.print("<script>");
		out.print("alert('실패');");
		out.print("history.back()"); //다시 돌아가기
		out.print("</script>");
	}else{
		out.print("<script>");
		out.print("alert('성공');");
		out.print("location.href='/notice/list.jsp';"); //다시 돌아가기
		out.print("</script>");
	}
%>