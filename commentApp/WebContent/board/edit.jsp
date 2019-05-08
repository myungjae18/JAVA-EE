<%@page import="com.itbank.board.model.Board"%>
<%@page import="com.itbank.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//각각의 DAO가 서로 다른 Connection을 보유, 같은 세션으로 보기 힘듬
	//해결책) 상위에 객체를 두어 Connection을 공유 ->모델 2방식이므로 추후 해결
	BoardDAO boardDAO = new BoardDAO();
	Board board = new Board();
	
	request.setCharacterEncoding("utf-8");
	String board_id = request.getParameter("board_id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	//out.print(board_id);
	//out.print(title);
	//out.print(content);
	board.setBoard_id(Integer.parseInt(board_id));
	board.setTitle(title);
	board.setContent(content);

	int result = boardDAO.edit(board);
%>
<script>
<%if(result==0){%>
alert("수정 실패..");
historyback();
<%}else{%>
alert("수정 성공!");
location.href="/board/list.jsp";
<%}%>
</script>