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
#event {
	background-color: #4CAF50;
}
</style>
<body>
	<div>
		<h2>Event Management</h2>
	</div>
	<div>
		<form class="example" action="action_page.php">
			<input type="text" placeholder="Search.." name="search">
			<button type="submit">
				<i class="fa fa-search"></i>
			</button>
		</form>
	</div>

	<table>
		<tr>
			<th>Event Price</th>
			<th>Event Name</th>
			<th>Invoked Games</th>
			<th>Discount</th>
		</tr>
		<%for(int i=0; i<2; i++){ %>
		<tr>
			<td>Jill</td>
			<td>Smith</td>
			<td>
				<select>
					<option>게임1</option>
					<option>게임2</option>
					<option>게임3</option>
					<option>게임4</option>
				</select>
			</td>
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
