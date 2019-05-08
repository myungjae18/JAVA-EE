package db.pool;

//아래의 클래스의 인스턴스를 오직 1개만 허용하도록 제한 장치를 마련한다
public class Dog{
	private static Dog instance;
	//방어
	private Dog(){}
	//생성자를 게터로
	public static Dog getInstance(){ //new 안해도 접근 가능
		if(instance==null){
			instance=new Dog();
		}
		return instance;
	}
}
