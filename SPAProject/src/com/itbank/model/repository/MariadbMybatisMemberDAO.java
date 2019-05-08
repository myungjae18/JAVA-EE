package com.itbank.model.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.itbank.db.pool.MybatisMariadbManager;
import com.itbank.model.domain.Member;

public class MariadbMybatisMemberDAO implements MemberDAO {
	MybatisMariadbManager manager = MybatisMariadbManager.getInstance();

	public int insert(Member member) {
		int result = 0;
		SqlSession sqlSession = null;

		sqlSession = manager.getSqlSession();
		result = sqlSession.insert("Member.insert", member);
		sqlSession.commit();
		manager.release(sqlSession);

		return result;
	}

	public List selectAll() {
		List<Member> list = null;
		SqlSession sqlSession = null;

		sqlSession = manager.getSqlSession();
		list = sqlSession.selectList("Member.selectAll");
		manager.release(sqlSession);
		
		return list;
	}

	public Member select(int member_id) {
		// TODO Auto-generated method stub
		return null;
	}

	public int update(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int delete(int member_id) {
		// TODO Auto-generated method stub
		return 0;
	}
}
