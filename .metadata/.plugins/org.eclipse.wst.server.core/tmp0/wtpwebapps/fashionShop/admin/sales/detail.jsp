<%@page import="com.fashion.common.Formatter"%>
<%@page import="com.fashion.model.domain.OrderDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.fashion.model.repository.OrderDetailDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!OrderDetailDAO detailDAO = new OrderDetailDAO();%>
<%
	String order_summary_id = request.getParameter("order_summary_id");
	List<OrderDetail> orderList = detailDAO.selectAllByFkey(Integer.parseInt(order_summary_id));
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<link rel="stylesheet" type="text/css"
	href="/admin/static/css/main-nav.css" />
<style>
table {
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	border: 1px solid #ddd;
}

th, td {
	text-align: left;
	padding: 16px;
}

tr:nth-child(even) {
	background-color: #f2f2f2
}
</style>
</head>
<body>
	<%@ include file="/admin/inc/header.jsp"%>
	<h2>결제 내역</h2>
	<table>
		<tr>
			<th>주문 번호</th>
			<th>상품명</th>
			<th>상품 가격</th>
			<th>수량</th>
			<th>소계</th>
		</tr>
		<%
			int sum = 0;
			for (int i = 0; i < orderList.size(); i++) {
		%>
		<%
			OrderDetail orderDetail = orderList.get(i);
		%>
		<tr>
			<th><%=orderDetail.getOrder_detail_id()%></th>
			<th><%=orderDetail.getProduct().getProduct_name()%></th>
			<th><%=Formatter.getCurrency(orderDetail.getProduct().getPrice())%></th>
			<th><%=orderDetail.getEa()%></th>
			<th><%=Formatter.getCurrency(orderDetail.getProduct().getPrice() * orderDetail.getEa())%></th>
		</tr>
		<%
			sum += orderDetail.getProduct().getPrice() * orderDetail.getEa();
		%>
		<%
			}
		%>
		<tr>
			<td>합계: <%=sum%>
			</td>
		</tr>
	</table>


</body>
</html>
