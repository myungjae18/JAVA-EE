<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%
	/*클라이언트가 전송한 데이터를 서버 측에서 받아야 하기 때문에
	서버 측에서 실행될 수 있는 jsp로 구현하자*/
	String id=request.getParameter("id"); //클라이언트가 전송한 변수를 받을 수 있다
	String pw=request.getParameter("pw");
	out.print("당신이 넘긴 id는 "+id+", pw는 "+pw);
	//넘겨받은 파라미터들을 오라클에 넣기
	//jsp는 자바이기 때문에 이 이하 코드는 javaSE 코드로 작성하면 된다..
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/zino1187";
	String user="root";
	String password="";

	Connection con=DriverManager.getConnection(url, user, password);
	PreparedStatement pstmt=null;
	if(con==null){
		out.print("접속 실패..");
	}else{
		out.print("접속 성공!");
		String sql="insert into webmember(id, password)";
		sql+=" values(?, ?)";

		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);

		int result=pstmt.executeUpdate(); //쿼리 실행
		if(result==0){
			out.print("입력 실패...");
		}else{
			out.print("입력 성공!");
		}
	}
	//열려 있는 모든 DB 관련 자원 닫기
	if(pstmt!=null){
		pstmt.close();
	}
	if(con!=null){
		con.close();
	}
%>