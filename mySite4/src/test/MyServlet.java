//javaEE ������ ������ �̷��� javaEE ����, ǥ���� ���̴�.. javaEE�� ������ �� ��ü�� �������...?
package test;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

//����� Ŭ���̾�Ʈ�� ��û�� ó���� �� ����.. �׳� Ŭ�����̱� ������..
public class MyServlet extends HttpServlet{ //HttpServlet�� ��ӹ޴� �������� �� Ŭ������ �����̸� ���� ���������� ����� �� �ִ�
	//Servlet�� �����ֱ� �޼���� �Ҹ��� �޼��尡 �����ȴ�..
	public void init() throws ServletException{
		System.out.println("�� ���� �ڰ��� �޾Ҿ��..");
	}

	//HttpServletRequest�� jsp������ request��� ���������� ���� ��ü�� �̸����� ������..
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//service �޼���� jsp���� ��ũ��Ʋ�� �����̴�.. <%%>���� ǥ��
		response.setContentType("text/html"); //html �������� ���
		response.setCharacterEncoding("utf-8");
		PrintWriter out=	response.getWriter();
		out.print("my servlet ��û ����������~");
	}

	public void destroy(){
		System.out.println("�� �״´�..");
	}
}
