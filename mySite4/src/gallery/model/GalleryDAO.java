package gallery.model;
import java.sql.*;
import java.util.ArrayList;
import db.pool.PoolManager;

/*�� �Ǵ� ���� �о� ��ο��� gallery table�� ���� CRUD�� ���� ��
���������� ��� ������ �� Ŭ������ �����غ���
����Ʈ���� ���� �о߿����� �̷��� ��ü�� ������ DAO�� �Ѵ�
������������ �������� ��� �����ͺ��̽����� ���̺� �ϳ��� ���� ������
�̹� �ش� ���̺�� 1��1 �����ϴ� DAO�� ���ο� �ξ�� �Ѵ�
������ ����, ���� �����͸� ��� �������� ���ǵǴ� Ŭ������ ������ ���� �о߿�����
DTO(Data Trasfer Object), VO(Value Object)�� �θ���..
*/
public class GalleryDAO{
	PoolManager pool=PoolManager.getInstance();
	
	//�������� �� 1�� ���
	public void insert(Gallery gallery){
		Connection con=null;
		PreparedStatement pstmt=null;
		try{
			con=pool.getConnection();

			if(con!=null){
				System.out.println("���� ����");
				String sql="insert into gallery(gallery_id, title, filename)";
				sql+=" values(seq_gallery.nextval, ?, ?)";
		
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, gallery.getTitle());
				pstmt.setString(2, gallery.getFileName());
				int result=pstmt.executeUpdate();

				if(result==0){
					System.out.println("��� ����..");
				}else{
					System.out.println("��� ����..");
				}
			}else{
				System.out.println("���� ����..");
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			pool.freeConnection(con, pstmt);
		}
	}

	//��� �Խù� ��������
	public ArrayList selectAll(){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList list=new ArrayList();
		
		System.out.println("�Խù� ����� �������ڴ�..");
		
		try{
			con=pool.getConnection();
			String sql="select * from gallery order by gallery_id asc";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();

			while(rs.next()){
				Gallery gallery=new Gallery();
				gallery.setGallery_id(rs.getInt("gallery_id"));
				gallery.setTitle(rs.getString("title"));
				gallery.setFileName(rs.getString("filename"));
				//�ϼ��� DTO 1���� list�� ž��
				list.add(gallery);	
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			pool.freeConnection(con, pstmt, rs); //�ݳ�
		}
		return list; //jsp ������ ����ϱ� ���� ��ȯ
	}
	//������ 1�� ��������
	public Gallery select(int gallery_id){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Gallery gallery=new Gallery();

		try{
			con=pool.getConnection();
			String sql="select * from gallery where gallery_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, gallery_id);
			rs=pstmt.executeQuery();
			if(rs.next()){ //��ȸ�� ���ڵ尡 �ִٸ�
				gallery.setGallery_id(rs.getInt("gallery_id"));
				gallery.setTitle(rs.getString("title"));
				gallery.setFileName(rs.getString("filename"));
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			pool.freeConnection(con, pstmt, rs);
		}
		return gallery;
	}
}
