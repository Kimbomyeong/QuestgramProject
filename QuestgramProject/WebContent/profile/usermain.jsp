<%@page import="data.dto.BoardDto"%>
<%@page import="data.dto.FollowDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="data.dao.BoardDao"%>
<%@page import="data.dao.FollowDao"%>
<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MAIN COPY 2</title>
<style>
body{
	background-color:#fafafa;
}

	
	.ui-dialog {
		border: 1px solid gray;
	}
	#btnFollow {
		color: white;
		font-size: 11pt; font-weight: bold;
		background-color: #0067a3;
		padding: 5px;
		width: 100px; height: 25px;
		border-radius: 10%;
		margin-left: 20px;
	}
	li {
		font-weight: bold;
		display: list-item;
		vertical-align: baseline;
		display: inline;
		margin-right: 40px;
		margin-bottom: 20px;
	}
	.wholepage {
		padding-left: 20px; padding-right: 20px;
		box-sizing: content-box;
		width: calc(100% - 40px);
		align-items: stretch;
		margin: 0 auto 30px;
	}
	.profile-container {
		margin-bottom: 40px;
		flex-direction: row;
		
		display: flex;
		flex-wrap: nowrap;
		justify-content: center;
		max-width: 50%;		/* 이게 왜 되는지 미심쩍... */
		box-align: stretch;
	}
	.profile-button {
		flex-grow: 1;
		margin-right: 30px;
	}
	.profile-logo {
		align-items: center;
		align-self: center;
		display: block;
		flex: none;
		justify-content: center;
	}
	.profile-canvas {
		height: 168px; width: 168px;
		position: absolute;
		top: -9px; left: -9px;
	}
	.profile-img {
		flex: 0 0 auto;
		position: relative;
		border-radius: 50%;
		width: 150px; height: 150px;
		display: block;
		vertical-align: baseline;
	}
	
	.profile-content {
		box-sizing: border-box;
		display: flex;
		flex-direction: column;
		align-items: stretch;
		position: relative;
		
		flex-basis: 30;
		flex-grow: 2;
		
		margin-left: 40px;
		
		/* align-self: auto;
		line-height: 25px; */
	}
	.about_user {
		margin-bottom: 20px;
		align-items: center;
		flex-direction: row;
		min-width: 0;
	}
	.status {
		vertical-align: baseline;
		margin-left: 0; margin-right: 0;
	}
	.introduce {
		line-height: 25px;
		display: block;
	}
	/* .nickname {
		display: inline;
	} */
	.post-container{
		
	}
	
	.typeof-view {
		box-sizing: border-box;
		-webkit-box-align: center;
		align-items: center;
		border-top: 1px solid rgba(var(--b38,219,219,219),1);
		color: #8e8e8e;
		display: flex;
		-webkit-box-orient: horizontal;
		-webkit-box-direction: normal;
		flex-direction: row;
		font-size: 15px;
		font-weight: 600;
		-webkit-box-pack: center;
		justify-content: center;
		letter-spacing: 1px;
		text-align: center;
	}
	.select-view {
		margin-right: 60px;
		cursor: pointer;
		display: flex;
		-webkit-box-orient: horizontal;
		-webkit-box-direction: normal;
		flex-direction: row;
		height: 52px;
		-webkit-box-pack: center;
		justify-content: center;
		text-transform: uppercase;
		margin-right: 60px;
	}
	.grid-view {
		-webkit-box-align: stretch;
		align-items: stretch;
		border: 0 solid #000;
		box-sizing: border-box;
		display: flex;
		-webkit-box-orient: vertical;
		-webkit-box-direction: normal;
		flex-direction: column;
		position: relative;
		vertical-align: baseline;
		-webkit-box-align: stretch;
	}
	.container {
		-webkit-box-orient: horizontal;
		-webkit-box-direction: normal;
		flex-direction: row;
		margin-bottom: 30px;
	}
	.gallery {
		justify-content: center;
		box-align: stretch;
		width: auto;
	}
	.gallery-item img {
		-webkit-box-flex: 1;
		flex: 1 0 0%;
		/* display: block; */
		position: relative;
		width: 200px;
	}
	.gallery-item img {
		width: 200px;
		height: 200px;
	}
	
* {
  position: relative;
  padding: 0;
  margin: 0;
  
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  -webkit-box-sizing: border-box;
  	-moz-box-sizing: border-box;
  		box-sizing: border-box;
}

