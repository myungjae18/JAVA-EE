package com.itbank.db.pool;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

//설정 파일을 읽어들이기 위한 클래스
public class MybatisOracleManager {
	InputStream inputStream;
	SqlSessionFactory sqlSessionFactory;
	private static MybatisOracleManager instance;

	private MybatisOracleManager() {
		String resource = "mybatis/config/config.xml";
		try {
			inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// factory로부터 SqlSession 객체 하나 얻기
	public SqlSession getSession() {
		SqlSession sqlSession = null;
		sqlSession = sqlSessionFactory.openSession();
		return sqlSession;
	}

	// release 시키는 메서드
	public void release(SqlSession sqlSession) {
		sqlSession.close();
	}

	public static MybatisOracleManager getInstance() {
		if (instance == null) {
			instance = new MybatisOracleManager();
		}
		return instance;
	}
}
