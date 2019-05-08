<%@page import="com.itbank.comments.model.Comments"%>
<%@page import="java.util.List"%>
<%@page import="com.itbank.comments.model.CommentsDAO"%>
<%@page import="com.itbank.board.model.Board"%>
<%@page import="com.itbank.board.model.BoardDAO"%>
<%@page contentType="text/html;charset=utf-8"%>
<%
	String board_id=request.getParameter("board_id");
	out.print(board_id);
	BoardDAO boardDAO=new BoardDAO();
	boardDAO.increment(Integer.parseInt(board_id));
	Board board=boardDAO.select(Integer.parseInt(board_id));
	
	CommentsDAO commentsDAO=new CommentsDAO();
	List<Comments> list=commentsDAO.selectAll(Integer.parseInt(board_id));
%>
<!DOCTYPE html>
<html>
<head>
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
.reply{
   border:1px solid #eee;
}
#cwriter{
   display:inline-block;
   background:yellow;
   width:20%;
}
#msg{
   display:inline-block;
   background:yellow;
   width:75%;
}

.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}
</style>
<script 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="./Comments.js"></script>
<script>
$(function(){
	$("#bt-reply").click(function(){
		sendSync(); //동기 요청
	})

	$("#bt-reply2").click(function(){
		sendASync(); //비동기 요청
	})
});

//댓글 등록 요청
function sendSync(){
	$("form[name='reply-form']").attr({
		"method":"post",
		"action":"/comments/regist2.jsp"
	});
	$("form[name='reply-form']").submit();
}

//비동기로 요청을 시도
//비동기 통신을 위해서는 AJAX 객체가 필요한데, 객체명은 HttpXMLRequest이다
function sendASync(){
	var xhttp=new XMLHttpRequest();
	
	xhttp.open("POST", "/comments/regist2.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	
	//요청과 응답 상태를 알 수 있는 이벤트 구현
	
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			//alert("서버의 응답 결과 메세지는"+xhttp.responseText);
			var json=JSON.parse(xhttp.responseText);
			
			//alert("작성자는 "+json.commentsList[0].cwriter);
			//for(var i=0;i<json.commentsList.size();i++){
				//$("[id='cwriter']").val(json.comments.getCwriter());
				//$("[id='msg']").val(json.comments.getMsg());
			//}
			$("#reply-container").html(""); //기존 내용 리셋
			for(var i=0;i<json.commentsList.length;i++){
				var obj=json.commentsList[i];
				var ct=new Comments(obj.comments_id, obj.cwriter, obj.msg);
				$("#reply-container").append(ct.getStr());
			}
		}
	};
	xhttp.send("board_id="+$("[name='board_id']").val()+"&cwriter=" + $("[name='cwriter']").val() + "&msg="+ $("[name='msg']").val());
}

function del(){
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	$("[name='board-form']").attr({
		"method":"post",
		"action":"/board/delete.jsp"
	});
	$("[name='board-form']").submit();
}

function edit(){
	if(!confirm("수정하시겠습니까?")){
		return;
	}
	$("[name='board-form']").attr({
		"method":"post",
		"action":"/board/edit.jsp"
	});
	$("[name='board-form']").submit();
}
</script>
</head>
<body>

	<h3>상세 내용</h3>

	<div class="container">
		<form name="board-form">
			<input type="hidden" name="board_id" placeholder="작성자 입력" value="<%=board.getBoard_id()%>"> 
			<input type="text" name="writer" placeholder="작성자 입력" value="<%=board.getWriter()%>"> 
			<input type="text" name="title" placeholder="제목 입력" value="<%=board.getTitle()%>">
			<textarea name="content" placeholder="내용 입력" style="height: 200px">
			<%=board.getContent() %>
			</textarea>
			<input type="button" id="bt-board" value="등록 하기">
			<input type="button" id="bt-list" value="목록 보기" onClick="location.href='list.jsp'">
			<input type="button" id="bt-edit" value="수정하기"  onClick="edit()">
			<input type="button" id="bt-delete" value="삭제하기" onclick="del()">
			
		<!-- 댓글 등록 영역 -->	
		</form>
		<form name="reply-form">
				<input type="hidden" name="board_id" style="width:20%" value="<%=board.getBoard_id()%>">
				<input type="text" name="cwriter" style="width:20%" placeholder="작성자 입력"> 
				<input type="text" name="msg" style="width:40%" placeholder="제목 입력">
				<input type="button" id="bt-reply" style="width:7%" value="등록(sync)">
			<input type="button" id="bt-reply2" style="width:7%" value="등록(async)">
		</form>
	</div>
	
	<!-- 댓글 목록 -->
	<div id="reply-container">
		<%for(int i=0;i<list.size();i++){ %>
		<%Comments comments=list.get(i); %>
		<div class="reply">
			<div id="cwriter"><%=comments.getCwriter() %></div>
			<div id="msg"><%=comments.getMsg() %></div>
		</div>
		<%} %>
	</div>

</body>
</html>
