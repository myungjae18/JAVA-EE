package com.itbank.db.pool;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/*
ConnectionPool�� connection�� �����ϸ鼭 connection�� ��ȯ�ϵ�
�� Ŭ������ SqlSession�� �����ϸ鼭 SqlSession�� ��ȯ���ִ�
SqlSessionFactory�� ��� ���� ��ǥ�̴�
�׷��� SqlSessionFactory�� ����� ���� ������ xml�� ��������Ƿ�
xml�� stream���� �о�鿩 �ؼ��� �� ���������� SqlSessionFactory��
��������. ���� �� Ŭ�����κ��� ������� SqlSessionFactory��
application scope�� �ϴ� ���� �޸� ȿ�� �� ����ǹǷ�, ��Ŭ������ �����ϴ� ���� ����.
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
	
	//SqlSession ���
	public SqlSession getSqlSession() {
		return factory.openSession();
	}
	
	//SqlSession �ݱ�
	public void release(SqlSession sqlSession) {
		sqlSession.close();
	}
}
