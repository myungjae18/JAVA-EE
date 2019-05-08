<%@page import="com.itbank.model.repository.MemberDAO"%>
<%@page import="com.itbank.model.repository.MariadbMybatisMemberDAO"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.itbank.model.domain.Member"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	//결합도를 낮춰야 유지보수성이 상승한다..
	MemberDAO myDAO = new MariadbMybatisMemberDAO();
	Logger logger = Logger.getLogger(this.getClass().getName());%>
<%
	//oracle에서 데이터를 가져와서, 클라이언트가 받게 될 데이터를 여기서 가공(XML or JSON)해서 보내주자..
	//응답 시 json 객체 자료형으로 전송 가능한가?
	//->네트워크로 주고 받는 데이터는 자료형이 있을 수 없다.. 즉 문자열로 처리한다.
	List<Member> list = myDAO.selectAll();
	StringBuilder sb=new StringBuilder();
	sb.append("{");
	sb.append("\"memberList\":[");
	for(int i=0; i<list.size();i++){
		Member member=list.get(i);
		sb.append("{");
		sb.append("\"member_id\":"+member.getMember_id()+",");
		sb.append("\"id\":\""+member.getId()+"\",");
		sb.append("\"password\":\""+member.getPassword()+"\",");
		sb.append("\"name\":\""+member.getName()+"\"");
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