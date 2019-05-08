<%@page contentType="text/html;charset=utf-8"%>
<%
	/*현재 요청 클라이언트가 이전에 브라우저를 닫지 않고, 즉 세션을 유지하고
	이 페이지를 요청했다면 아직 세션 아이디를 사용할 수 있는 상태이므로
	이 세션 아이디를 이용하여 서버에 존재하는 세션들 중 id가 같은 객체를
	추출하여 그 정보를 꺼내어 알맞는 처리를 해보자*/
	String user=(String)session.getAttribute("user");
	String name=(String)session.getAttribute("name");
	String age=(String)session.getAttribute("age");
	out.print(user);
	out.print(name);
	out.print(age);
%>
<!DOCTYPE html>
<html>
<head>
<meta chatset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
  font-family: Arial, Helvetica, sans-serif;
  background-color: black;
}

* {
  box-sizing: border-box;
}

/* Add padding to containers */
.container {
  padding: 16px;
  background-color: white;
}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Overwrite default styles of hr */
hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

/* Set a style for the submit button */
.registerbtn {
  background-color: #4CAF50;
  color: white;
  padding: 16px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
}

.registerbtn:hover {
  opacity: 1;
}

/* Add a blue text color to links */
a {
  color: dodgerblue;
}

/* Set a grey background color and center the text of the "sign in" section */
.signin {
  background-color: #f1f1f1;
  text-align: center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
/*jQuery는 javascript 코드를 간략화시켜놓은 라이브러리이다
따라서 사용을 위해서는 우리가 그 라이브러리를 가지고 있어야 하는데,
보유 방식
1) 직접 소스를 다운로드 받는 방법
2) 링크를 통해 받는 법
*/
function init(){
	//alert("문서 로드했다!!");
	//버튼을 누르면..
	$("button").click(function(){
		send();
	});
}
//서버에 입력 양식을 전송한다
function send(){
	//유효성 확인
	if($("form :input[name='id']").val()==""){
		alert("아이디좀 입력하자;");
		return;
	}
	//자바 분야에서는 속성은 property이지만, html에서는 attribute라 한다
	$("form").attr("action", "/member/regist.jsp");
	$("form").submit(); //전송
}
/*변수명으로 쓸 수 없는 것들 : 특수문자, 숫자는 변수명으로 시작할 수 없다
->예외 : $, _(underBar)
CSS 문법구조 : 누구를 어떻게 할 지
div(선택자){background:yellow}*/

/*jQuery는 javascript library이지만, 선택자는 CSS의 선택자를 따르기 때문에,
특정 객체를 지적할 때 기존에 우리가 알고 있었던 CSS 지식으로 접근하면 된다
id 접근 시 : #id명
클래스 접근 시 : .클래스명 ex) $(."kk")
이름 : 그냥 태그명*/
$(document).ready(function(){
	init();
}); //문서가 로드되면
</script>
</head>
<body>
<div class="container">
<h1>회원 가입</h1>
<hr>
<form>
<%if(user==null){%>
	<input type="text" placeholder="아이디 입력" name="id" required>
<%}else{%>
	<%=user+"님 로그인 중"%>
<%}%>
	<input type="password" placeholder="패스워드 입력" name="pw" required>
	<input type="text" placeholder="생년월일 입력" name="age" required>
</form>
<hr>
	<button type="button" class="registerbtn">Register</button>
</div>
	<div class="container signin">
</div>
</body>
</html>
