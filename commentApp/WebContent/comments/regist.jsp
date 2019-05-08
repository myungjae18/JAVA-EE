<%@page import="com.itbank.comments.model.CommentsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="comments" class="com.itbank.comments.model.Comments"/>
<jsp:useBean id="commentsDAO" class="com.itbank.comments.model.CommentsDAO"/>
<jsp:setProperty property="*" name="comments"/>    
<%
	int result=commentsDAO.insert(comments);
%>
<script>
<%if(result==0){%>
alert("등록 실패..");
historyback();
<%}else{%>
alert("등록 성공!");
location.href="/board/content.jsp?board_id="+<%=comments.getBoard_id()%>;
<%}%>
</script>