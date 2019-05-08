package member1.model;
import java.sql.*;

/*
이름은 자유이지만, 전세계 개발자들이 데이터베이스를 연결하는 쿼리문이 들어 있는 객체들에 붙이는 이름이 따로 있다.
->DAO(Data Access Object)
CRUD 메서드들을 정의한다
->Create(=insert), Read(=select), Update, Delete
*/
public class Member1DAO {
	//레코드 한 건 입력
	//throws는 이 메서드를 호출한 객체에게 예외처리를 전가하겠다는 뜻이다
	public int insert(Member1 member1){
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;

		try{
			//드라이버 로드 (jar)
			Class.forName("oracle.jdbc.driver.OracleDriver");

			//오라클 접속
			String url="jdbc:oracle:thin:@192.168.0.28:1521:XE";
			con=DriverManager.getConnection(url, "web", "web");
			
			if(con==null){
				System.out.println("접속 실패..");
			}else{
				System.out.println("접속 성공!");
			}

			String sql="insert into member1(member1_id, id, password)";
			sql+=" values(seq_member1.nextval, ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member1.getId());
			pstmt.setString(2, member1.getPassword());
			result=pstmt.executeUpdate();
		} catch(ClassNotFoundException e){
			e.printStackTrace();
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			if(pstmt!=null){
				try{
					pstmt.close();
				} catch(SQLException e){
					e.printStackTrace();
				}
			}
			if(con!=null){
				try{
					con.close();
				} catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
		return result;
	}
}
