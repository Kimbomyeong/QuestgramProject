<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.UserDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.CommentDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="data.dao.FollowDao"%>
<%@page import="data.dto.FollowDto"%>
<%@page import="java.util.List"%>
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
<link rel="stylesheet" href="css/jquery.tag-editor.css" />
<link rel="stylesheet" href="css/questionform.css" />
<script src="profile/u
sersearch.js"></script>
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
<%
	String thisId = (String)session.getAttribute("userid");
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
	String context = request.getContextPath();
	UserDao udao = new UserDao();
	UserDto udto = udao.getUser(thisId);
	
%>
	<header>
		<div id="box">
			<div id="logo" >
				<a href="main.jsp"><img src="images/logo.png"></a>
			</div>
			<div id="search">
				<span id="glass"><i class="xi-search si-x"></i></span>
				<input type="text" placeholder="검색" id="searchForm">
				<ul></ul>
			</div>
			<nav>
				<ul>
					<li class="nav" id="home" width="35px" height="34px"><a href="main.jsp"><img src="images/home_b.PNG"/></a></li>
					<li class="nav" id="compass" width="33px" height="34px"><a href="profile/profile.jsp"><img src="images/compass.PNG"/></a></li>
					<li class="nav" id="mainheart" width="34px" height="34px"><a href="#"><img src="images/mainheart.PNG"/></a></li>
					<li class="nav"><a href="profile/usermain.jsp?thisId=<%=thisId %>"><div class="info"></div></a></li>
					<a href="login_signup/logoutaction.jsp">
          			<span class="glyphicon glyphicon-off" style="font-size: 25px; margin-left: 20px; "></span>
        			</a>		
				</ul>
			</nav>
		</div>
	</header>
	<wrapper>
		<div id="maincontent" >
			<div id="side">
				<div id="profile">
					<a href="#"><div class="info" style="width:50px; margin-top: 3px; margin-left:-5px; height:50px; float:left;"> </div></a>
					
					<a href="#"><span class="id"><%= udto.getNickname() %></span></a>
					<span id="name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= udto.getName() %></span>
				</div>
				<div id="notice">
					댓글 알림
					<a style="float:right; margin:3px 15px 0 0; font-weight:bold; color:#262626; font-size:12px; ">모두 보기</a>
					<div id="recentcomment">
	
				<%
					CommentDao cdao = new CommentDao();
					List<CommentDto> clist = cdao.recentComment(thisId);
					for (CommentDto rcl: clist) {
				%>		<p style="color: black;">
						<%=rcl.getId()%>&nbsp;님이 댓글을 남겼습니다<br>
						<%=rcl.getContent()%>&nbsp;(<%=sdf.format(rcl.getCreated_at()) %>)
					</p>
				<%	}
				%>	
						
					</div>
				</div>
				
				<div id="recommend">
					회원님을 위한 추천
					<a style="float:right; margin:3px 15px 0 0; font-weight:bold; color:#262626; font-size:12px;">모두 보기</a>
				<%	
					FollowDao fdao = new FollowDao();
					List<FollowDto> rlist = fdao.rcmmdFollow(thisId);
					for (FollowDto rcm: rlist) {
						String now = fdao.followNow(rcm.getId(), thisId);
				%>
					<div style="clear:both;margin-top:12px;">
						 <div style="float:left; ">
						 	<img style="width:40px; height:40px; border-radius:100%;" 
						 		src="http://localhost:9000<%=context %>/save/<%=rcm.getProfile_img() %>"></div>
						 <a style="float:left; color:black; margin-left: 10px; font-weight:600;"
						 	href=""><%=rcm.getNickname() %> (<%=rcm.getName() %>)</a>
						 <a style="float: right;  color:#0f9bf7;  margin:8px 20px 0 0;"
						 	id="btnFollow" userid="<%=rcm.getId() %>" now="<%=now %>"><%=now %></a>
						 <p style="margin-left: 50px; clear: both; float: left; margin-top: -20px; font-weight:normal; font-size:12px;">(   )님이 팔로우합니다</p>
					</div>
				<%	}
				%>	
				</div>
				<div id="qna">
					<a>소개</a> · <a>도움말</a> · <a>홍보 센터</a> · <a>API</a> · <a>채용 정보</a> · <br><a>개인정보처리방침</a> · 
					<a>약관</a> · <a>위치</a> · <a>인기 계정</a> · <a>해시태그</a> · <a>언어</a>
					<p>© 2020 INSTAGRAM FROM FACEBOOK</p>
				</div>
			</div>
		
			
			<div id="board">
			  	<jsp:include page="Post/form_1.jsp"/>
			</div>
		</div>
		<!-- 게시물 올리기 확인용 버튼 -->
		<button type="button" onclick="location.href='Post/Post_insert_Form.jsp'">게시물올리기</button>
				
	</wrapper>
	<bottom>
	
	</bottom>
</body>
</html>