<%@page import="com.itbank.reboard.domain.ReBoard"%>
<%@page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="dao" class="com.itbank.reboard.model.ReBoardRepository"></jsp:useBean>
<%
	String reBoard_id=request.getParameter("reBoard_id");
	out.print(reBoard_id);
	ReBoard reBoard=dao.select(Integer.parseInt(reBoard_id));
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
		goReplyForm();
	})	;
});

$(function(){
	$("input[type=button]").click(function(){
		edit();
	});
})

//글 수정하기
function edit(){
	$("form").attr({
		"method":"post",
	});
	$("form").submit();
}

//글 삭제하기
function del(){
	
}

//답변 form 보기
function goReplyForm(){
	//replyForm.jsp 요청
	$("form").attr({
		"method":"post",
		"action":"/board/replyForm.jsp"
	});
	$("form").submit();
}
</script>
</head>
<body>

	<h3>Show Detail</h3>

	<div class="container">
		<form>
			<input type="hidden" name="team" value="<%=reBoard.getTeam()%>"/> 
			<input type="hidden" name="rank" value="<%=reBoard.getRank()%>"/> 
			<input type="hidden" name="depth" value="<%=reBoard.getDepth()%>"/> 
			<input type="text" name="writer" value="<%=reBoard.getWriter()%>"/> 
			<input type="text" name="title" value="<%=reBoard.getTitle()%>"/>
			<textarea name="content" style="height: 200px">
				<%=reBoard.getContent() %>
			</textarea>
			<input type="button" value="목록 보기" onClick="location.href='/board/list.jsp'"/>
			<input type="button" value="수정하기" id="bt-edit" onClick="edit()"/>
			<input type="button" value="삭제하기" id="bt-del" onClick="del()"/>
			<input type="button" value="답변 달기" id="bt-reply" onClick="goReplyForm()"/>
		</form>
	</div>

</body>
</html>
