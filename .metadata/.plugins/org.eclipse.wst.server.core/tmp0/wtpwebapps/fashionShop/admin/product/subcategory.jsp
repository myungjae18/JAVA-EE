<%@page import="com.fashion.model.domain.Subcategory"%>
<%@page import="java.util.List"%>
<%@page import="com.fashion.model.repository.SubcategoryDAO"%>
<%@ page contentType="text/json; charset=UTF-8"%>
<%! SubcategoryDAO subDAO=new SubcategoryDAO();%>
<%
	String topcategory_id=request.getParameter("topcategory_id");
	List<Subcategory> list=subDAO.selectAllByFk(Integer.parseInt(topcategory_id));
	
	StringBuilder sb = new StringBuilder();
	sb.append("{");
	sb.append("\"subList\":[");
	for(int i=0;i<list.size();i++){
		Subcategory subcategory=list.get(i);
		sb.append("{");
		sb.append("\"subcategory_id\":"+subcategory.getSubcategory_id()+",");
		sb.append("\"topcategory_id\":"+subcategory.getTopcategory_id()+",");
		sb.append("\"sub_name\":\""+subcategory.getSub_name()+"\"");
		
		if(i<list.size()-1){
			sb.append("},");
		}else{
			sb.append("}");
		}
	}
	sb.append("]");
	sb.append("}");
	
	out.print(sb.toString());	
%>