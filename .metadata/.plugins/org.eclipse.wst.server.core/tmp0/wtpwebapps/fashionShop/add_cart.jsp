<%@page import="com.fashion.model.domain.Customer"%>
<%@page import="com.fashion.model.domain.Product"%>
<%@page import="com.fashion.model.domain.Cart"%>
<%@page import="com.fashion.model.repository.CartDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!CartDAO cartDAO = new CartDAO();%>
<%
	//클라이언트의 장바구니 담기 요청을 처리한다
	String ea = request.getParameter("ea"); //how much
	String product_id = request.getParameter("product_id"); //what

	Product product = new Product();
	Cart cart = new Cart();

	product.setProduct_id(Integer.parseInt(product_id));

	//로그인한 유저로부터 session을 통해 customer_id 추출
	Customer customer = (Customer) session.getAttribute("customer");
	cart.setProduct(product);
	cart.setCustomer(customer);
	cart.setEa(Integer.parseInt(ea));

	//장바구니에 이미 동일한 상품이 담겨있을 경우 레코드를 증가시키지 말고 갯수를 증가시킨다
	Cart ct = cartDAO.selectByProductId(cart);
	int result = 0;
	if (ct != null) { //이미 등록된 상품이 있다면 -> 갯수를 update
		result = cartDAO.updateCart(ct.getCart_id());
	} else { //아닐 경우 insert
		result = cartDAO.insert(cart);
	}
	out.print(result);
%>