a {
  text-decoration: none;
  color: inherit;
}

input:focus{outline:none;}

textarea:focus{outline:none;}

/* gb-header */
.gb-header {
  position: fixed;
  top: 0;
  z-index: 1;
  width: 100%;
  height: 77px;
  border-bottom: 1px solid rgba(0, 0, 0, .0975);
  background-color: #ffffff;
}
.gb-header > .wrap {
  display: flex;
  align-items: center;
  height: 100%;
  max-width: 1010px;
  padding: 0 40px;
  margin: 0 auto;
}
.gb-header > .wrap > * {
  flex: 1;
}

.gb-header .logo {
  height: 35px;
}

.gb-header .search > input {
  display: block;
  width: 215px;
  height: 28px;
  padding: 3px 10px;
  border: 1px solid #dbdbdb;
  border-radius: 3px;
  margin: 0 auto;
  background-color: #fafafa;
  font-size: 14px;
  color: #262626;
}

.gb-header .menu {
  list-style: none;
  height: 24px;
  font-size: 0;
  text-align: right;
}
.gb-header .menu > li {
  display: inline-block;
  margin-right: 30px;
}
.gb-header .menu > li:last-child {
  margin: 0;
}


/* post-container */
.post-container {
  background-color: #fafafa;
}
.post-container > .wrap {
  max-width: 2050px;
  margin: 0 auto;
}

.post-container .post {
  margin-bottom: 60px;
  border: 1px solid #e6e6e6;
  border-radius: 3px;
  background-color: #ffffff;
}

.post > .post-header {
  height: 60px;
  padding: 16px 16px 16px 56px;
  border-bottom: 1px solid #efefef;
  font-size: 14px;
  font-weight: 600;
  line-height: 28px;
  color: #262626;
}
.post > .post-header > .profile {
  display: block;
  position: absolute;
  left: 16px;
  top: 16px;
  width: 28px;
  height: 28px;
  border-radius: 50%;
}
.post > .post-header > .profile > img {
  width: 100%;
  height: 100%;
}
.post > .post-header > a > .trigger{
	margin-top: 5px;
    }
.post > .sajin {
  font-size: 0;
  margin: 0 -1px 4px;
}
.post > .sajin > img {
  width: 100%;
}

.post > .post-footer {

}

.post > .post-footer > .btn-container {
  list-style: none;
  height: 40px;
  padding: 8px 0;
  font-size: 0;
  padding: 8px 15px;
}
.post > .post-footer > .btn-container > li {
  display: inline-block;

}
.post > .post-footer > .btn-container > li > a > img {
 	margin-top: -3px;	
}
.post > .post-footer > .btn-container > li > a > .heart{
 	margin-left:-10px;
    margin-right: 3px;	
}

.post > .post-footer > .btn-container > a > .bookmark{
  	margin-right: -10px;
  	margin-top: -3px;	
  	
}

.post > .post-footer > .like-container {
  height: 18px;
  margin-bottom: 8px;
  font-size: 14px;
  font-weight: 600;
  line-height: 18px;
  color: #262626;
  padding: 0 16px;
}

.post > .post-footer > .text-container {
  font-size: 14px;
  line-height: 18px;
  padding: 0 16px;
}
.post > .post-footer > .text-container > a {
  font-weight: 600;
}

.time-container {
  margin-left:20px; 
  color:#8e8e8e; 
  font-size:8pt; 
  clear:both;
  height: 18px;
  margin-bottom: 8px;
  line-height: 18px;
  color: #999999;
}

.post > .post-footer > .comment-container {
  height: auto;
  padding-top: 3px;
}


.modal-header, h4, .close {
    background-color: #5cb85c;
    color:white !important;
    text-align: center;
    font-size: 30px;
  }
  .modal-footer {
    background-color: #f9f9f9;
  }
	
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="../images/questgram.ico">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"	href="../css/style.css">
<link rel="stylesheet"	href="../Post/css/style.css">

