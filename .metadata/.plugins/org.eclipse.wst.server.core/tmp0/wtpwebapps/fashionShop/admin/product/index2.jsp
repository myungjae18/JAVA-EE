<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link rel="stylesheet" type="text/css" href="/admin/static/css/main-nav.css"/>
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

input[type=button] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=button]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	getTopList();
	
	$($("input[type='button']")[0]).click(function(){
		regist();
	});
});

function regist(){
	$("form").attr({
		"method":"post",
		"action":"/admin/product/regist.jsp",
		"enctype":"multipart/form-data"
	});	
	$("form").submit();
}
//최상위 카테고리 가져오기
function getTopList(){
	$.ajax({
		url:"/admin/product/topcategory.jsp",
		type:"get",
		success:function(result){
			
		},
		error:function(result){
			
		}
	});
}
</script>
</head>
<body>
<%@ include file="/admin/inc/header.jsp" %>
<h3>Contact Form</h3>

<div class="container">
  <form >
    <label for="country">상위 카테고리</label>
    <select id="country" name="country">
      <option value="australia">Australia</option>
      <option value="canada">Canada</option>
      <option value="usa">USA</option>
    </select>
    
    <label for="country">하위 카테고리</label>
    <select id="country" name="country">
      <option value="australia">Australia</option>
      <option value="canada">Canada</option>
      <option value="usa">USA</option>
    </select>
  
  
    <label for="fname">상품명</label>
    <input type="text" id="fname" name="firstname" placeholder="Your name..">

    <label for="lname">가격</label>
    <input type="text" id="lname" name="lastname" placeholder="Your last name..">

    <label for="subject">상세설명</label>
    <textarea id="subject" name="subject" placeholder="Write something.." style="height:200px"></textarea>
    
    <label for="subject">상품사진</label>
	<input type="file" name="filename" value="사진찾기">
	<p>	
    <input type="button" value="등록">
    <input type="button" value="목록">
  </form>
</div>
</body>
</html>








