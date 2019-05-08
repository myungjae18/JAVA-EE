<%@page import="com.fashion.model.domain.Customer"%>
<%@page import="com.fashion.model.repository.CustomerDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!CustomerDAO customerDAO = new CustomerDAO();%>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");

	Customer customer = new Customer();
	customer.setId(id);
	customer.setPass(pass);
	Customer cs = customerDAO.login(customer);
	
	if (cs == null) {
		out.print("<script>");
		out.print("alert('로그인 정보가 올바르지 않습니다.');");
		out.print("history.back();");
		out.print("</script>");
	} else {
		session.setAttribute("customer", cs);
		out.print("<script>");
		out.print("alert('로그인 성공!');");
		out.print("location.href='/';");
		out.print("</script>");
	}
%>