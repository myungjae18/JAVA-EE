<%@page import="java.text.NumberFormat"%>
<%@page import="com.fashion.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.fashion.model.repository.ProductDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%! 
	ProductDAO productDAO = new ProductDAO();
%>
<%
	List<Product> productList=productDAO.selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<%@ include file="/admin/inc/head.jsp"%>
<script>
$(function(){
	$("button").click(function(){
		$(location).attr("href","/admin/product/");
	});
});
</script>
</head>
<body>
	<%@ include file="/admin/inc/header.jsp"%>
	<h2>Zebra Striped Table</h2>
	<p>For zebra-striped tables, use the nth-child() selector and add a
		background-color to all even (or odd) table rows:</p>

	<table>
		<tr>
			<th>No</th>
			<th>이미지</th>
			<th>카테고리</th>
			<th>상품명</th>
			<th>가격</th>
		</tr>
		<%int num=productList.size(); %>
		<%for(int i=0;i<productList.size();i++){%>
		<%Product product=productList.get(i); %>
		<tr>
			<td><%=num-- %></td>
			<td><img src="/data/<%=product.getFilename()%>" width="50px"/></td>
			<td><%=product.getSubcategory().getSub_name()%></td>
			<td><%=product.getProduct_name() %></td>
			<td><%=product.getPrice() %></td>
		</tr>
		<%}%>
		<tr>
			<td colspan="5">
				<button>상품등록</button>
			</td>
		</tr>

	</table>

</body>
</html>




