<%@page contentType="text/html;charset=utf-8"%>
<%!
	String name="jsp"; //"멤버" 클래스에서만 사용되는 용어
	public int test(){
		return 10;
	}
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
<%
	int price=500;
	//application 내장 객체는 현재 웹어플리케이션의 전역적 정보를
	//알고 있기 때문에, 지정한 url에 대한 OS에 의존적인 full 경로를 반환해준다..
	//->Linux : 리눅스의 디스크를 기준으로 한 경로 반환
	//->Mac : Mac의 디스크를 기준으로 한 경로 반환
	String realPath=application.getRealPath("/data");
	out.print(realPath+"<br>");
	out.print(page.getClass().getName());
%>
<table border="1">
	<tr>
		<td>제목</td>
		<td>작성자</td>
		<td>등록일</td>
	</tr>
	<%for(int i=1;i<=10;i++){%>
	<tr>
		<td>제목</td>
		<td>작성자</td>
		<td>등록일</td>
	</tr>
	<%}%>
</table>
</body>
</html>
