<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<%@ page 
import="java.sql.*, 
javax.sql.*, 
java.io.*,
javax.naming.InitialContext,
javax.naming.Context" %>
</head>
<body>
<h1>JDBC JNDI Resource Test</h1>

<%
InitialContext initCtx = new InitialContext();
DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/myoracle");
Connection conn = ds.getConnection();
Statement stmt = conn.createStatement();
ResultSet rset = stmt.executeQuery("select id from member1");
while (rset.next()) { 
out.println("id=="+rset.getString("id")); 
}
rset.close();
stmt.close();
conn.close();
initCtx.close();
%>
</body>
</html>