<%@page import="test.Dept"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.fashion.mybatis.config.ConfigManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%! ConfigManager manager=ConfigManager.getInstance(); %>
<%
	SqlSession sql=manager.getSqlSession();
	List<Dept> deptList=sql.selectList("Dept.selectAll");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	for(int i=0;i<deptList.size();i++){
		Dept dept=deptList.get(i);
		out.print("부서번호:"+dept.getDeptno());
		out.print("부서명:"+dept.getDname());
		out.print("부서위치"+dept.getLoc());
		out.print("<br>");
	}
%>
</body>
</html>






