package common.file;

//웹이건 독립 실행형 응용프로그램이건 앞으로 File과 관련된 공통 로직은 이 클래스에서 처리
public class FileManager{
	//확장자를 반환하는 메서드
	public static String getExt(String path){
		int lastIndex=path.lastIndexOf(".");
		return path.substring(lastIndex+1, path.length());
	}
}
