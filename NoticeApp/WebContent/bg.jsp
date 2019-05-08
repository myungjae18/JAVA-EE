<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String bg="pink";
	if(request.getParameter("sel")!=null){
		bg=request.getParameter("sel");
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택한 배경색 적용하기</title>
<script>
function send(){
	//서버에 존재하는 bg.jsp를 요청하되 그냥 가지 말고 파라미터 값을 가지고 가본다
	//즉 요청 시 파라미터 값을 가지고 요청하자..
	form1.action="bg.jsp"; //주소
	form1.method="get"; //전송 방법
	form1.submit();
}
</script>
</head>
<body bgcolor="<%=bg%>">
	<form name="form1">
		<select name="sel">
			<option>배경색 선택</option>
			<option value="yellow" <%if(bg.equals("yellow")){ %>selected<%}%>>yellow</option>
			<option value="red" <%if(bg.equals("red")){%>selected<%}%>>red</option>
			<option value="green" <%if(bg.equals("green")){%>selected<%}%>>green</option>
		</select>
	</form>
	<button onClick="send()">전송</button>
</body>
</html>