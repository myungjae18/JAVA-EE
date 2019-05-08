package db.pool;

//싱클턴 패턴 클래스~
public class UseDog{
	public static void main(String[] args) {
		Dog d1=Dog.getInstance();
		Dog d2=Dog.getInstance();

		System.out.println(d1);
		System.out.println(d2);
	}
}