<script src="../js/script.js"></script>
<script type="text/javascript">
	$(function(){
		$("#home").click(function(){
			$("#home img").attr("src","../images/home_b.PNG");
			$("#compass img").attr("src","../images/compass.PNG");
			$("#mainheart img").attr("src","../images/mainheart.PNG");
		});
		$("#compass").click(function(){
			$("#home img").attr("src","../images/home.PNG");
			$("#compass img").attr("src","../images/compass_b.PNG");
			$("#mainheart img").attr("src","../images/mainheart.PNG");
		});
		$("#mainheart").click(function(){
			$("#home img").attr("src","../images/home.PNG");
			$("#compass img").attr("src","../images/compass.PNG");
			$("#mainheart img").attr("src","../images/mainheart_b.PNG");
		});
		
		
//		*************여기서부터 팔로우 영역***************
		
		// 팔/언팔 클릭 시, follow테이블 insert/delete 하고 표시내용 바꾸기
		$("#btnFollow").on("click", function() {
			var now = $(this).attr("now");
			var userId = $(this).attr("userId");
			var thisId = $(this).attr("thisId");		// 임의값. 변경해야 함.
			console.log(now, userId, thisId);
			$.ajax({
				type: "post",
				dataType: "xml",
				data: {"userId":userId, "thisId":thisId, "now":now},
				url: "../follow/followaction.jsp",
				success: function(data) {
					var result = $(data).find("now").text();
					$("#btnFollow").text(result);
					$("#btnFollow").attr("now", result);
				}
			});
		});
		
		// 팔로우/팔로잉 리스트 dialog로 구현
		$("#show-followers").dialog({
			autoOpen: false,
			height: 400,
			width: 400,
			modal: true,
			resizable: false,
			draggable: false,
			open: function(event, ui) {
				$(".ui-widget-overlay").click(function() {
					$("#option").dialog("close");
				});
			}
		});
		$("#show-followings").dialog({
			autoOpen: false,
			height: 400,
			width: 400,
			modal: true,
			resizable: false,
			draggable: false,
			open: function(event, ui) {
				$(".ui-widget-overlay").click(function() {
					$("#option").dialog("close");
				});
			}
		});
		// 리스트 클릭 시 dialog 열기
		$("#followers").click(function() {
			$("#show-followers").dialog("open");
		});
		$("#followings").click(function() {
			$("#show-followings").dialog("open");
		});
//		*************팔로우 영역 끝***************	


//		*************게시글 영역 시작***************
		
		// 시작 시 뉴스피드 타입 게시글 hide
		$(document).ready(function() {
			$(".timeline-view").hide();
		})

	});
</script>
</head>
<%
	UserDao udao = new UserDao();
	FollowDao fdao = new FollowDao();
	BoardDao bdao = new BoardDao();
	CommentDao cdao = new CommentDao();
	
	// 유저 식별, 정보 가져오기
	String thisId = "3";
	// 임의로 줬지만, 원래는 앞 페이지에서 넘어온 프로필id값
	// String thisId = request.getParameter("thisId");
	UserDto udto = udao.getUser(thisId);
	
//	**********팔로우 영역 구현*********
	String userId = (String)session.getAttribute("userid");
	
	
	String now = fdao.followNow(thisId, userId);	//팔로우 여부
	List<FollowDto> werlist = fdao.getFollowers(thisId);	// 보던 프로필의 팔로워들
	List<FollowDto> inglist = fdao.getFollowings(thisId);	// 보던 프로필의 팔로잉들
//	**********팔로우 영역 끝*********


//	**********게시글 영역 구현*********
	String boardId = "start";	// 최초 실행 값
	
	String howMany = bdao.howMany(thisId);
	List<BoardDto> blist = bdao.getPrfBoard(thisId, boardId);
//	**********게시글 영역 끝***********

%>
<body>
	<header>
		<div id="box">
			<div id="logo" >
				<a href="main.jsp"><img src="../images/logo.png"></a>
			</div>
			<div id="search">
				<span id="glass"><i class="xi-search si-x"></i></span>
				<input type="text" placeholder="검색">
			</div>
			<nav>
				<ul>
					<li class="nav" id="home" width="35px" height="34px"><a href="main.jsp"><img src="../images/home_b.PNG"/></a></li>
					<li class="nav" id="compass" width="33px" height="34px"><a href="#"><img src="../images/compass.PNG"/></a></li>
					<li class="nav" id="mainheart" width="34px" height="34px"><a href="#"><img src="../images/mainheart.PNG"/></a></li>
					<li class="nav"><a href="#"><div class="info"></div></a></li>
				</ul>
			</nav>
		</div>
	</header>
	
	
	
	
	
	<!-- ***********본문 페이지 영역 시작************ -->
	
	<wrapper>
		<div id="maincontent">
			<div class="wholepage">
