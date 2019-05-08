<%@page import="notice.model.Notice"%>
<%@page import="notice.model.NoticeDAO"%>
<%@page contentType="text/html;charset=utf-8"%>
<%!
	NoticeDAO noticeDAO=new NoticeDAO();
	Notice notice=new Notice();
	int count=0;
%>
<%
	int notice_id=Integer.parseInt(request.getParameter("notice_id"));
	notice.setNotice_id(notice_id);
	int result=noticeDAO.increment(notice);
	
	if(result==0){
		out.print("<script>");
		out.print("alert('조회수 증가 실패...')");
		out.print("history.back()");
		out.print("</script>");
	}else{
		if(count==0){
			response.sendRedirect("/notice/content.jsp?notice_id="+notice_id);
			count++;
		}else{
			return;
		}	
	}
%>