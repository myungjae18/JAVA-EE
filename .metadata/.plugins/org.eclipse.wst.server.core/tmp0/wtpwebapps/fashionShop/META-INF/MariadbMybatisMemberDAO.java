package com.itbank.model.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.itbank.db.pool.MybatisMariadbManager;
import com.itbank.model.domain.Member;

public class MariadbMybatisMemberDAO implements MemberDAO{
	MybatisMariadbManager manager=MybatisMariadbManager.getInstance();
	
	//µî·Ï 
	public int insert(Member member) {
		int result=0;
		SqlSession sqlSession=manager.getSqlSession();
		result=sqlSession.insert("Member.insert", member);
		sqlSession.commit();//DML Àº Ä¿¹Ô!!!
		manager.release(sqlSession);
		return result;
	}

	@Override
	public List selectAll() {
		List list=null;
		SqlSession sqlSession=manager.getSqlSession();
		list=sqlSession.selectList("Member.selectAll");
		manager.release(sqlSession);
		return list;
	}

	@Override
	public Member select(int member_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int member_id) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}