<!-- *************프로필 영역 시작*************** -->
	<div class="profile-container">
		<div class="profile-button">
			<div class="profile-logo">
				<canvas class="profile-canvas"></canvas>
				<img class="profile-img" src="../images/iz_one.jpg">
			</div>
		</div>		
		
		<section class="profile-content">
			<div class="about_user">
				<h2 class="nickname" style="margin-left: 20px;"><%=udto.getNickname() %></h2>
				<span id="btnFollow" style="cursor: pointer;"
				 	userId="<%=userId %>" thisId="<%=thisId %>" now="<%=now%>"><%=now %></span>
			</div>
			<ul class="status">
				<li>게시물&nbsp;<%=howMany %></li>
				
					<div class="fmodal" id="show-followers" title="팔로워">
					<%
						for (FollowDto wer: werlist) {
					%>		<span>
								<a href="#">사진 url : <%=wer.getProfile_img() %></a>
								<b><%=wer.getNickname() %> (<%=wer.getName() %>)</b>
							</span><hr>
					<%	}
					%>
					</div>
				<li id="followers">팔로워&nbsp;<%=werlist.size() %></li>
				
					<div class="fmodal" id="show-followings" title="팔로잉">
					<%
						for (FollowDto ing: inglist) {
					%>		<span>
								<a href="#">사진 url : <%=ing.getProfile_img() %></a>
								<b><%=ing.getNickname() %> (<%=ing.getName() %>)</b>
							</span><hr>
					<%	}
					%>
					</div>
				<li id="followings">팔로우&nbsp;<%=inglist.size() %></li>
			</ul>
			<div class="introduce">
				<%=udto.getName() %> (이름)<br>
				<%=udto.getIntroduce() %> (소개)
			</div>
		</section>
	</div>
<!-- *************프로필 영역 끝*************** -->





<!-- *****게시글 타입 선택***** -->
	<div class="typeof-view">
		<a class="select-view" view="grid-view">
			<img src="../images/gridtype.jpg" style="width: 100px; height: 40px;">
		</a>
		<a class="select-view" view="timeline-view">
			<img src="../images/newstype.jpg" style="width: 100px; height: 40px;">
		</a>
		<script type="text/javascript">
			$(".select-view").on("click", function() {
				var view = $(this).attr("view");
				console.log(view);
			});
		</script>
	</div>						

<%				

