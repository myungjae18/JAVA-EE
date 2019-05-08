<%@page import="com.fashion.model.domain.Topcategory"%>
<%@page import="java.util.List"%>
<%@page import="com.fashion.model.repository.TopcategoryDAO"%>
<%@ page contentType="text/json; charset=UTF-8"%>
<%!TopcategoryDAO topDAO = new TopcategoryDAO();%>
<%
	//상위 카테고리를 db 조회하여, 클라이언트에게 json 형식으로 응답할 것임
	//따라서 이 jsp 는 jsp 제공용이 아니다!!
	List<Topcategory> list = topDAO.selectAll();
	StringBuilder sb = new StringBuilder();

	sb.append("{");
	sb.append("\"topList\":[");
	for(int i=0;i<list.size();i++){
		Topcategory topcategory=list.get(i);
		sb.append("{");
		sb.append("\"topcategory_id\":"+topcategory.getTopcategory_id()+",");
		sb.append("\"top_name\":\""+topcategory.getTop_name()+"\"");
		if(i<list.size()-1){
			sb.append("},");
		}else{
			sb.append("}");
		}
	}
	sb.append("]");
	sb.append("}");
	
	//System.out.println(sb.toString());
	out.print(sb.toString());
%>












