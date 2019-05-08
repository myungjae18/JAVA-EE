<%@ page contentType="text/html;charset=utf-8"%>
<%!
	int x=3; //멤버변수

	public String test(){
		return "apple";
	}
%>
<%
	out.print("멤버변수 x의 값은 "+x); //브라우져에 출력
	out.print("<br>");
	out.print(test());
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
<script>
var url;
var user="adams";
var password="1234";
function getMsg(){
	alert("나 불렀니");
}
<%//getMsg();%>
</script>
</head>
<body>
</body>
</html>
