<%@ page contentType="text/html;charset=utf-8"%>
<!--
	jsp코드를 작성 영역
	1. 지시 영역 : 문서 형식, 인코딩, 임포트
		ex) [%@ %]
	2. 선언부 : 멤버변수, 멤버메서드 영역
		ex) [%! %]
		주의) jsp를 html과 섞어 써서 마치 클래스와 무관해 보이지만,
		javaEE조차 자바의 기반기술이므로 클래스를 피해갈 수 없다
			->jsp는 사실 자바의 클래스이다
	3. 스크립틀릿 영역 : 로직을 작성하는 영역
							jsp가 클래스로 변경될 때,  service()메서드의 영역
		ex) [% int x=3;%] == service(){ int x=3; }
	4. 표현식 : 스크립틀릿 영역에서 사용되는 out.print()를 단축하여 표기하는 영역
		ex) [%="apple"%]
		주의) 세미콜론 넣으면 에러남
-->
<%!
	String[] arr={"1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"};
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
<script>

</script>
</head>
<body>
<%for(int i=0;i<arr.length;i++){%>
	<img src="/asset/images/geo/<%
	=arr[i]%>"/>
<%}%>
</body>
</html>
