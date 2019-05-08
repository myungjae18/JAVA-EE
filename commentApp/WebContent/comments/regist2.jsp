<%@page import="com.itbank.comments.model.Comments"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.itbank.comments.model.CommentsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!Logger logger = Logger.getLogger(this.getClass().getName());%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="comments" class="com.itbank.comments.model.Comments" />
<jsp:useBean id="commentsDAO"
	class="com.itbank.comments.model.CommentsDAO" />
<jsp:setProperty property="*" name="comments" />
<%
	int result = commentsDAO.insert(comments);
	//등록된 모든 원문 하위에 등록된 모든 댓글 가져오기
	List<Comments> commentsList = commentsDAO.selectAll(comments.getBoard_id());
	
	logger.debug("현재 등록된 댓글 수는 " + commentsList.size());
	
	StringBuilder sb = new StringBuilder();

	sb.append("{");
	sb.append("\"commentsList\":[{");
	for (int i = 0; i < commentsList.size(); i++) {
		comments=commentsList.get(i);
	      sb.append("\"comments_id\":"+comments.getComments_id()+",");
	      sb.append("\"cwriter\":\""+comments.getCwriter()+"\",");
	      sb.append("\"msg\":\""+comments.getMsg()+"\",");
	      sb.append("\"cregdate\":\""+comments.getCregdate()+"\"");
		if (i < commentsList.size() - 1) {
			sb.append("},{"); //데이터가 더 있다면
		} else {
			sb.append("}"); //데이터가 더 없다면
		}
	}
	sb.append("]");
	sb.append("}");
	
	out.print(sb.toString()); //클라이언트에 결과 전송
%>