//				***********************게시글 영역 시작*************************
				for (BoardDto bdto: blist) {
					String bnow = fdao.followNow(bdto.getUser_id(), userId);
%>		


<!-- *****POST 형식 게시글 출력***** -->		
		<!-- 게시글, -->
  <div class="post-container" class="timeline-view">
  <input type="hidden" name="postnum" class="postnum" value="<%=bdto.getId()%>">
    <div class="wrap">

      <div class="post">
      
      
       
       
         <!-- 뉴스피드 헤드 -->
        <div class="post-header" >
          <!-- 프로필사진 -->
          <a href="#" class="profile"><img src="Post/image/0.gif" alt=""></a>
          
          <!-- 작성자 이름  -->
          <a href="#"><%=bdto.getUser_id() %></a>
          
             
          <!-- 메뉴 더 보기 출력 -->
            <a href="#"><img src="Post/image/more.PNG" width="32px" height="20px" id="trigger" 
              name="trigger" class="trigger" alt="" style="float: right;"></a>
            <!-- 다른 앱에 게시, 링크 복사, 공유하기, 보관, 수정, 삭제, 댓글기능 해제 -->
              <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" style="z-index:9999;">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
      
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form">
               <button type="button" class="btn btn-default btn-block">게시물로 이동</button>
                <button type="button" class="btn btn-default btn-block">링크 복사</button>
                <button type="button" class="btn btn-default btn-block">공유하기</button>
                <button type="button" class="btn btn-default btn-block">보관</button>
                <button type="button" class="btn btn-default btn-block"
                      onclick="location.href='Post/Post_Update_Form.jsp'">수정</button>
                <button type="button" class="btn btn-default btn-block"
                      onclick="location.href='Post/Post_Delete_Action.jsp?id=<%=bdto.getId()%>'">삭제</button>
                <button type="button" class="btn btn-default btn-block">댓글 기능 해제</button>
          </form>
        </div>
     </div>
      
    </div>
  </div> <!-- modal 끝 -->

     
            
            
            
            
        </div> <!-- 뉴스피드 헤더 끝 -->
        
        <!-- 업로드한 사진 -->
        <div class="sajin">
          <img src="Post/image/ramgi.jpeg" alt="">
        </div>
        
        <!-- ------------------------------------------- -->
        
        
        <!-- 사진 아래부분 -->
        <div class="post-footer">
           <!-- 버튼 컨테이너 -->
          <ul class="btn-container">
             <!-- 페어런트로 버튼컨테이너까지 호출한 뒤 next span으로 좋아요를 찾자 -->
             <!-- 좋아요 버튼 -->
            <li><img src="../Post/image/heart.png" board_id="<%=bdto.getId()%>"
            width="42px" height="32px"  class="heart" name="heart" alt="" ></li>
            
            <!-- 댓글달기 버튼 -->
            <li><img src="../Post/image/balloon.png" width="41px" height="32px" alt=""></li>
            
            <!-- 공유하기 버튼 -->
            <li><img src="../Post/image/plane.png" width="42px" height="32px" alt=""></li>
            
             <!-- 북마크 버튼 -->
             <img src="../Post/image/bookmark.png" width="43px" height="32px" class="bookmark" name="bookmark" alt="" style="float: right;">
           
          </ul>
          
          
          
          <!-- 좋아요 텍스트 -->
          <div class="like-container">
            <a href="#">좋아요&nbsp;<span class="cnt"><%=bdto.getLike_count()%></span>개</a>
          </div>
          
          <!-- 내용 -->
          <div class="text-container">
            <a href="#"><%=bdto.getUser_id() %></a>
              
              <span class="contents" id="contents">
              <h5><%=bdto.getContent() %></h5>
              </span>
              <span>
             
               <button type="button" id="more" style="border: none; background-color:#fff; color:#8e8e8e;">...더 보기</button>
              </span>   
          </div>
          
          <!-- 몇분전에 올린 게시글인지 표시 -->
          <div class="time-container"><%=bdto.getCreated_at() %></div>
          
          
          <!-- 댓글 -->
          <div class="comment-container">
             <!-- 댓글을 달 텍스트에리어 -->
            <textarea name="comment" placeholder="댓글 달기..." style="float: left; width:535px;"></textarea>
            
            <!-- 댓글 게시하기 버튼 -->
            
            <button type="submit" class="gesi">게시</button>
            <!-- <a href="#"><img src="Post/image/gesi.png" alt=""></a> -->
          </div>
        </div> <!-- post footer -->
      </div> <!-- post -->

    </div> <!-- wrap -->
  </div> <!-- post-container -->
  <!-- post-container -->
 
  
 <%}%>
   </div>
  
   <div class="tail">
   </div>
   
  <button type="button" id="list_more">더 보기</button> 
  <!-- 더보기 버튼 구현 생략 -->
  
           
<!-- *****POST 형식 게시글 출력 끝***** -->     




	
<!-- ************* 사진 타임라인 시작************** -->	
<main class="grid-view">
	<div class="container">
		<div class="gallery">
<%
	for (BoardDto bdto: blist) {
%>		
			<div class="gallery-item" tabindex="0">
				<img src="../images/iz_one.jpg" class="gallery-image" alt="">
				<div class="gallery-item-info">
					<ul>
						<li class="gallery-item-likes">
							<span class="visually-hidden">Likes: </span>
							<i class="fas fa-heart" aria-hidden="true"></i><%=bdto.getLike_count() %>
						</li>
						<li class="gallery-item-comments">
							<span class="visually-hidden">Comments: </span>
							<i class="fas fa-comment" aria-hidden="true"></i><%=bdto.getComment_count() %>
						</li>
					</ul>
				</div>
			</div>
<%	}
%>
</div>
		<!-- End of gallery -->
	</div>
	<!-- End of container -->

</main>

<!-- ************* 사진 타임라인 끝************** -->

      
           
<%		
//	**********게시글 영역 끝***********
%>

</div>
<!-- 	***********유저 타임라인 영역 끝**********		 -->
<%--
			<jsp:include page="usertime.jsp"/>
			<div id="side">
				<jsp:include page="../sideCOPY.jsp"/>
			</div>
--%>			
			<button type="button" class="btn btn-danger btn-me" style="width: 100px;"
				onclick="location.href='login_signup/logoutaction.jsp'">로그아웃</button>
		</div>
	</wrapper>
	
	
	


<!-- ***********본문 페이지 영역 끝************ -->	
	<bottom>
	
	</bottom>
</body>
</html>