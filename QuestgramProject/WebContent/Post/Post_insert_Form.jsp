<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 게시물</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">

html{
width: 800px;
height: 700px;
border: solid;

}

.head{
	width: 800px;
	height: 50px;
}



.container {
	
	width: 800px;
	height: 800px;
}

.sajin {
	
	float: left;
	width: 200px;
	height: 200px;
}


.content {
	
	clear: right;
	width: 800px;
	height: 267px;
}

</style>
</head>
<%
	request.setCharacterEncoding("utf-8");
	//유저의 닉네임을받아온다 (세션명: userid)
	String user_id=(String)session.getAttribute("userid");
	//userdao선언
	
	
/* 	//boarddao 선언
	BoardDao bdb = new BoardDao();
	//boarddto 선언
	BoardDto bdto = new BoardDto();
	UserDao dao = new UserDao();
	 */
	System.out.println(user_id);
	
	
	



%>
<body>
<form action="Post_insert_Action.jsp" method="post">	
<!-- hidden -->
<input type="hidden" name="user_id" value="<%=user_id%>"><!-- 작성자,닉네임 -->



	
<div class="head">
	<button type="button" style="width: 50px; height:40px; border-radius: 20px; float: left;">뒤로</button>
	<h2 style="overflow:inherit;">&nbsp;&nbsp; 새 게시물
	<button type="submit" style="float: right; overflow: inherit; opacity: 0.4; border: none;
				margin-right: 5%; width: 50px; height: 40px; color: blue; font-size: medium; cursor: pointer;">공 유</button>
	</h2>
	
	
</div>	

<hr>	
	
<div class="container">	
	
<!-- 올릴 사진 -->
<div class="sajin">
	<a href="#"><img src="./image/gom.jpg" alt="" style="float: left;
	 width: 200px; height: 200px;"></a>
	
	<!-- 올릴 내용 -->
	

</div>
<div>
	<textarea name="hashtag" placeholder="해시태그 입력..." 
  style="float: left;width:500px; height: 194px; border: none;"></textarea>
</div>

<div> 

<textarea name="content" placeholder="문구 입력..." 
  style="float: left;width:500px; height: 194px; border: none;"></textarea> </div>
  
<hr style="clear: both;">

<h1>사람 태그하기</h1>
<hr>

<h1>위치 추가</h1>
<hr>

<h1>다른 미디어에도 제시</h1>
<h2>Facebook</h2>
<h2>Twitter</h2>
<h2>Tumblr</h2>



	
</div>
</form>
</body>
</html>