package member1.model;

//������ �繰�� ǥ���ϴ� Ŭ�����̳�, ������ �ۼ��ϱ� ������ �ƴ� �������� ���� Ŭ����
//����Ʈ���� ���迡�� DTO (Data Transfer Object), VO(Value Object)�� ��Ī�ϸ�, DAO�� ������ �� ���� ����
//�����ʹ� ������ �Ǿ� �־�� �Ѵ�.(����ȭ)
public class Member1 { //->DTO Ŭ�������� ��Ű������ ���󰣴�
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