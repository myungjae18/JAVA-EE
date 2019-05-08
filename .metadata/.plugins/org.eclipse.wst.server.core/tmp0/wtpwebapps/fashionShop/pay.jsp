<%@page import="java.util.List"%>
<%@page import="com.fashion.model.domain.Product"%>
<%@page import="com.fashion.model.domain.OrderDetail"%>
<%@page import="com.fashion.model.repository.OrderDetailDAO"%>
<%@page import="com.fashion.model.repository.OrderSummaryDAO"%>
<%@page import="com.fashion.model.domain.OrderSummary"%>
<%@page import="com.fashion.model.domain.Customer"%>
<%@page import="com.fashion.common.Formatter"%>
<%@page import="com.fashion.model.domain.Paymethod"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/inc/header.jsp"%>
<%!OrderSummaryDAO summaryDAO = new OrderSummaryDAO();
	OrderDetailDAO detailDAO = new OrderDetailDAO();%>
<%
	request.setCharacterEncoding("utf-8");

	String[] product_id = request.getParameterValues("product_id");
	String[] ea = request.getParameterValues("ea");
	String total_buy = request.getParameter("total_buy");
	String total_pay = request.getParameter("total_pay");
	String paymethod_id = request.getParameter("paymethod_id");
	String sender = request.getParameter("sender");
	String bank = request.getParameter("bank");
	String email = request.getParameter("email");

	Customer cs = (Customer) session.getAttribute("customer");

	System.out.println("total_buy는 " + total_buy);
	System.out.println("total_pay는 " + total_pay);
	System.out.println("paymethod_id는 " + paymethod_id);
	System.out.println("customer_id는  " + cs.getCustomer_id());
	System.out.println("sender는  " + sender);
	System.out.println("bank는  " + bank);
	System.out.println("email은  " + email);

	//insert
	OrderSummary summary = new OrderSummary();
	Paymethod paymethod = new Paymethod();

	summary.setCustomer(cs);
	summary.setTotal_buy(Integer.parseInt(total_buy));
	summary.setTotal_pay(Integer.parseInt(total_pay));
	paymethod.setPaymethod_id(Integer.parseInt(paymethod_id));
	summary.setPaymethod(paymethod);

	int key = summaryDAO.insert(summary);

	if (key != 0) {
		//주문 상세 정보 입력
		int result=detailDAO.insert(summary, product_id, ea);
		if(result==0){
			out.print("주문 등록 실패");
		}else{
			out.print("주문 등록 성공");
			//장바구니 지우기...
			
			//메일 발송...
		}
	} else {
		out.print("summary 실패");
	}
%>