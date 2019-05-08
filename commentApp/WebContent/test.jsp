<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//JNDI의 동작 여부 확인...
	//정보가 xml에 들어있기 때문에 검색이 먼저 이루어져야 한다..
	//검색을 담당하는 객체가 InitialContext이다
	InitialContext context=new InitialContext();
	DataSource ds=(DataSource)context.lookup("java:comp/env/jdbc/oracle"); //검색 시작
	Connection con=ds.getConnection();
	String sql="select id from member1";
	PreparedStatement pstmt=con.prepareStatement(sql);
	ResultSet rs=pstmt.executeQuery();
	if(rs.next()){
		out.print(rs.getString("id"));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>