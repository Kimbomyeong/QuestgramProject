<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Questgram</title>
<style>
body{
	background-color:#fafafa;
}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="images/questgram.ico">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"	href="css/style.css">

<script src="js/script.js"></script>
<script type="text/javascript">
	$(function(){
		$("#home").click(function(){
			$("#home img").attr("src","images/home_b.PNG");
			$("#compass img").attr("src","images/compass.PNG");
			$("#mainheart img").attr("src","images/mainheart.PNG");
		});
		$("#compass").click(function(){
			$("#home img").attr("src","images/home.PNG");
			$("#compass img").attr("src","images/compass_b.PNG");
			$("#mainheart img").attr("src","images/mainheart.PNG");
		});
		$("#mainheart").click(function(){
			$("#home img").attr("src","images/home.PNG");
			$("#compass img").attr("src","images/compass.PNG");
			$("#mainheart img").attr("src","images/mainheart_b.PNG");
		});

		
	});
</script>
</head>
<body>
	<header>
		<div id="box">
			<div id="logo" >
				<a href="main.jsp"><img src="images/logo.png"></a>
			</div>
			<div id="search">
				<span id="glass"><i class="xi-search si-x"></i></span>
				<input type="text" placeholder="검색">
			</div>
			<nav>
				<ul>
					<li class="nav" id="home" width="35px" height="34px"><a href="main.jsp"><img src="images/home_b.PNG"/></a></li>
					<li class="nav" id="compass" width="33px" height="34px"><a href="#"><img src="images/compass.PNG"/></a></li>
					<li class="nav" id="mainheart" width="34px" height="34px"><a href="#"><img src="images/mainheart.PNG"/></a></li>
					<li class="nav"><a href="#"><div class="info"></div></a></li>
					<a href="login_signup/logoutaction.jsp">
          			<span class="glyphicon glyphicon-off" style="font-size: 25px; margin-left: 20px; "></span>
        			</a>		
				</ul>
			</nav>
		</div>
	</header>
	<wrapper>
		<div id="maincontent">
			<div id="board">
			  	<jsp:include page="Post/form1.jsp"/>
			</div>
			<div id="side">
				<div id="profile">
					<a href="#"><div class="info" style="width:50px; margin-top: 3px; height:50px; float:left;"> </div></a>
					<a href="#"><span class="id">아이디</span></a>
					<span id="name">이름</span>
				</div>
				<div id="notice">
					댓글 알림
				</div>
				<div id="recommand">
					팔로우 추천
				</div>
				<div id="qna">
					고객센터
				</div>
			</div>
		</div>
	</wrapper>
	<bottom>
	
	</bottom>
</body>
</html>