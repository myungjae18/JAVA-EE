<%@page contentType="text/html;charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String movie=request.getParameter("movie");
	out.print("선택한 영화는 "+movie);

	String msg=null; //최종 메세지

	if(movie.equals("극한 직업")){
		msg="역대 흥행 코미디 대작";
	}else if(movie.equals("사바하")){
		msg="최고의 공포물";
	}else if(movie.equals("뺑반")){
		msg="히트 예감 수사물";
	}

	//send.jsp 요청 시 이미 발급받은 세션을 이용하여 데이터 심기
	//session.setAttribute("data", msg);
	//result.jsp에서 결과를 보여주자 - 일단 현재 요청을 완료 후, 지정한 url로 재요청을 시도한다
	//response.sendRedirect("/movie/result.jsp");

	//현재 요청에 대해 마무리 하지 말고, 여기서 서버 상에 또 다른 jsp에게 요청을 시도하자..
	//단, 응답을 하지 않은 상태이므로 기존의 request, response가 아직 살아있다
	RequestDispatcher dis=null;
	dis=request.getRequestDispatcher("/movie/result.jsp");

	request.setAttribute("data", msg);
	dis.forward(request, response); //forwarding
%>