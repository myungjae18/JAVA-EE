<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.itbank.reboard.domain.ReBoard"%>
<%
	String team=request.getParameter("team");
	String rank=request.getParameter("rank");
	String depth=request.getParameter("depth");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}

input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
}

input[type=button] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=button]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}
</style>
<script 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	$("#bt-reply").click(function(){
		reply();
	});
});

function reply(){
	$("form").attr({
		"method":"post",
		"action":"/board/reply.jsp"
	});
	$("form").submit();
}

</script>
</head>
<body>

	<h3>Write Reply</h3>

	<div class="container">
		<form>
			<input type="hidden" name="team" value="<%=team%>"/> 
			<input type="hidden" name="rank" value="<%=rank%>"/> 
			<input type="hidden" name="depth" value="<%=depth%>"/> 
			<input type="text" name="writer" placeholder="name"/> 
			<input type="text" name="title" placeholder="title"/>
			<textarea name="content" style="height: 200px" placeholder="reply">
			</textarea>
			<input type="button" value="목록 보기" onClick="history.back()"/>
			<input type="button" value="답변 달기" id="bt-reply" onClick="reply()"/>
		</form>
	</div>

</body>
</html>
