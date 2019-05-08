//javaEE 수업을 시작한 이래로 javaEE 스펙, 표준일 뿐이다.. javaEE를 구현한 그 실체는 어딧을까...?
package test;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

//현재는 클라이언트의 요청을 처리할 수 없다.. 그냥 클래스이기 때문에..
public class MyServlet extends HttpServlet{ //HttpServlet을 상속받는 순간부터 이 클래스는 서블릿이며 오직 서버에서만 실행될 수 있다
	//Servlet은 생명주기 메서드라 불리는 메서드가 지원된다..
	public void init() throws ServletException{
		System.out.println("저 서블릿 자격증 받았어요..");
	}

	//HttpServletRequest는 jsp에서는 request라는 변수명으로 내장 객체란 이름으로 지원됨..
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//service 메서드는 jsp에서 스크립틀릿 영역이다.. <%%>으로 표현
		response.setContentType("text/html"); //html 문서임을 명시
		response.setCharacterEncoding("utf-8");
		PrintWriter out=	response.getWriter();
		out.print("my servlet 요청 성공했지롱~");
	}

	public void destroy(){
		System.out.println("나 죽는다..");
	}
}
