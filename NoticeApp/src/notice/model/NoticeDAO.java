package notice.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import db.pool.PoolManager;

public class NoticeDAO {
	PoolManager pool = PoolManager.getInstance();

	// 글 한 건 등록
	public int insert(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();
			if (con != null) {
				System.out.println("접속 성공");
				String sql = "insert into notice(notice_id, writer, title, content)";
				sql += " values(seq_notice.nextval, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, notice.getWriter());
				pstmt.setString(2, notice.getTitle());
				pstmt.setString(3, notice.getContent());

				result = pstmt.executeUpdate();
				if (result == 0) {
					System.out.println("등록 실패");
				} else {
					System.out.println("등록 성공..");
				}
			} else {
				System.out.println("접속 실패");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}

	// 모든 게시물 가져오기
	public ArrayList selectAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList list = new ArrayList();

		try {
			con = pool.getConnection();
			String sql = "select * from notice order by notice_id desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Notice notice = new Notice();
				notice.setNotice_id(rs.getInt("notice_id"));
				notice.setWriter(rs.getString("writer"));
				notice.setTitle(rs.getString("title"));
				notice.setContent(rs.getString("content"));
				notice.setRegdate(rs.getString("regdate"));
				notice.setHit(rs.getInt("hit"));

				// DTO를 list에 담기
				list.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}

	// data record 한 건 가져오기
	public Notice select(int notice_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Notice notice = null;

		try {
			con = pool.getConnection();
			String sql = "select * from notice where notice_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				notice = new Notice();
				notice.setNotice_id(rs.getInt("notice_id"));
				notice.setWriter(rs.getString("writer"));
				notice.setTitle(rs.getString("title"));
				notice.setContent(rs.getString("content"));
				notice.setRegdate(rs.getString("regdate"));
				notice.setHit(rs.getInt("hit"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return notice;
	}

	// 레코드 한 건 가져오기
	public int update(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();

			String sql = "update notice set writer=?, title=?, content=?";
			sql += " where notice_id=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, notice.getWriter());
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getContent());
			pstmt.setInt(4, notice.getNotice_id());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}

	// 레코드 삭제 처리
	public int delete(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();

			String sql = "delete from notice where notice_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice.getNotice_id());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}
	
	//조회수 증가
	public int increment(Notice notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;
		
		try {
			con=pool.getConnection();
			String sql="update notice set hit=hit+1 where notice_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, notice.getNotice_id());
			
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}
}
