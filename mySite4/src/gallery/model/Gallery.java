package gallery.model;

public class Gallery{
	private int gallery_id;
	private String title;
	private String fileName;

	public int getGallery_id(){
		return gallery_id;
	}
	public String getTitle(){
		return title;
	}
	public String getFileName(){
		return fileName;
	}
	public void setGallery_id(int gallery_id){
		this.gallery_id=gallery_id;
	}
	public void setTitle(String title){
		this.title=title;
	}
	public void setFileName(String fileName){
		this.fileName=fileName;
	}
}
