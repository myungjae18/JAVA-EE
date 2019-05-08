<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/header.jsp" %>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//cdn.ckeditor.com/4.11.3/standard/ckeditor.js"></script>
<script>
$(function(){
	init();
});
function init() {
	CKEDITOR.replace('content');
	$("input[type='button']").click(function(){
		send();
	});
}
function send(){
	$("form").attr({
		"method":"post",
		"action":"/notice/regist.jsp"
	});
	$("form").submit();
}
</script>
</head>
<body onLoad="init()">

	<h3>Contact Form</h3>

	<div class="container">
		<form>
			<input type="text" id="fname" name="writer" placeholder="작성자 입력">
			<input type="text" id="lname" name="title" placeholder="제목 입력">
			<textarea id="content" name="content" placeholder="내용 입력"	style="height: 200px">
			</textarea>
			<input type="button" value="Submit">
		</form>
	</div>

</body>
</html>
