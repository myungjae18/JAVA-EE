<%@page import="com.fashion.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.fashion.model.domain.Customer"%>
<%@page import="com.fashion.model.repository.CartDAO"%>
<%@page import="com.fashion.model.domain.Cart"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!CartDAO cartDAO = new CartDAO();%>
<%
	//장바구니 변경 후 다시 갱신된 내용 보여주기
	Customer cs = (Customer) session.getAttribute("customer");
	String topcategory_id = request.getParameter("topcategory_id");
	String[] product_id = request.getParameterValues("product_id");
	String[] ea = request.getParameterValues("ea");
	List<Cart> cartList = cartDAO.selectByCustomer(cs.getCustomer_id());
	Cart[] cart = new Cart[product_id.length];

	for (int i = 0; i < cartList.size(); i++) {
		Product product = new Product();
		product.setProduct_id(Integer.parseInt(product_id[i]));
		cart[i] = cartList.get(i);
		cart[i].setCustomer(cs);
		cart[i].setProduct(product);
		cart[i].setEa(Integer.parseInt(ea[i]));
	}
	int result = cartDAO.updateEa(cart);

	out.print("<script>");
	if (result != 0) {
		out.print("alert('성공');");
		out.print("location.href='cart.jsp?topcategory_id=" + topcategory_id + "';");
	} else {
		out.print("alert('실패');");
		out.print("history.back();");
	}
	out.print("</script>");
%>