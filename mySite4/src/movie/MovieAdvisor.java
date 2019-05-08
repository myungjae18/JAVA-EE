package movie;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;

//영화에 대한 판단을 처리하는 클래스
public class MovieAdvisor extends HttpServlet{
	//서블릿이 메모리에 인스턴스화된 후에, 고양이가 이 서블릿에게 각종 출생 정보 등을 전달할 수 있다..
	//이 실습에서는 데이터 전달 방법을 알아보자
	public void init(ServletConfig config) throws ServletException{
		String parameter=config.getInitParameter("identity");
		System.out.println(parameter);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html"); //html 문서임을 명시
		response.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

	//클라이언트의 요청이 Get 방식일 때 호출되는 메서드
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String movie=request.getParameter("movie");
		PrintWriter out=response.getWriter();
		out.print("넘겨받은 파라미터 값은 "+movie);

		String msg=null; //최종 메세지

		if(movie.equals("극한 직업")){
			msg="역대 흥행 코미디 대작";
		}else if(movie.equals("사바하")){
			msg="최고의 공포물";
		}else if(movie.equals("뺑반")){
			msg="히트 예감 수사물";
		}

		HttpSession session=request.getSession();
		session.setAttribute("data", msg);
	}

	public void destroy(){
		System.out.println("나 죽는다..");
	}
}
