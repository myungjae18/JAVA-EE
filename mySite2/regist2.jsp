<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%
	/*Ŭ���̾�Ʈ�� ������ �����͸� ���� ������ �޾ƾ� �ϱ� ������
	���� ������ ����� �� �ִ� jsp�� ��������*/
	String id=request.getParameter("id"); //Ŭ���̾�Ʈ�� ������ ������ ���� �� �ִ�
	String pw=request.getParameter("pw");
	out.print("����� �ѱ� id�� "+id+", pw�� "+pw);
	//�Ѱܹ��� �Ķ���͵��� ����Ŭ�� �ֱ�
	//jsp�� �ڹ��̱� ������ �� ���� �ڵ�� javaSE �ڵ�� �ۼ��ϸ� �ȴ�..
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/zino1187";
	String user="root";
	String password="";

	Connection con=DriverManager.getConnection(url, user, password);
	PreparedStatement pstmt=null;
	if(con==null){
		out.print("���� ����..");
	}else{
		out.print("���� ����!");
		String sql="insert into webmember(id, password)";
		sql+=" values(?, ?)";

		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);

		int result=pstmt.executeUpdate(); //���� ����
		if(result==0){
			out.print("�Է� ����...");
		}else{
			out.print("�Է� ����!");
		}
	}
	//���� �ִ� ��� DB ���� �ڿ� �ݱ�
	if(pstmt!=null){
		pstmt.close();
	}
	if(con!=null){
		con.close();
	}
%>