<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public String showMsgBack(String msg) {
		StringBuilder sb=new StringBuilder();
		
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("history.back();");
		sb.append("</script>");
		
		return sb.toString();
	}

	public String showMsgUrl(String msg, String url) {
		StringBuilder sb=new StringBuilder();
		
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("location.href='"+url+"';");
		sb.append("</script>");
		
		return sb.toString();
	}
%>