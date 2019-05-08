package member1.model;

//현실의 사물을 표현하는 클래스이나, 로직을 작성하기 위함이 아닌 정보만을 담을 클래스
//소프트웨어 설계에서 DTO (Data Transfer Object), VO(Value Object)라 지칭하며, DAO를 생성할 때 같이 생성
//데이터는 보안이 되어 있어야 한다.(은닉화)
public class Member1 { //->DTO 클래스명은 패키지명을 따라간다
	private int member1_id;
	private String id;
	private String password;

	public int getMember1_id(){
		return member1_id;
	}
	public void setMember1_id(int member1_id){
		this.member1_id=member1_id;
	}
	public String getId(){
		return id;
	}
	public void setId(String id){
		this.id=id;
	}
	public String getPassword(){
		return password;
	}
	public void setPassword(String password){
		this.password=password;
	}	
}	 