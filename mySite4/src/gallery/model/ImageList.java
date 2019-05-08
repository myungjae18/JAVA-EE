package gallery.model;
import java.util.ArrayList;

public class ImageList{
	private ArrayList<String> list=new ArrayList();
	public ArrayList getList(){
		return list;
	}
	public void setList(String fileName){
		list.add(fileName);
	}
}
