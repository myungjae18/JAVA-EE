<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="member1.model.Member1DAO"%>
<%
	//이 jsp는 클라이언트인 html 문서가 전송한 파라미터 값들을 받아서 오라클에 넣는 서버 측 스크립트이다
	//out.print("오라클에 넣자");

	//파라미터 받기
	/*request 객체는 우리가 생성한 적도 없는데 에러가 나지 않는데 그 이유는 javaEE에서 지원하는 객체이고,
	메모리에 우리가 아닌 웹컨테이너인 Tomcat이 올린다.
	즉 개발자가 정의한 객체가 아니라 시스템이 지원하는 유형의 객체를 가리켜 내장 객체라 한다.
	내장 객체의 종류 : request, response...*/
	String id=request.getParameter("id");
	String password=request.getParameter("password");

	//DAO 생성
	Member1DAO dao=new Member1DAO();
	int result=dao.insert(id, password);

	if(result==0){
		out.print("등록 실패");
	}else{
		out.print("등록 성공!");
	}
%>