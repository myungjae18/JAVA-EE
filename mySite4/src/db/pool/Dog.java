package db.pool;

//�Ʒ��� Ŭ������ �ν��Ͻ��� ���� 1���� ����ϵ��� ���� ��ġ�� �����Ѵ�
public class Dog{
	private static Dog instance;
	//���
	private Dog(){}
	//�����ڸ� ���ͷ�
	public static Dog getInstance(){ //new ���ص� ���� ����
		if(instance==null){
			instance=new Dog();
		}
		return instance;
	}
}
