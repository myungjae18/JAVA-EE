<%@page import="com.fashion.common.DuplicatedException"%>
<%@page import="com.fashion.model.repository.CustomerDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!CustomerDAO customerDAO = new CustomerDAO();%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="customer" class="com.fashion.model.domain.Customer" />
<jsp:setProperty property="*" name="customer" />
<%
	try {
		customerDAO.checkId(customer);
		//가입 성공했으므로 진행
		int result = customerDAO.insert(customer);
		if (result != 0) {
			out.print("<script>");
			out.print("alert('회원 가입이 완료되었습니다!\\n가입한 정보로 로그인해주세요.');");
			out.print("location.href='/';");
			out.print("</script>");
		}
	} catch (DuplicatedException e) {
		out.print("<script>");
		out.print("alert('" + e.getMessage() + "');");
		out.print("history.back();");
		out.print("</script>");
	}
%>