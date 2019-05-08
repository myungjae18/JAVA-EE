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
	// doXXX���� �������Ѵ�
	// ��� ��û ����� �� ������ �� �ִ� ����� ������	��
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// �Ķ���� �ޱ�
		request.setCharacterEncoding("utf-8");
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("�Ѱܹ��� �Ķ���Ͱ��� " + writer);
		out.print("�Ѱܹ��� �Ķ���Ͱ��� " + title);
		out.print("�Ѱܹ��� �Ķ���Ͱ��� " + content);

		Board board = new Board();
		board.setWriter(writer);
		board.setTitle(title);
		board.setContent(content);

		BoardDAO boardDAO = new BoardDAO();
		int result = boardDAO.insert(board);

		out.print("<script>");
		if (result == 0) {
			out.print("alert('��� ����...');");
			out.print("history.back();");
		} else {
			out.print("alert('��� ����!');");
			/*������ �Ϸ�Ǿ� Ŭ���̾�Ʈ�� ������ ���޵� ���Ŀ�
			������ ���� Ŭ���̾�Ʈ�� �������� �Ʒ��� �ڵ带 �����ϰ� �ȴ�...
			Ŭ���̾�Ʈ = ��������
			���� ������ �õ��Ѵ�.. = response.sendRedirect()�� ����
			out�� Ŭ���̾�Ʈ�� �������� ����ϴ� ���� �ƴ϶�,
			����� ���������� ������ ���鶧 �׹��� ���� ����ϴ� ���̴�.*/
			out.print("location.href='/board/list.jsp';");
		}
		out.print("</script>");
	}
}
