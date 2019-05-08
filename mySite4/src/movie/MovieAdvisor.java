package movie;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;

//��ȭ�� ���� �Ǵ��� ó���ϴ� Ŭ����
public class MovieAdvisor extends HttpServlet{
	//������ �޸𸮿� �ν��Ͻ�ȭ�� �Ŀ�, ����̰� �� �������� ���� ��� ���� ���� ������ �� �ִ�..
	//�� �ǽ������� ������ ���� ����� �˾ƺ���
	public void init(ServletConfig config) throws ServletException{
		String parameter=config.getInitParameter("identity");
		System.out.println(parameter);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html"); //html �������� ���
		response.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

	//Ŭ���̾�Ʈ�� ��û�� Get ����� �� ȣ��Ǵ� �޼���
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String movie=request.getParameter("movie");
		PrintWriter out=response.getWriter();
		out.print("�Ѱܹ��� �Ķ���� ���� "+movie);

		String msg=null; //���� �޼���

		if(movie.equals("���� ����")){
			msg="���� ���� �ڹ̵� ����";
		}else if(movie.equals("�����")){
			msg="�ְ��� ������";
		}else if(movie.equals("����")){
			msg="��Ʈ ���� ���繰";
		}

		HttpSession session=request.getSession();
		session.setAttribute("data", msg);
	}

	public void destroy(){
		System.out.println("�� �״´�..");
	}
}
