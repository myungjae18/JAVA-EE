/*웹 어플리케이션 분야에서 클라이언트 요청이 있을 때마다 데이터베이스 접속하여,
쿼리문 실행 후 힘들게 얻은 접속을 닫게 된다면, 동시 사용자가 많은 때에
동시 사용자가 많은 때에 데이터베이스 서버에 무리가 간다. 왜냐하면 접속은
리소스를 많이 필요로 하며 네트워크를 타고 진행되기 때문에 사용자가 많을수록
소요 시간이 길어진다..
해결책) 커넥션 풀링(Connection Pooling) 기법을 사용
	커넥션 풀링 기법이란 웹 서버에 클라이언트의 요청이 없어도, 미리 메모리 공간에
	다수의 Connection 객체를 확보하고 요청이 있을 때마다 해당 클라이언트가
	사용할 Connection 객체를 대여해주는 기법을 말한다..
	클라이언트의 요청에 의해 쿼리문이 수행된 후, 접속 객체는 닫지 않고 다시 pool로
	돌려보내어 접속으로 인한 부하를 감소시키는 노하우
		-모든 WAS, Container 자체적으로 지원까지 한다...
주의) 풀매니져는 메모리 인스턴스를 몇 개 만들어야 할까? -> 오직 1개
개발자가 안전 장치를 마련하는 방법은?
	-94년도 Gang of four (4명의 갱단)이 개발한 Design Pattern (설계 패턴)
	->개발자들이 흔히 사용하는 개발 방법, 습관, 패턴 등을 정리해서 이름을 붙임
		1)싱클턴 패턴 (SingleTon Pattern)
			-클래스로부터 생성되는 인스턴스를 한 개로 제한하는 패턴
*/
/**
------------------------------------------------------
1.풀 메니져의 사용 목적 
------------------------------------------------------
- 데이터베이스 "접속"이라는 작업자체는 많은 시간과 리소스를 요구한다.
  따라서 일단 얻어진 커넥션을 매번 버리지 말고 재사용함으로써 자원의 효율성을 극대화 한다.

------------------------------------------------------
2.설정해 줘야 할것 !!
------------------------------------------------------
1.드라이버 패키지 설정 : private String _driver = "org.gjt.mm.mysql.Driver",
2.DB 사용자 계정 설정:  _url   = "jdbc:mysql://localhost:3306/study",
                                _user = "아이디",
                                _password = "패스워드";
------------------------------------------------------
3.사용되는 메서드
------------------------------------------------------
getInstance() : 커넥션 풀 객체를 얻어옴
getConnection() : 커넥션 객체 얻어옴
freeConnection() : 유형에 맞게 자원 반납
 */
package db.pool;

import java.sql.*;
import java.util.Properties;
import java.util.Vector;

/**
 * Manages a java.sql.Connection pool.
 *
 * @author Anil Hemrajani
 */
public class PoolManager {
	private Vector connections = new Vector(10);
	private String _driver = "oracle.jdbc.driver.OracleDriver", _url = "jdbc:oracle:thin:@localhost:1521:XE",
			_user = "web", _password = "web";
	private boolean _traceOn = false;
	private boolean initialized = false;
	private int _openConnections = -1;
	private static PoolManager instance = null;

	public PoolManager() {
	}

	/**
	 * 1단계: 커넥션 풀 객체를 얻어옵니다.
	 */
	public static PoolManager getInstance() {
		if (instance == null) {
			synchronized (PoolManager.class) {
				if (instance == null) {
					instance = new PoolManager();
				}
			}
		}

		return instance;
	}

	public void setOpenConnectionCount(int count) {
		_openConnections = count;
	}

	public void setEnableTrace(boolean enable) {
		_traceOn = enable;
	}

	/** Returns a Vector of java.sql.Connection objects */
	public Vector getConnectionList() {
		return connections;
	}

	/** Opens specified "count" of connections and adds them to the existing pool */
	public synchronized void setInitOpenConnections(int count) throws SQLException {
		Connection c = null;
		ConnectionObject co = null;

		for (int i = 0; i < count; i++) {
			c = createConnection();
			co = new ConnectionObject(c, false);

			connections.addElement(co);
			trace("ConnectionPoolManager: Adding new DB connection to pool (" + connections.size() + ")");
		}
	}

	/** Returns a count of open connections */
	public int getConnectionCount() {
		return connections.size();
	}

