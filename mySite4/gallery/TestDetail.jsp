<%@page contentType="text/html;charset=utf-8"%>
<%@page import="gallery.model.GalleryDAO"%>
<%@page import="gallery.model.Gallery"%>
<%
	int gallery_id=Integer.parseInt(request.getParameter("gallery_id")); //넘겨받은 파라미터 값으로 대체
	//out.print(sql);
	GalleryDAO galleryDAO=new GalleryDAO();
	Gallery gallery=galleryDAO.select(gallery_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
</head>
<body>

<h3>Contact Form</h3>

<div class="container">
	<form action="/action_page.php">
		<input type="text" name="firstname" value="<%=gallery.getTitle()%>">
		<img src="/upload/<%=gallery.getFileName()%>" width="50%"/>
    <input type="submit" value="Submit">
  </form>
</div>

</body>
</html>
