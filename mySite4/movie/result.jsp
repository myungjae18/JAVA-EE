<%@page contentType="text/html;charset=utf-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
당신이 선택한 영화에 대한 최종 평가 :
<br>
<%
	//컬렉션 프레임웍에서 Map과 동일하게 key-value의 쌍으로 데이터를
	//심을 수 있다.. 따라서 데이터를 넣을 때 Object형으로 들어간다..
	String msg=(String)request.getAttribute("data");
%>
<%=msg%>
</body>
</html>