	/**
	 * Returns an unused existing or new connection. 2단계: 커넥션 객체를 얻어옵니다.
	 */
	public synchronized Connection getConnection() throws Exception {
		if (!initialized) {
			Class c = Class.forName(_driver);
			DriverManager.registerDriver((Driver) c.newInstance());

			initialized = true;
		}

		Connection c = null;
		ConnectionObject co = null;
		boolean badConnection = false;

		for (int i = 0; i < connections.size(); i++) {
			co = (ConnectionObject) connections.elementAt(i);

			// If connection is not in use, test to ensure it's still valid!
			if (!co.inUse) {
				try {
					badConnection = co.connection.isClosed();
					if (!badConnection)
						badConnection = (co.connection.getWarnings() != null);
				} catch (Exception e) {
					badConnection = true;
					e.printStackTrace();
				}

				// Connection is bad, remove from pool
				if (badConnection) {
					connections.removeElementAt(i);
					trace("ConnectionPoolManager: Remove disconnected DB connection #" + i);
					continue;
				}

				c = co.connection;
				co.inUse = true;

				trace("ConnectionPoolManager: Using existing DB connection #" + (i + 1));
				break;
			}
		}

		if (c == null) {
			c = createConnection();
			co = new ConnectionObject(c, true);
			connections.addElement(co);

			trace("ConnectionPoolManager: Creating new DB connection #" + connections.size());
		}

		return c;
	}

	/**
	 * Marks a flag in the ConnectionObject to indicate this connection is no longer
	 * in use 3단계 : 유형에 맞게 자원을 반납합니다.
	 */
	public synchronized void freeConnection(Connection c) {
		if (c == null)
			return;

		ConnectionObject co = null;

		for (int i = 0; i < connections.size(); i++) {
			co = (ConnectionObject) connections.elementAt(i);
			if (c == co.connection) {
				co.inUse = false;
				break;
			}
		}

		for (int i = 0; i < connections.size(); i++) {
			co = (ConnectionObject) connections.elementAt(i);
			if ((i + 1) > _openConnections && !co.inUse)
				removeConnection(co.connection);
		}
	}

	public void freeConnection(Connection c, PreparedStatement p, ResultSet r) {
		try {
			if (r != null)
				r.close();
			if (p != null)
				p.close();
			freeConnection(c);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void freeConnection(Connection c, Statement s, ResultSet r) {
		try {
			if (r != null)
				r.close();
			if (s != null)
				s.close();
			freeConnection(c);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void freeConnection(Connection c, PreparedStatement p) {
		try {
			if (p != null)
				p.close();
			freeConnection(c);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void freeConnection(Connection c, Statement s) {
		try {
			if (s != null)
				s.close();
			freeConnection(c);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Marks a flag in the ConnectionObject to indicate this connection is no longer
	 * in use
	 */
	public synchronized void removeConnection(Connection c) {
		if (c == null)
			return;

		ConnectionObject co = null;
		for (int i = 0; i < connections.size(); i++) {
			co = (ConnectionObject) connections.elementAt(i);
			if (c == co.connection) {
				try {
					c.close();
					connections.removeElementAt(i);
					trace("Removed " + c.toString());
				} catch (Exception e) {
					e.printStackTrace();
				}

				break;
			}
		}
	}

	private Connection createConnection() throws SQLException {
		Connection con = null;

		try {
			if (_user == null)
				_user = "";
			if (_password == null)
				_password = "";

			Properties props = new Properties();
			props.put("user", _user);
			props.put("password", _password);

			con = DriverManager.getConnection(_url, props);
		} catch (Throwable t) {
			throw new SQLException(t.getMessage());
		}

		return con;
	}

	/** Closes all connections and clears out the connection pool */
	public void releaseFreeConnections() {
		trace("ConnectionPoolManager.releaseFreeConnections()");

		Connection c = null;
		ConnectionObject co = null;

		for (int i = 0; i < connections.size(); i++) {
			co = (ConnectionObject) connections.elementAt(i);
			if (!co.inUse)
				removeConnection(co.connection);
		}
	}

	/** Closes all connections and clears out the connection pool */
	public void finalize() {
		trace("ConnectionPoolManager.finalize()");

		Connection c = null;
		ConnectionObject co = null;

		for (int i = 0; i < connections.size(); i++) {
			co = (ConnectionObject) connections.elementAt(i);
			try {
				co.connection.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			co = null;
		}

		connections.removeAllElements();
	}

	private void trace(String s) {
		if (_traceOn)
			System.err.println(s);
	}

}

class ConnectionObject {
	public java.sql.Connection connection = null;
	public boolean inUse = false;

	public ConnectionObject(Connection c, boolean useFlag) {
		connection = c;
		inUse = useFlag;
	}
}
