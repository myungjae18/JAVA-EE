<%@page import="com.itbank.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//각각의 DAO가 서로 다른 Connection을 보유, 같은 세션으로 보기 힘듬
	//해결책) 상위에 객체를 두어 Connection을 공유 ->모델 2방식이므로 추후 해결
	BoardDAO boardDAO=new BoardDAO();
	String board_id=request.getParameter("board_id");
	int result=boardDAO.delete(Integer.parseInt(board_id));
%>
<script>
<%if(result==0){%>
alert("삭제 실패..");
historyback();
<%}else{%>
alert("삭제 성공!");
location.href="/board/list.jsp";
<%}%>
</script>