<%@ page contentType="text/html; charset=UTF-8"%>
<%
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
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
<%@ include file="/admin/inc/head.jsp" %>
<script>
$(function(){
	getTopList();
	
	$($("input[type='button']")[0]).click(function(){
		regist();
	});
	
	$($("input[type='button']")[1]).click(function(){
		//location.href="list.jsp";//js
		//$(location).attr("href","list.jsp");//속성이 1개일때
		$(location).attr({  //속성이 2개이상일때 유용
			href:"list.jsp"
		});
		
	});
});

//서버에 등록을 요청한다!!
function regist(){
	//서브 카테고리 유효성 체크 
	if($("#subcategory_id").val()=="0"){
		alert("하위 분류를 선택하세요");
		return;
	}
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
			//서버의 응답이 일반 텍스트 일때는 JSON 객체화 시킴..
			//var json=JSON.parse(result);
			//alert(result.topList[0].top_name);
			createOption(result);
		},
		error:function(result){
			
		}
	});
}

//하위 카테고리 목록 요청하기
function getSubList(topcategory_id){
	//alert("당신이 선택한 상위 id는 "+topcategory_id);
	$.ajax({
		url:"/admin/product/subcategory.jsp",
		type:"post",
		data:{
			topcategory_id:topcategory_id
		},
		success:function(result){
			createSubOption(result);
		},
		error:function(result){
			
		}
	});
	
}


//동적으로 select박스의 옵션을 생성하는 함수!!
function createOption(obj){
	//제이쿼리로 option
	$("#topcategory_id").append("<option value=\"0\">상위카테고리 선택</option>");
	
	for(var i=0;i<obj.topList.length;i++){
		var json=obj.topList[i];
		$("#topcategory_id").append("<option value=\""+json.topcategory_id+"\">"+json.top_name+"</option>");
	}
}

function createSubOption(obj){
	$("#subcategory_id").html("");//초기화!!!
	
	//제이쿼리로 option
	$("#subcategory_id").append("<option value=\"0\">하위카테고리 선택</option>");
	
	for(var i=0;i<obj.subList.length;i++){
		var json=obj.subList[i];
		$("#subcategory_id").append("<option value=\""+json.subcategory_id+"\">"+json.sub_name+"</option>");
	}
}

</script>
</head>
<body>
<%@ include file="/admin/inc/header.jsp" %>
<h3>Contact Form</h3>

<div class="container">
  <form>
    <label for="country">상위 카테고리</label>
    <select id="topcategory_id" name="topcategory_id" onChange="getSubList(this.value)">
    </select>
    
    <label for="country">하위 카테고리</label>
    <select id="subcategory_id" name="subcategory_id">
    </select>
  
  
    <label for="fname">상품명</label>
    <input type="text" name="product_name" placeholder="Your name..">

    <label for="lname">가격</label>
    <input type="text" name="price" placeholder="input data by number">

    <label for="subject">상세설명</label>
    <textarea  name="detail" placeholder="Write something.." style="height:200px"></textarea>
    
    <label for="subject">상품사진</label>
	<input type="file" name="myFile" value="사진찾기"/>
	<p>	
    <input type="button" value="등록">
    <input type="button" value="목록">
  </form>
</div>
</body>
</html>








