package com.itbank.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itbank.board.model.Board;
import com.itbank.board.model.BoardDAO;

public class BoardController extends HttpServlet {
	// doXXX형을 재정의한다
	// 모든 요청 방법을 다 감당할 수 있는 방법을 구상하	기
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 파라미터 받기
		request.setCharacterEncoding("utf-8");
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("넘겨받은 파라미터값은 " + writer);
		out.print("넘겨받은 파라미터값은 " + title);
		out.print("넘겨받은 파라미터값은 " + content);

		Board board = new Board();
		board.setWriter(writer);
		board.setTitle(title);
		board.setContent(content);

		BoardDAO boardDAO = new BoardDAO();
		int result = boardDAO.insert(board);

		out.print("<script>");
		if (result == 0) {
			out.print("alert('등록 실패...');");
			out.print("history.back();");
		} else {
			out.print("alert('등록 성공!');");
			/*응답이 완료되어 클라이언트에 문서가 전달된 이후에
			응답을 받은 클라이언트는 이제서야 아래의 코드를 수행하게 된다...
			클라이언트 = 웹브라우저
			새로 접속을 시도한다.. = response.sendRedirect()와 같다
			out은 클라이언트의 브라우저에 출력하는 것이 아니라,
			사실은 서버측에서 문서를 만들때 그문서 내에 출력하는 것이다.*/
			out.print("location.href='/board/list.jsp';");
		}
		out.print("</script>");
	}
}
