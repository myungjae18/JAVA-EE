package member1.model;
import java.sql.*;

/*
�̸��� ����������, ������ �����ڵ��� �����ͺ��̽��� �����ϴ� �������� ��� �ִ� ��ü�鿡 ���̴� �̸��� ���� �ִ�.
->DAO(Data Access Object)
CRUD �޼������ �����Ѵ�
->Create(=insert), Read(=select), Update, Delete
*/
public class Member1DAO {
	//���ڵ� �� �� �Է�
	//throws�� �� �޼��带 ȣ���� ��ü���� ����ó���� �����ϰڴٴ� ���̴�
	public int insert(Member1 member1){
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;

		try{
			//����̹� �ε� (jar)
			Class.forName("oracle.jdbc.driver.OracleDriver");

			//����Ŭ ����
			String url="jdbc:oracle:thin:@192.168.0.28:1521:XE";
			con=DriverManager.getConnection(url, "web", "web");
			
			if(con==null){
				System.out.println("���� ����..");
			}else{
				System.out.println("���� ����!");
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
