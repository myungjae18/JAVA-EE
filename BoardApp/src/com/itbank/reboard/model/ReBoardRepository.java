package com.itbank.reboard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.itbank.db.pool.PoolManager;
import com.itbank.reboard.domain.ReBoard;

//reBoard에 대한 CRUD만 담당..
public class ReBoardRepository {
	PoolManager pool = PoolManager.getInstance();

	// 첫 원문 한 건 등록
	public int insert(ReBoard reBoard) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();

			String sql = "insert into reBoard(reBoard_id, writer, title, content, team)";
			sql += " values(seq_reBoard.nextval, ?, ?, ?, seq_reBoard.nextval)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reBoard.getWriter());
			pstmt.setString(2, reBoard.getTitle());
			pstmt.setString(3, reBoard.getContent());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt);
		}
		return result;
	}

	// 답변 게시판 목록 가져오기
	public ArrayList selectAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReBoard> list = new ArrayList<ReBoard>();

		try {
			con = pool.getConnection();
			String sql = "select * from reBoard order by team desc, rank asc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReBoard reBoard = new ReBoard();
				reBoard.setReboard_id(rs.getInt("reBoard_id"));
				reBoard.setWriter(rs.getString("writer"));
				reBoard.setTitle(rs.getString("title"));
				reBoard.setContent(rs.getString("content"));
				reBoard.setRegdate(rs.getString("regdate"));
				reBoard.setHit(rs.getInt("hit"));
				reBoard.setTeam(rs.getInt("team"));
				reBoard.setRank(rs.getInt("rank"));
				reBoard.setDepth(rs.getInt("depth"));

				list.add(reBoard);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt, rs);
		}
		return list;
	}

	// 레코드 한 건 가져오기
	public ReBoard select(int reBoard_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReBoard reBoard = null;

		try {
			con = pool.getConnection();
			String sql = "select * from reBoard where reboard_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reBoard_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				reBoard = new ReBoard();
				reBoard.setReboard_id(rs.getInt("reBoard_id"));
				reBoard.setWriter(rs.getString("writer"));
				reBoard.setTitle(rs.getString("title"));
				reBoard.setContent(rs.getString("content"));
				reBoard.setRegdate(rs.getString("regdate"));
				reBoard.setHit(rs.getInt("hit"));
				reBoard.setTeam(rs.getInt("team"));
				reBoard.setRank(rs.getInt("rank"));
				reBoard.setDepth(rs.getInt("depth"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt, rs);
		}
		return reBoard;
	}

	// 답변 등록 : 2개의 작업 단위로 이루어진 트랜잭션
	public int reply(ReBoard reBoard) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			// 답변 글이 들어갈 자리 확보
			con = pool.getConnection();
			con.setAutoCommit(false);

			String sql = "update reboard set rank=rank+1";
			sql += " where rank>? and team=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reBoard.getRank());
			pstmt.setInt(2, reBoard.getTeam());
			pstmt.executeUpdate();

			sql = "insert into reboard(reboard_id, writer, title, content, team, rank, depth)";
			sql += " values(seq_reboard.nextval, ?, ?, ?, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reBoard.getWriter());
			pstmt.setString(2, reBoard.getTitle());
			pstmt.setString(3, reBoard.getContent());
			pstmt.setInt(4, reBoard.getTeam());
			pstmt.setInt(5, reBoard.getRank() + 1);
			pstmt.setInt(6, reBoard.getDepth() + 1);
			pstmt.executeUpdate();

			con.commit();
			result = 1;
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
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
}
