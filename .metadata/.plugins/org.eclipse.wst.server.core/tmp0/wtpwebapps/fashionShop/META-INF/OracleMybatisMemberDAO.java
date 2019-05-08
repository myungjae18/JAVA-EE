package com.itbank.model.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.itbank.db.pool.MybatisOracleManager;
import com.itbank.model.domain.Member;

//이 클래스는 여전히 DAO 이다, 단 CRUD를 jdbc가 아닌 mybatis를
//사용할 뿐이다..
public class OracleMybatisMemberDAO implements MemberDAO{
	MybatisOracleManager manager=MybatisOracleManager.getInstance();
	
	public int insert(Member member) {
		int result=0;
		//매니저로부터 세션을 얻는다?? SqlSession 의 역할? 쿼리 수행객체
		SqlSession sqlSession=manager.getSession();
		result=sqlSession.insert("Member.insert", member);
		sqlSession.commit();//트랜잭션 확정 DML(insert, update, delete)
		manager.release(sqlSession);
		return result;
	}
	public List selectAll(){
		List list=null;
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













