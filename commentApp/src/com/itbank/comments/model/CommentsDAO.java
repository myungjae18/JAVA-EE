package com.itbank.comments.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.itbank.db.pool.PoolManager;

public class CommentsDAO {
	Logger logger = Logger.getLogger(this.getClass().getName());
	PoolManager pool = PoolManager.getInstance();

	// 댓글 한 건 등록
	public int insert(Comments comments) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			String sql = "insert into comments(comments_id, board_id, cwriter, msg)";
			sql += " values(seq_comments.nextval, ?, ?, ?)";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comments.getBoard_id());
			pstmt.setString(2, comments.getCwriter());
			pstmt.setString(3, comments.getMsg());

			result = pstmt.executeUpdate();
			logger.debug(result);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt);
		}

		return result;
	}

	// 상세 보기의 글에 등록된 댓글만 가져오기
	public List selectAll(int board_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Comments> list = new ArrayList<Comments>();

		try {
			String sql = "select * from comments where board_id=?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Comments comments = new Comments();
				comments.setComments_id(rs.getInt("comments_id"));
				comments.setBoard_id(rs.getInt("board_id"));
				comments.setCwriter(rs.getString("cwriter"));
				comments.setMsg(rs.getString("msg"));
				comments.setCregdate(rs.getString("cregdate"));

				list.add(comments);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.release(con, pstmt, rs);
		}
		return list;
	}
}
