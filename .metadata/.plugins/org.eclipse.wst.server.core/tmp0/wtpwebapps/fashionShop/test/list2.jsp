<%@page import="test.Emp"%>
<%@page import="test.Dept"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.fashion.mybatis.config.ConfigManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%! ConfigManager manager=ConfigManager.getInstance(); %>
<%
	SqlSession sql=manager.getSqlSession();
	List<Emp> deptList=sql.selectList("Emp.selectAll");
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
		Emp emp=deptList.get(i);
		out.print("사원번호:"+emp.getEmpno());
		out.print("사원명:"+emp.getEname());
		out.print("담당업무:"+emp.getJob());
		out.print("매니저:"+emp.getMgr());
		out.print("입사일:"+emp.getHiredate());
		out.print("급여:"+emp.getSal());
		out.print("커미션계약:"+emp.getComm());
		out.print("부서번호:"+emp.getDept().getDname());
		out.print("부서명:"+emp.getDept().getDname());
		out.print("부서위치:"+emp.getDept().getLoc());
		
		out.print("<br>");
	}
%>
</body>
</html>






