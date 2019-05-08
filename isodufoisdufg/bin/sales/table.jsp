<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="/admin/common/bar.jsp"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ include file="/admin/common/tableStyle.jsp"%>
</head>
<style>
#table {
	background-color: #4CAF50;
}
</style>
<body>
	<div>
		<h2>Sales Management</h2>
	</div>
	<div>
		<p class="total">총 매출액 : 100,000원</p>

		<form class="example" action="action_page.php">
			<input type="text" placeholder="Search.." name="search">
			<button type="submit">
				<i class="fa fa-search"></i>
			</button>
		</form>
	</div>

	<table>
		<tr>
			<th>상품 이름</th>
			<th>상품 가격</th>
			<th>판매 개수</th>
			<th>판매 총액</th>
		</tr>
		<%for(int i=0; i<5; i++){ %>
		<tr>
			<td>Jill</td>
			<td>Smith</td>
			<td>50</td>
			<td>50</td>
		</tr>
		<%} %>
		<tr>
			<td colspan="4">
				<%for(int i=1; i<=10; i++){ %> 
					[<%=i %>] 
				<%} %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<button>등록</button>
			</td>
		</tr>
	</table>

</body>
</html>
