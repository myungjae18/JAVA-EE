<!--
jsp는 9가지의 내장 객체를 지원한다
	-내장(built-in) 객체란 개발자가 생성 및 선언한 객체가 아니라
	시스템 즉 Tomcat과 같은 웹 컨테이너 서버가 생성 및 정의해놓은 객체를 말한다.
	따라서 이미 준비되어 있다(메모리에 올라와 있다).
	jsp는 개발자가 자바 언어에 대한 지식이 없어도 개발할 수 있도록 제공되는 스크립트 언어이다.
	(asp, php와 경쟁하기 위해서)
	따라서 자세한 처리를 숨겨놓고 내장 객체를 사용하여 개발을 보조해준다.

	1) request 객체
		클라이언트의 요청 정보를 가진 객체
	2) response 객체
		클라이언트에게 응답 시 필요한 정보를 가진 객체
	3) session 객체
		stateless 기반인 http의 한계를 극복하기 위해
		서버 측에 저장되는 데이터를 담는 객체
	4) pageContext 객체
		현재 페이지와 관련된 Context 정보를 가진 객체
	5) out 객체
		클라이언트 브라우저의 출력을 담당하는 스트림 객체
	6) application 객체
		서버의 전역적 정보를 담고 있는 객체
	7) config 객체
		서블릿의 초기화 파라미터 정보를 담고 있는 객체
	8) page 객체
		jsp는 결국 서블릿으로 변환되는데, 이 서블릿 인스턴스를 표현한 객체
	9) exception 객체
-->
<%@ page contentType="text/html;charset=utf-8"%>
<%
	/*내장 객체 중 request 객체를 실습해본다
	클라이언트가 서버에 regist.jsp를 요청할 때, 함께 파라미터 값들이
	변수와 함께 전송되어져 오고 있으므로, 그 값을 받아보자
	요청할 때 전송되는 정보들은 당연히 요청 객체가 가지고 있다
	*/
	String id=request.getParameter("id"); //인수에는 파라미터 변수명을 기입
	String pw=request.getParameter("pw");
	String age=request.getParameter("age");
	out.print("your id : "+id+"<br>your password : "+pw+"<br>your age : "+age);

	//내장 객체 중 response 객체를 사용해본다
	//응답 시 해줘야 할 각종 기능들을 갖고 있다
	//response.sendRedirect("./result.jsp"); //클라이언트로 하여금 지정한 url로 다시 들어오게 하는 메서드
%>




