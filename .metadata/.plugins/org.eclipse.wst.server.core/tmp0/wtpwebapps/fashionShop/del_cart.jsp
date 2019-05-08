<%@page import="com.fashion.model.repository.CartDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!CartDAO cartDAO=new CartDAO(); %>
<%
	//배열로 넘어오는 파라미터값들을 받아서 장바구니 안의 상품 1개 이상 삭제
	String[] cart_id=request.getParameterValues("cart_id");
	String topcategory_id=request.getParameter("topcategory_id");
	
	for(int i=0;i<cart_id.length;i++){
		out.print(cart_id[i]+"<br>");
		cartDAO.delete(Integer.parseInt(cart_id[i]));
	}
	response.sendRedirect("/cart.jsp?topcategory_id="+topcategory_id);
%>