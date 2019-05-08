<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
<%@page import="common.file.FileManager"%>
<%@page import="gallery.model.Gallery"%>
<%@page import="gallery.model.GalleryDAO"%>
<%@page import="gallery.model.ShowImage"%>
<%
	//클라이언트가 전송한 파라미터 값들을 받아오되, 이 값들 중 파일의 데이터도 있다
	
	//request는 요청 정보를 담고 있는 객체이다
	//요청을 받을 때 한글이 깨지지 않도록 인코딩 메서드 호출
	request.setCharacterEncoding("utf-8"); //다국어 인코딩
	
	//클라이언트가 보낸 파일을 서버에 정해진 디렉토리에 저장하자 -> 'upload'
	int maxSize=1024*1024*23; //23MB
	String path=application.getRealPath("/data");
	
	//새로운 jar나 클래스코드가 변경되면 tomcat 서버를 재가동해야 한다..
	MultipartRequest multi=new MultipartRequest(request, path, maxSize, "utf-8"); //생성자 호출 시 업로드됨
	String title=multi.getParameter("title");
	//String myFile=request.getParameter("myFile"); //텍스트 데이터가 아니기 때문에 getParameter()론 받을 수 없다
	
	//방금 업로드된 파일은 유저에 의해 이름이 컴퓨터 상 호환성이 떨어질수도 있으니 개발자 주도하에
	//파일명을 변경해보자
	//변경 규칙은 개발자 나름이다(우리는 현재 시간으로 시도해본다)
	long time=System.currentTimeMillis();
	out.print(time);
	File uploadedFile=multi.getFile("myFile");
	out.print(uploadedFile);

	//파일명을 대상으로 확장자 추출
	//원리 : 마지막 점이 발견된 다음 문자부터 문자열의 끝까지 추출
	//전체 문자열에서 하위 문자열을 추출하는 것을 프로그래밍 언어에서는 substring이라 함
	String myFile=multi.getOriginalFileName("myFile"); //html의 파라미터명
	String ext=FileManager.getExt(myFile);

	String newFile=path+File.separator+time+"."+ext;
	String fileName=time+"."+ext; //오라클에 등록할 파일 이름
	uploadedFile.renameTo(new File(newFile));
	/////////////////////////////////////////////////////////////////////////////////
	//File file=new File(myFile);
	//int num=myFile.lastIndexOf(".");
	//String newName=myFile.substring(num);
	//String finalName=time+newName;
	//file.renameTo(finalName);
	//out.print(finalName);
	/////////////////////////////////////////////////////////////////////////////////
	
	GalleryDAO galleryDAO=new GalleryDAO();
	Gallery gallery=new Gallery();

	gallery.setTitle(title);
	gallery.setFileName(fileName);
	galleryDAO.insert(gallery);

	//클라이언트의 브라우저로 하여금 지정한 url로 재접속을 강제시키는
	//response 내장 객체의 메서드를 사용
	response.sendRedirect("/gallery/list.jsp");
	////////////////////////////////////////////////////////////////////////////////
	ShowImage showImage=new ShowImage();
	String imgName=multi.getParameter("title");

	imgName.setImgFileName(imgName);
%>