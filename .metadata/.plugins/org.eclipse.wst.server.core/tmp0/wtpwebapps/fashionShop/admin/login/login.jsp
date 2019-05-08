<%@page import="com.fashion.model.domain.Admin"%>
<%@page import="com.fashion.model.repository.AdminDAO"%>
<%@ page contentType="text/json; charset=UTF-8"%>
<%!AdminDAO adminDAO=new AdminDAO(); %>
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String pass=request.getParameter("pass");
	
	System.out.println(id);
	System.out.println(pass);
	Admin admin = new Admin();//전달용
	admin.setId(id);
	admin.setPass(pass);
	Admin obj=adminDAO.loginCheck(admin);
	
	if(obj==null){//결과 판단용
		out.print("{\"resultCode\":0}");
	}else{
		out.print("{\"resultCode\":1}");
		//로그인 성공한 유저에게 , 세션 객체에 접근할 기회를 주자!!!
		//session map을 구현했기 때문에 key-value
		session.setAttribute("admin", obj);
	}
%>










