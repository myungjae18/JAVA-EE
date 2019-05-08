<%@page import="com.itbank.board.model.Board"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itbank.board.model.BoardDAO"%>
<%@page contentType="text/html;charset=utf-8"%>
<%
	BoardDAO boardDAO=new BoardDAO();
	List<Board> list=boardDAO.selectAll();
	
	int currentPage=1;
	if(request.getParameter("currentPage")!=null){ //링크를 눌렀다면, 바로 그 링크로 넘어온 숫자를 현재 페이지로 대체
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int totalRecord=list.size(); //총 레코드 수
	int pageSize=10; //페이지 당 보여질 레코드 수
	int totalPage=(int)Math.ceil((float)totalRecord/pageSize);
	int blockSize=10; //블럭 당 페이지 수 = 넘쳐나는 페이지를 제한하기 위한 변수
	int firstPage=currentPage-(currentPage-1)%blockSize;
	int lastPage=firstPage+(blockSize-1);
	int curPos=(currentPage-1)*pageSize;
	int num=totalRecord-curPos;
	
	out.print("현재 페이지는 "+currentPage);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	border: 1px solid #ddd;
}

th, td {
	text-align: left;
	padding: 16px;
}

tr:nth-child(even) {
	background-color: #f2f2f2
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	
</script>
</head>
<body>

	<h2>게시물 목록</h2>
	<p>For zebra-striped tables, use the nth-child() selector and add a
		background-color to all even (or odd) table rows:</p>

	<table>
		<tr>
			<th width="5%">No</th>
			<th>제목</th>
			<th width="10%">작성자</th>
			<th width="10%">작성일</th>
			<th width="5%">조회수</th>
		</tr>
		<%for(int i=1;i<=pageSize;i++){ %>
		<%if(num<1)break; %>
		<%Board board=list.get(curPos++); %>
		<tr>
			<td><%=num-- %></td>
			<td>
			<a href="/board/content.jsp?board_id=<%=board.getBoard_id()%>"><%=board.getTitle() %>[<%=board.getCommentsList().size()%>]</a>
			</td>
			<td><%=board.getWriter()%></td>
			<td><%=board.getRegdate()%></td>
			<td><%=board.getHit() %></td>
		</tr>
		<%} %>
		<tr>
			<td colspan="5">
				<button onClick="location.href='/board/writer.html'">글 등록</button>
			</td>
		</tr>
		<tr>
			<td colspan="5">
			<%for(int i=firstPage;i<=lastPage;i++){ %>
			<%if(i>totalPage)break; %>
				<a href="/board/list.jsp?currentPage=<%=i%>">[<%=i %>]</a>
			<%} %>
			</td>
		</tr>
	</table>

</body>
</html>
