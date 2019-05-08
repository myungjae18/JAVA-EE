<%@page import="com.sun.webkit.ContextMenu.ShowContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/inc/message.jsp" %>
<%
	request.setCharacterEncoding("utf-8"); //파라미터 값 다국어 지원 세팅
%>
<jsp:useBean id="reBoard" class="com.itbank.reboard.domain.ReBoard" />
<jsp:setProperty property="*" name="reBoard" />
<jsp:useBean id="reBoardDAO"
	class="com.itbank.reboard.model.ReBoardRepository" />
<%
	//글 쓰기 form에서 전송되어 온 파라미터 값 받기
	int result = reBoardDAO.insert(reBoard);
	out.print(result);
	
	if(result==0){
		out.print(showMsgBack("등록 실패"));
	}else{
		out.print(showMsgUrl("등록 성공", "/board/list.jsp"));
	}
%>