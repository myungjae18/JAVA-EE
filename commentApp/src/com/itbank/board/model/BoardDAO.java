package com.itbank.board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.itbank.comments.model.CommentsDAO;
import com.itbank.db.pool.PoolManager;

//DAO = 오직 CRUD만 담당하는 객체
public class BoardDAO {
	PoolManager pool = PoolManager.getInstance();
	Logger logger = Logger.getLogger(this.getClass().getName());
	CommentsDAO commentsDAO = new CommentsDAO();

	public int insert(Board board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();

			String sql = "insert into board(board_id, writer, title, content)";
			sql += " values(seq_board.nextval, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContent());

			result = pstmt.executeUpdate();
			logger.debug("등록 결과는 " + result);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt);
		}
		return result;
	}

	// 모든 게시물 가져오기
	public ArrayList selectAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Board board;
		ArrayList<Board> list = new ArrayList<Board>();

		try {
			con = pool.getConnection();
			// StringBuffer(thread safe) vs StringBuilder(thread unsafe)
			StringBuilder sb = new StringBuilder();
			sb.append("select b.board_id as board_id, writer, title, regdate, hit ");
			sb.append("from board b left outer join comments c ");
			sb.append("on b.board_id=c.board_id group by b.board_id, writer, title, regdate, hit ");
			sb.append("order by b.board_id desc");
			String sql = sb.toString();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int board_id = rs.getInt("board_id");
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String regdate = rs.getString("regdate");
				int hit = rs.getInt("hit");

				board = new Board();
				board.setBoard_id(board_id);
				board.setWriter(writer);
				board.setTitle(title);
				board.setRegdate(regdate);
				board.setHit(hit);
				// 이 board에 등록된 하위 comments 담기
				List cList = commentsDAO.selectAll(board.getBoard_id());
				board.setCommentsList(cList);

				list.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt);
		}
		return list;
	}

	// 글 한 건 가져오기
	public Board select(int board_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Board board = new Board();

		try {
			String sql = "select * from board where board_id=?";

			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, board_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				board.setBoard_id(rs.getInt("board_id"));
				board.setWriter(rs.getString("writer"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setHit(rs.getInt("hit"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt, rs);
		}
		return board;
	}

	// 원문 및 댓글을 삭제한다
	public int delete(int board_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();
			con.setAutoCommit(false); // 자동 커밋 방지
			String sql = "delete from board where board_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			pstmt.executeUpdate();

			sql = "delete from comments where board_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			pstmt.executeUpdate();

			con.commit(); // 트랜잭션 확정
			result = 1; // 확정 후 결과 값 표시
			logger.debug("트랜잭션 commit...");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.debug("트랜잭션 rollback...");
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			// false로 전환했던 AutoCommit을 다시 true로
			try {
				con.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pool.release(con, pstmt);
		}
		return result;
	}

	// 원문을 수정한다
	public int edit(Board board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();
			logger.debug(board.getTitle());
			String sql = "update board set title=?, content=? where board_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getBoard_id());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt);
		}
		return result;
	}
	
	//조회수 증가
		public int increment(int board_id) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int result=0;
			
			try {
				con=pool.getConnection();
				String sql="update board set hit=hit+1 where board_id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, board_id);
				
				result=pstmt.executeUpdate();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				pool.release(con, pstmt);
			}
			return result;
		}
}
