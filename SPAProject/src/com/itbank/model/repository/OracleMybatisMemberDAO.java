package com.itbank.model.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.itbank.db.pool.MybatisOracleManager;
import com.itbank.model.domain.Member;

//이 클래스는 여전히 DAO이다.단 CRUD를 jdbc가 아닌 mybatis를 사용할 뿐이다..
public class OracleMybatisMemberDAO implements MemberDAO{
	MybatisOracleManager manager = MybatisOracleManager.getInstance();

	public int insert(Member member) {
		SqlSession sqlSession = null;
		int result = 0;

		sqlSession = manager.getSession();
		result = sqlSession.insert("Member.insert", member);
		sqlSession.commit();
		
		return result;
	}
	
	public List selectAll() {
		List<Member> list=null;
		SqlSession sqlSession=manager.getSession();
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
