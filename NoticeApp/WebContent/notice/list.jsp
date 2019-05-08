<%@page import="notice.model.Notice"%>
<%@page import="java.util.List"%>
<%@page import="notice.model.NoticeDAO"%>
<%@page contentType="text/html;charset=utf-8"%>
<%!
	NoticeDAO noticeDAO=new NoticeDAO();
%>   
<%
	List<Notice> list=noticeDAO.selectAll();
   /*
   하나의 페이지에 모든 레코드를 출력하면 스크롤이 생긴다 (불편함)
   레코드 수를, 페이지당 소정 개수만큼 보여주도록 개발자가 지정하는 기법을
   "paging 처리"라 한다.
   */
   int currentPage=1; //현재 페이지 번호.
   //사용자가 페이지 번호를 눌렀을 경우, currentPage는 그 값으로 대체되어야 한다.
   if(request.getParameter("currentPage")!=null){
      currentPage=Integer.parseInt(request.getParameter("currentPage"));
   }
   int totalRecord=list.size(); //총 레코드 수.
   int pageSize=10; //페이지 당 출력될 레코드 수.
   int totalPage=(int)Math.ceil((float)totalRecord/pageSize); //총 페이지 수. Math.ceil(): 올림
   int blockSize=10; //블록 당 출력될 페이지 수.
   int firstPage=currentPage-(currentPage-1)%blockSize; //블록 당 시작 페이지
   int lastPage=firstPage+(blockSize-1); //블록 당 마지막 페이지
   int curPos=(currentPage-1)*pageSize; //페이지 당 List 내의 시작 index 
   int num=totalRecord-curPos; //페이지 당 게시물 시작 번호.
   
   out.print("currentPage(현재 페이지): "+currentPage+"<br>");
   out.print("totalRecord(총 레코드): "+totalRecord+"<br>");
   out.print("pageSize(페이지당 출력 레코드): "+pageSize+"<br>");
   out.print("totalPage(총 페이지): "+totalPage+"<br>");
   out.print("blockSize(블록당 출력 페이지): "+blockSize+"<br>");
   out.print("firstPage(블록당 시작 페이지): "+firstPage+"<br>");
   out.print("lastPage(블록당 마지막 페이지): "+lastPage+"<br>");
   out.print("페이지 당 시작 index"+curPos+"<br>");
   out.print("num(페이지당 시작 글번호): "+num+"<br>");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/header.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1"
   charset="UTF-8">
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
.pageNum{
   font-size:25px;
   font-weight:bold;
   color:blue;
   
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function goContent(notice_id){
	location.href="/notice/content.jsp?notice_id="+notice_id;
}
</script>
</head>
<body>
   <table>
      <tr>
         <th>번호</th>
         <th>제목</th>
         <th>작성자</th>
         <th>작성일</th>
         <th>조회수</th>
      </tr>
      <%for(int k=1;k<=pageSize;k++){ %>
      <%if(num<1)break;%>
      <%Notice notice=list.get(curPos++);%>
      <tr onClick="goContent(<%=notice.getNotice_id()%>)" onmouseover="this.style.background='yellow'" onmouseout="this.style.background=''">
         <td><%=num-- %></td>
         <td><%=notice.getTitle()%></td>
         <td><%=notice.getWriter()%></td>
         <td><%=notice.getRegdate().substring(0, 10)%></td>
         <td><%=notice.getHit()%></td>
      </tr>
      <%} %>
      <tr>
         <td colspan="5" align="center">
            <%if(firstPage-1>0){ %>
            <a class="pageNum" href="/notice/list.jsp?currentPage=<%=firstPage-1%>">👈</a>
            <%}else{ %>
            <a href="javascript:alert('첫 페이지입니다.');">👈</a>
            <%} %>
            <%for(int k=firstPage;k<=lastPage;k++){ %>
            <%if(k>totalPage)break; //내가 가진 페이지를 넘어서면 생성을 멈춤.%>
            <a<%if(currentPage==k){%> class="pageNum"<%}%> href="/notice/list.jsp?currentPage=<%=k%>">[<%=k%>]</a>
            <%} %>
            <%if(lastPage+1<totalPage){%>
            <a href="/notice/list.jsp?currentPage=<%=lastPage+1%>">👉</a>
            <%}else{ %>
            <a href="javascript:alert('마지막 페이지입니다.');">👉</a>
            <%} %>
         </td>
      </tr>
      <tr>
         <td colspan="5">
            <button onClick="location.href='/notice/registform.jsp'">글쓰기</button>
         </td>
      </tr>
   </table>

</body>
</html>