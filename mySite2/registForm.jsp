<%@ page contentType="text/html;charset=utf-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
<script>
var form1=document.getElementById("form1");
function registOracle(){
	/*oracle과 연동이 가능할까
	자바스크립트가 훌륭한 기능을 갖고는 있으나 서버 측이 아니라 클라이언트 측에서 실행되는 코드이기 때문에 로컬 pc 상에서
	그 소스를 전부 볼 수 있다. 따라서 보안이 불가능하다.
	해결책) 직접적으로 오라클에 입력이 불가능하므로, 서버에 넣어달라고 요청하면 된다.*/
	form1.action="/regist.jsp"; // '/'는 현재 폴더 경로를 의미
	form1.submit(); //전송 행위가 일어난다
}
function registMySQL(){
	form1.action="/regist2.jsp"; // '/'는 현재 폴더 경로를 의미
	form1.submit(); //전송 행위가 일어난다
}
</script>
</head>
<body>
	<!-- form 태그의 역할 : 서버에 요청 시 전송 대상을 설정할 수 있다 -->
	<form id="form1">
		<input type="text" name="id" placeholder="아이디를 입력"/><br>
		<input type="password" name="pw" placeholder="비밀번호를 입력"/><br>
	</form>
	<button onClick="registOracle()">오라클에 등록</button>
	<button onClick="registMySQL()">MySQL에 등록</button>
</body>
</html>
