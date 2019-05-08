<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	DiskFileItemFactory factory = new DiskFileItemFactory();
%>
<%
	String realPath=application.getRealPath("/upload");
	out.print(realPath);
	
	ServletFileUpload upload=new ServletFileUpload(factory);
	List<FileItem> items=upload.parseRequest(request);
	
	for(int i=0;i<items.size();i++){
		FileItem item=items.get(i);
		if(item.isFormField()){
			//out.print("텍스트 필드입니다<br>");
		}else{
			String fieldName = item.getFieldName();
			String fileName = item.getName();
			String contentType = item.getContentType();
			//out.print("파일형식:"+contentType.split("/")[1]);
			boolean isInMemory = item.isInMemory();
			long sizeInBytes = item.getSize();
			
			File file=new File(realPath+"/"+1234546+"."+contentType.split("/")[1]);
			item.write(file);
			item.delete();
			out.print("<img src=\"/upload/123456.png\"/>");
		}
	}
%>