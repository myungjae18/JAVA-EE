<%@page contentType="text/html;charset=utf-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
<script>
addEventListener("load", function(){
	var bt=document.querySelector("button");
	
	bt.addEventListener("click", function(){
		send();
	});
});

//서버에 선택한 영화에 대한 판단을 요청하자
function send(){
	form1.action="/movie";
	//form1.action="advice.jsp";
	form1.method="get"; // 요청 헤더
	form1.submit();
}
</script>
</head>
<body>
	<form name="form1">
		<select name="movie">
			<option>Select Movie</option>
			<option value="극한 직업">극한 직업</option>
			<option value="사바하">사바하</option>
			<option value="뺑반">뺑반</option>
		</select>
	</form>
	<button>판단 요청</button>
</body>
</html>
