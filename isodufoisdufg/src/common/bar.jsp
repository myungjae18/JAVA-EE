<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GameShop Admin</title>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

.navbar {
	width: 100%;
	background-color: #555;
	overflow: auto;
}

.navbar a {
	width: 15%;
	float: left;
	color: white;
	text-decoration: none;
	font-size: 17px;
	padding-top: 8px;
	padding-bottom: 15px;
	padding-left: 10px;
}

.navbar img {
	width: 30px;
	height: auto;
}

@media screen and (max-width: 500px) {
	.navbar a {
		float: none;
		display: block;
	}
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<div class="navbar">
		<a id="member" href="/admin/member/member.jsp"><img src="/images/bar/member.png">&nbsp 회원 관리</a>
		<a id="game" href="/admin/game/game.jsp"><img src="/images/bar/game.png">&nbsp 상품 관리</a> 
		<a id="chart" href="/admin/sales/chart.jsp"><img src="/images/bar/chart.png">&nbsp 매출 현황</a> 
		<a id="table" href="/admin/sales/table.jsp"><img src="/images/bar/table.png">&nbsp 매출 관리</a> 
		<a id="event" href="/admin/event/event.jsp"><img src="/images/bar/event.png">&nbsp 이벤트 관리</a>
	</div>
</body>
</html>