package notice.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import db.pool.PoolManager;

public class NoticeDAO {
	PoolManager pool = PoolManager.getInstance();

	// �� �� �� ���
	public int insert(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = pool.getConnection();
			if (con != null) {
				System.out.println("���� ����");
				String sql = "insert into notice(notice_id, writer, title, content)";
				sql += " values(seq_notice.nextval, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, notice.getWriter());
				pstmt.setString(2, notice.getTitle());
				pstmt.setString(3, notice.getContent());

				result = pstmt.executeUpdate();
				if (result == 0) {
					System.out.println("��� ����");
				} else {
					System.out.println("��� ����..");
				}
			} else {
				System.out.println("���� ����");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}

	// ��� �Խù� ��������
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

				// DTO�� list�� ���
				list.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}

	// data record �� �� ��������
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

	// ���ڵ� �� �� ��������
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

	// ���ڵ� ���� ó��
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
	
	//��ȸ�� ����
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
