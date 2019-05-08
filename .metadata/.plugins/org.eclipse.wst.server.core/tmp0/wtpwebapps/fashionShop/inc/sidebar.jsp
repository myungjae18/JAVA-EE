<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.fashion.model.domain.Topcategory"%>
<%@page import="com.fashion.model.repository.TopcategoryDAO"%>
<%!
	TopcategoryDAO topDAO=new TopcategoryDAO();
%>
<%
	List<Topcategory> topList=topDAO.selectAll();
%>
<div class="sidebar_logo">
	<a href="/"><div>a<span>Shop</span></div></a>
</div>

<nav class="sidebar_nav">
	<ul>
		<li><a href="index.jsp">home<i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
		<%for(int i=0;i<topList.size();i++){%>
		<%Topcategory topcategory=topList.get(i); %>
		<li><a href="/category.jsp?topcategory_id=<%=topcategory.getTopcategory_id()%>"><%=topcategory.getTop_name()%><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
		<%}%>
		<li><a href="#">contact<i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
		<li><a href="/registForm.jsp">Join us<i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
	</ul>
</nav>






