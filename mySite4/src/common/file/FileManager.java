package common.file;

//���̰� ���� ������ �������α׷��̰� ������ File�� ���õ� ���� ������ �� Ŭ�������� ó��
public class FileManager{
	//Ȯ���ڸ� ��ȯ�ϴ� �޼���
	public static String getExt(String path){
		int lastIndex=path.lastIndexOf(".");
		return path.substring(lastIndex+1, path.length());
	}
}
