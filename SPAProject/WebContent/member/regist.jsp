<%@page import="com.itbank.model.repository.MemberDAO"%>
<%@page import="com.itbank.model.repository.MariadbMybatisMemberDAO"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!Logger logger = Logger.getLogger(this.getClass().getName());
	//MemberDAO memberDAO = new MemberDAO();
	//OracleMybatisMemberDAO myDAO = new OracleMybatisMemberDAO();
	MemberDAO myDAO = new MariadbMybatisMemberDAO();%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="com.itbank.model.domain.Member" />
<jsp:setProperty property="*" name="member" />
<%
	//클라이언트의 파라미터를 넘겨 받아 오라클에 넣자
	//참고로 서버 측에서는 클라이언트에 적용된 기술이 무엇인지 관심을 가져선 안된다..
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");

	logger.debug("id는 " + id);
	logger.debug("password는 " + password);
	logger.debug("name은 " + name);

	member.setId(id);
	member.setPassword(password);
	member.setName(name);

	int result = myDAO.insert(member);

	if (result == 0) {
		out.print("실패");
		response.sendError(500, "서버 측에 심각한 오류가 발생하였습니다...");
	} else {
		out.print("성공");
	}
%>