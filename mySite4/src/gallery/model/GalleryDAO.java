package gallery.model;
import java.sql.*;
import java.util.ArrayList;
import db.pool.PoolManager;

/*웹 또는 응용 분야 모두에서 gallery table에 대한 CRUD를 수행 시
공통적으로 사용 가능한 모델 클래스를 정의해보자
소프트웨어 설계 분야에서는 이러한 객체를 가리켜 DAO라 한다
엔터프라이즈 개발자인 경우 데이터베이스에서 테이블 하나를 만들 때마다
이미 해당 테이블과 1대1 대응하는 DAO를 염두에 두어야 한다
로직은 없고, 오직 데이터를 담는 목적으로 정의되는 클래스를 가리켜 설계 분야에서는
DTO(Data Trasfer Object), VO(Value Object)로 부른다..
*/
public class GalleryDAO{
	PoolManager pool=PoolManager.getInstance();
	
	//갤러리에 글 1건 등록
	public void insert(Gallery gallery){
		Connection con=null;
		PreparedStatement pstmt=null;
		try{
			con=pool.getConnection();

			if(con!=null){
				System.out.println("접속 성공");
				String sql="insert into gallery(gallery_id, title, filename)";
				sql+=" values(seq_gallery.nextval, ?, ?)";
		
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, gallery.getTitle());
				pstmt.setString(2, gallery.getFileName());
				int result=pstmt.executeUpdate();

				if(result==0){
					System.out.println("등록 실패..");
				}else{
					System.out.println("등록 성공..");
				}
			}else{
				System.out.println("접속 실패..");
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			pool.freeConnection(con, pstmt);
		}
	}

	//모든 게시물 가져오기
	public ArrayList selectAll(){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList list=new ArrayList();
		
		System.out.println("게시물 목록을 가져오겠다..");
		
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
				//완성된 DTO 1개를 list에 탑재
				list.add(gallery);	
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			pool.freeConnection(con, pstmt, rs); //반납
		}
		return list; //jsp 측에서 사용하기 위해 반환
	}
	//데이터 1건 가져오기
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
			if(rs.next()){ //조회된 레코드가 있다면
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
