package db.pool;

//��Ŭ�� ���� Ŭ����~
public class UseDog{
	public static void main(String[] args) {
		Dog d1=Dog.getInstance();
		Dog d2=Dog.getInstance();

		System.out.println(d1);
		System.out.println(d2);
	}
}
