<%@page import="com.itbank.reboard.model.ReBoardRepository"%>
<%@page import="com.itbank.reboard.domain.ReBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/inc/message.jsp" %>	
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="reBoard" class="com.itbank.reboard.domain.ReBoard"></jsp:useBean>
<jsp:setProperty property="*" name="reBoard" />
<jsp:getProperty property="team" name="reBoard" />
<jsp:getProperty property="rank" name="reBoard" />
<jsp:getProperty property="depth" name="reBoard" />
<%
	//답변 글 및 내가 본 글의 team, rank, depth 3개의 파라미터 값을 받자!
	String team=request.getParameter("team");
	String rank=request.getParameter("rank");
	String depth=request.getParameter("depth");
	
	reBoard.setTeam(Integer.parseInt(team));
	reBoard.setRank(Integer.parseInt(rank));
	reBoard.setDepth(Integer.parseInt(depth));
	
	ReBoardRepository dao=new ReBoardRepository();
	int result=dao.reply(reBoard);
	if(result==0){
		showMsgBack("등록 실패..");
		out.print("history.back();");
	}else{
		showMsgUrl("등록 성공!", "/board/content.jsp");
	}
%>