<%@ page contentType="text/html;charset=utf-8"%>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Document</title>
	</head>
	<body>
	<%
		out.print("사과");
	%>
	<%="오렌지"%>
	<%for(int i=1;i<=100;i++){%>
		2*<%=i%>=<%=2*i%><br>
	<%}%>
	</body>
</html>
