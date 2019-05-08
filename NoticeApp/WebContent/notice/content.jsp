<%@page import="notice.model.Notice"%>
<%@page import="notice.model.NoticeDAO"%>
<%@page contentType="text/html;charset=utf-8"%>
<%!
	NoticeDAO noticeDAO=new NoticeDAO();
%>
<%
	int notice_id=Integer.parseInt(request.getParameter("notice_id"));
	Notice notice=noticeDAO.select(notice_id);
	int result=noticeDAO.increment(notice);
	if(result==0){
		out.print("조회 수 증가 실패..");
	}
%>
<!DOCTYPE html>
<html>
<%@ include file="/inc/header.jsp" %>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//cdn.ckeditor.com/4.11.3/standard/ckeditor.js"></script>
<script>
$(function(){
	init();
});
function init() {
	CKEDITOR.replace('content');
	$("#bt_edit").click(function(){
		edit();
	});
	$("#bt_del").click(function(){
		del();
	});
}

function edit(){
	//수정 동의 안하면 함수 빠져나가기
	if(!confirm("수정하시겠습니까?")){
		return;
	}
	
	$("form").attr({
		"method":"post",
		"action":"/notice/edit.jsp"
	});
	$("form").submit();
}

function del(){
	//삭제 동의 안하면 함수 빠져나가기
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	
	$("form").attr({
		"method":"post",
		"action":"/notice/delete.jsp"
	});
	$("form").submit();
}		
</script>
</head>
<body onLoad="init()">

	<h3>Show Detail</h3>

	<div class="container">
		<form>
			<input type="hidden" id="name" name="notice_id" value="<%=notice.getNotice_id()%>">
			<input type="text" id="fname" name="writer" value="<%=notice.getWriter()%>">
			<input type="text" id="lname" name="title" value="<%=notice.getTitle()%>">
			<textarea id="content" name="content" style="height: 200px">
			<%=notice.getContent()%>
			</textarea>
			<input type="button" id="bt_edit" value="Edit">
			<input type="button" id="bt_del" value="Delete">
			<input type="button" id="bt_list" value="List" onClick="location.href='/notice/list.jsp'">
		</form>
	</div>

</body>
</html>
