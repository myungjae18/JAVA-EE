package com.itbank.db.pool;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/*
ConnectionPool이 connection을 관리하면서 connection을 반환하듯
이 클래스는 SqlSession을 관리하면서 SqlSession을 반환해주는
SqlSessionFactory를 얻는 것이 목표이다
그러나 SqlSessionFactory를 만들기 위한 정보가 xml에 들어있으므로
xml을 stream으로 읽어들여 해서한 후 최종적으로 SqlSessionFactory를
생성하자. 또한 이 클래스로부터 얻어지는 SqlSessionFactory는
application scope로 하는 것이 메모리 효율 상 권장되므로, 싱클턴으로 정의하는 것이 좋다.
*/
public class MybatisMariadbManager {
	private static MybatisMariadbManager instance;
	SqlSessionFactory factory;
	InputStream is;

	private MybatisMariadbManager() {
		try {
			String path = "mybatis/config/mariadb-config.xml";
			is = Resources.getResourceAsStream(path);
			factory = new SqlSessionFactoryBuilder().build(is);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static MybatisMariadbManager getInstance() {
		if (instance == null) {
			instance = new MybatisMariadbManager();
		}
		return instance;
	}
	
	//SqlSession 얻기
	public SqlSession getSqlSession() {
		return factory.openSession();
	}
	
	//SqlSession 닫기
	public void release(SqlSession sqlSession) {
		sqlSession.close();
	}
}
