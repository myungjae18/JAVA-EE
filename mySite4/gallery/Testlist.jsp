<%@page contentType="text/html;charset=utf-8"%>
<%@page import="gallery.model.GalleryDAO"%>
<%@page import="java.util.List"%>
<%@page import="gallery.model.Gallery"%>
<%!
	//선언부는 클래스의 멤버 영역이다!!!
	GalleryDAO galleryDAO=new GalleryDAO();
%>
<%
	//jsp에서는 로직을 작성하지 않는다 단지 디자인 처리만 해야 한다
	//따라서 모든 게시물을 가져오는 코드인 DAO로 결과물을 가져와 화면에 출력하자
	List<Gallery> list=galleryDAO.selectAll();
	out.print("게시물 개수는 "+list.size());
	ImageList imageList=new ImageList();
	String name;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	$("button").click(function(){
		location.href="/gallery/uploadform.html"; //a 태그와 같은 기능, 즉 링크
	});
	$("img").click(function(){
		$("form").attr("method", "post");
		$("form").attr("action", "/gallery/Detail.jsp");
		$("form").submit();
		location.href="/gallery/Detail.jsp";
	});
});

//네이버 지식백과 서버에 적절한 파라미터를 넘겨보자
function find(){
	location.href="https://search.naver.com/search.naver?where=kdic&sm=tab_jum&query="+$("#keyword").val();
}
</script>
</head>
<body>
<input type="text" id="keyword" placeholder="원하는 검색어를 입력하세요"/>
<input type="button" value="검색 엔진에서 찾기" onClick="find()"/>
<h2>Zebra Striped Table</h2>
<p>For zebra-striped tables, use the nth-child() selector and add a background-color to all even (or odd) table rows:</p>

<table>
	<tr>
		<th width="5%">seq</th>
		<th width="20%">사진</th>
		<th width="75%">제목</th>
	</tr>
		<%for(int i=0;i<list.size();i++){%>
		<%Gallery gallery=list.get(i);%>
	<tr>
		<td>
			<%=gallery.getGallery_id()%>
		</td>
		<td>
			<form>
				<input type="text" value=<%=gallery.getFileName()%> name="good"/>
				<img src="/upload/<%=gallery.getFileName()%>" width="50px" name="image"/>
			</form>
		</td>
		<td>
			<a href="TestDetail.jsp?gallery_id=<%=gallery.getGallery_id()%>">
				<%=gallery.getTitle()%>
			</a>
		</td>
	</tr>
	<%}%>
	<tr>
		<td colspan="3">
			<button>글 등록</button>
		</td>
	<tr>
</table>

</body>
</html>
