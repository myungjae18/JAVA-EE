<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String topcategory_id=request.getParameter("topcategory_id");
	//out.print("넘겨받은 상위 카테고리의 id값은 "+topcategory_id);
	
	//파라미터가 넘어오면, subcategory_id 값을 대체하자!!
	int subcategory_id=1;//기본값..
	if(request.getParameter("subcategory_id")!=null){//넘어오면...
		subcategory_id=Integer.parseInt(request.getParameter("subcategory_id"));
	}
%>
