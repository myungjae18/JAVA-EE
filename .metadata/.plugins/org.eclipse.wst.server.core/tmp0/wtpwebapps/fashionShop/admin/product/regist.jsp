<%@page import="com.fashion.model.domain.Subcategory"%>
<%@page import="java.io.File"%>
<%@page import="com.fashion.common.FileManager"%>
<%@page import="com.fashion.model.repository.ProductDAO"%>
<%@page import="com.fashion.model.domain.Product"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!ProductDAO productDAO = new ProductDAO();%>
<%
	//넘겨받은 파라미터 값을 이용해서 오라클 데이터베이스에 등록 및 파일 처리를 한다
	//모든 작업 후, 목록으로... 업로드는 클라이언트가 보낸 텍스트 파라미터 뿐만 아니라, 일반 바이너리 파일이 포함되므로 기존 request.getParameter() 로는 처리가 불가...
	//스트림 처리가 포함되어야함...따라서 개발자가 직접 코드를 작성하면 생산성이 떨어지므로 잘 만들어진 외부 라이브러리르 이용하자!
	//오레일리사의 cos.jar , apache의 commons fileupload를 경험해본다
	//cos jar는 생성자에서 이미 업로드가 완료된다!!

	//getRealPath() 사용 이유? 웹 어플리케이션이 특정 os에서 수행되는 것을 방지하기 위함..즉 특정 자원의 풀 경로를 하드코딩 하지말고, 해당 시스템의 환경에 따라 동적으로 구하여 처리하자!!
	//윈도우, 리눅스에 맞게...
	String saveDir = application.getRealPath("/data"); //저장경로
	out.print(saveDir + "<br>");
	int maxSize = 5 * 1024 * 1024; //업로드 용량 제한 3MB
	String encoding = "utf-8";

	MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, encoding);
	//함께 전송되어온 파라미터를 받으려면 평상시의 request.getParameter() 동작 불가
	String subcategory_id = multi.getParameter("subcategory_id");
	String product_name = multi.getParameter("product_name");
	String price = multi.getParameter("price");
	String detail = multi.getParameter("detail");

	out.print(subcategory_id + "<br>");
	out.print(product_name + "<br>");
	out.print(price + "<br>");
	out.print(detail + "<br>");

	Product product = new Product(); //파라미터 담을 dummy dto
	Subcategory subcategory = new Subcategory();

	subcategory.setSubcategory_id(Integer.parseInt(subcategory_id));
	product.setSubcategory(subcategory);

	product.setProduct_name(product_name);
	product.setPrice(Integer.parseInt(price));
	product.setDetail(detail);
	product.setFilename(multi.getOriginalFileName("myFile"));

	/*
	   db에 넣기에 앞서, 파일명을 개발자가 지정한 규칙으로 변경한다
	   2019013912312311.jpg
	*/
	long time = System.currentTimeMillis();
	String ext = FileManager.getExt(multi.getOriginalFileName("myFile"));
	String destFile = time + "." + ext;
	out.print("최종 파일명은" + destFile);

	//실제 저장되어 있는 파이르이 이름을 변경해야 한다!!
	File file = multi.getFile("myFile");
	file.renameTo(new File(saveDir + "/" + destFile));
	product.setFilename(destFile); //DTO의 파일명 교체

	int result = productDAO.insert(product);

	//list 요청
	response.sendRedirect("/admin/product/list.jsp");
%>