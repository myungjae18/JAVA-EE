<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//이 요청과 관련한 세션을 무효화 시키고, 다시 로그인 폼을 요청하자!!
	session.invalidate();
	out.print("<script>");
	out.print("alert('로그아웃 되었습니다');");
	out.print("location.href='/admin/login';");
	out.print("</script>");
%>