<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%
	String path="D:/Java_developer/javaEE/mySite4/upload";
	//request.setCharacterEncoding("utf-8"); //다국어 인코딩
	//int maxSize=1024*1024*23; //23MB
	//MultipartRequest multi=new MultipartRequest(request, path);
	//String imgName=multi.getOriginalFileName("image");
	//String[] name=request.getParameterValues("good");
	String name=request.getParameter("good");

	
	for(int i=0;i<name.length;i++){
		out.print(name[i]);
	}
	
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
<style>
div{
	width:500px;
	margin:auto;
}
#title{
	height:60px;
	background:yellow;
	font-size:30px;
	text-align:center;
}
#content{
	height:500px;
	background:red;
}
#bt_area{
	text-align:center;
}
button{
	width:80px;
	height:30px;
	font-size:20px;
}
</style>
</head>
<body>
<form enctype="multipart/form-data">
	<div id="title">
		<%=name%>
	</div>
</form>
<div id="content">
	나는 이미지
</div>
<div id="bt_area">
	<button>목록</button>
</div>
</body>
</html>
