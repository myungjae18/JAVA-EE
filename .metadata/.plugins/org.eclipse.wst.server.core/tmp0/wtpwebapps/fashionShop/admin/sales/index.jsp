<%@page import="com.fashion.model.domain.OrderSummary"%>
<%@page import="java.util.List"%>
<%@page import="com.fashion.model.repository.OrderSummaryDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!OrderSummaryDAO summaryDAO = new OrderSummaryDAO();%>
<%
	List<OrderSummary> summaryList = summaryDAO.selectAll();
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
<script>
	function getDetail(id) {
		location.href = "/admin/sales/detail.jsp?order_summary_id="+id;
	}
</script>
</head>
<body>
	<%@ include file="/admin/inc/header.jsp"%>
	<h2>결제 내역</h2>
	<table>
		<tr>
			<th>주문 번호</th>
			<th>고객명</th>
			<th>주문 금액</th>
			<th>결제 금액</th>
			<th>주문일</th>
			<th>결제 방법</th>
		</tr>
		<%
			for (int i = 0; i < summaryList.size(); i++) {
		%>
		<%
			OrderSummary summary = summaryList.get(i);
		%>
		<tr onClick="getDetail(<%=summary.getOrder_summary_id()%>)"
			style="cursor: pointer">
			<th><%=summary.getOrder_summary_id()%></th>
			<th><%=summary.getCustomer().getName()%></th>
			<th><%=summary.getTotal_buy()%></th>
			<th><%=summary.getTotal_pay()%></th>
			<th><%=summary.getOrder_date()%></th>
			<th><%=summary.getPaymethod().getName()%></th>
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>
