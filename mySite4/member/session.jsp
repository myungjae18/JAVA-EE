<!--S
내장 객체 중 session 내장 객체를 학습한다
session : server와 client가 연결된 상태
			웹에서는 세션 유지가 불가능하다
			웹 HTTP(Hyper Text Trasfer Protocol) :
			전자문서를 주고 받는 방식을 사용하는 통신 방법
			stateless(상태가 없는 기반, 상태를 유지할 수 없음)
session을 유지하는 것처럼 보이는 방법 :
클라이언트의 브라우저가 웹사이트 요청을 시도할 때,
서버 측에 고유한 아이디를 생성하여 그 아이디를 클라이언트에게 
임시 저장
-->
<%@page contentType="text/html;charset=utf-8"%>
<%
	//서버가 이 요청에 대해서 발급한 세션 아이디 얻기
	String id=session.getId();
	out.print("당신이 발급받은 세션 아이디는 "+id);

	session.setAttribute("user", "nivelian");
	session.setAttribute("name", "신명재");
	session.setAttribute("age", "21세");
%>