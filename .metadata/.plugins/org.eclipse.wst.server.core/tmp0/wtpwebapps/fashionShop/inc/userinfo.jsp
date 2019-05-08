<%@page import="com.fashion.model.domain.Customer"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	if (session.getAttribute("customer") != null) {
%>
<%
	Customer customer = (Customer) session.getAttribute("customer");
%>
<div class="info_languages has_children">
	<div class="language_flag"></div>
	<div class="dropdown_text">

		<%=customer.getName()%>님
	</div>
	<div class="dropdown_arrow">
		<i class="fa fa-angle-down" aria-hidden="true"></i>
		<ul>
			<li><a href="#">
					<div class="dropdown_text">MyPage</div>
			</a></li>
			<li><a href="/member/logout.jsp">
					<div class="dropdown_text">Logout</div>
			</a></li>
		</ul>
	</div>
</div>
<%
	}
%>