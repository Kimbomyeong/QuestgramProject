<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<style>
	section{
	width:600px;
	height:400px;
	border:1px solid #efefef;}
	
	section form button{
	width:300px;
	height:50
	}
</style>
</head>
<body>

<section class="submenu" id="submenu" role="dialog" style="z-index:9999;">
				          <form >
			      			<button type="button" class="btn btn-default btn-block" style="color:red;"><b>신고</b></button>
			                <button type="submit" class="btn btn-default btn-block"onclick="location.href=''"><b>삭제</b></button>
			                <button type="button" class="btn btn-default btn-block" onclick="$('.submenu').modal('hide')"><b>취소</b></button>
				          </form>
				  </section> <!-- modal 끝 -->

</body>
</html>