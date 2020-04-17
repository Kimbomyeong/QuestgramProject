<%@page import="data.dto.UserDto"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="data.dao.BoardDao"%>
<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.FollowDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.FollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Profile Main</title>
<style type="text/css">
	* {
		align-items: stretch;
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
</style>
<script type="text/javascript">
$(function() {
	
//	*************여기서부터 팔로우 영역***************
	
	// 팔/언팔 클릭 시, 테이블 insert/delete 하고 표시내용 바꾸기
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
//	*************팔로우 영역 끝***************	
	
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
<%System.out.println(userId + ", " + thisId + ", " + now); %>
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

<%				

//				***********************게시글 영역 시작*************************
				for (BoardDto dto: blist) {
					String bnow = fdao.followNow(dto.getUser_id(), userId);
%>		
		<!-- 게시글, -->
		  <div class="post-container">
		    <div class="wrap">

		      <div class="post">
		      
		       <!--뉴스피드 헤드-->
		        <div class="post-header" style="border: solid; border-width: 1px;"align="right" >
		        
		         <!-- 프로필사진 -->
		          <a href="#" class="profile">
		          <img src="./image/0.gif" alt="" align=""></a>
		          
		          <!-- 작성자 이름,팔로우,더보기 버튼까지  -->
		          <div class="head" style="; overflow : inherit; position: relative; top:40%">
		        
		          <a href="#" style="float: left;">작성자 <%=dto.getNickname() %>(<%=dto.getName() %>)</a>
			
			<!-- 팔로우 여기에 작성하겠습니다 BY 김령주 -->
					<span id="btnFollow" style="cursor: pointer;"
						userId="<%=userId %>" thisId="<%=dto.getUser_id() %>" now="<%=bnow%>"><%=bnow %></span>
			<!-- 여기까지 팔로우 작업이었습니다 BY 김령주 -->
		          
		          <a href="#"><img src="./image/more.PNG" width="60px" height="30px" id="trigger" 
		              name="trigger" class="trigger" alt="" style="float: right;"></a>
		              
		              <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		      
		        <div class="modal-body" style="padding:40px 50px;">
		          <form role="form">
		      			<button type="button" class="btn btn-default btn-block">게시물로 이동</button>
		                <button type="button" class="btn btn-default btn-block">링크 복사</button>
		                <button type="button" class="btn btn-default btn-block">공유하기</button>
		                <button type="button" class="btn btn-default btn-block">보관</button>
		                <button type="button" class="btn btn-default btn-block">수정</button>
		                <button type="button" class="btn btn-default btn-block">삭제</button>
		                <button type="button" class="btn btn-default btn-block">댓글 기능 해제</button>
		          </form>
		        </div>
		     </div>
		      
		    </div>
		  </div> <!-- modal 끝 -->
		              
		          </div><!-- head -->
		          
		        
		        
		        </div> <!-- 뉴스피드 헤드 끝 -->
		         <div class="text-container" align="right" style="border-width: 1px;">
		             <!-- 프로필사진 -->
		          <a href="#" class="profile">
		          <img src="./image/0.gif" alt="" align=""></a>
		             <a href="#" style="display: block; overflow: inherit; position: relative; top: 11%; float: left;" >작성자: <%=dto.getNickname() %></a>
		                <span style="float: left; margin: 0px 20px 20px 20px;">
		                   4월9일 목요일 오후4시 스토리보드 발표.
			              4월21일 화요일 중간프로젝트 발표.<br>
			              <%=dto.getContent() %>
		                </span>
		                <time style="float: left; opacity: 0.7; clear: both; margin: 10px 20px 20px 20px; font-size: 10px;">n일전 / 작성일: <%=dto.getCreated_at() %></time>
		             
		             
		         
		          </div> 
		          	<!-- 버튼 컨테이너 -->
		         <div class="btn1" align="right" style="border-width: 1px;">
		           <ul class="btn-container">
		          	
		          	<!-- 좋아요 버튼 -->
		            <li><a href="#"><img src="./image/heart.png" width="42px" height="32px" id="heart" class="heart" name="heart" alt="" ></li>
		            
		            <!-- 댓글달기 버튼 -->
		            <li><a href="#"><img src="./image/balloon.png" width="41px" height="32px" alt=""></a></li>
		            
		            <!-- 공유하기 버튼 -->
		            <li><a href="#"><img src="./image/plane.png" width="42px" height="32px" alt=""></a></li>
		            
		             <!-- 북마크 버튼 -->
		             <a href="#"><img src="./image/bookmark.png" width="43px" height="32px" id="bookmark" class="bookmark" name="bookmark" alt="" style="float: right;"></a>
		           
		          </ul>
		          	<!-- 좋아요 버튼 -->
		              <div class="like-container" style="overflow: inherit; float: left; margin-left: 10px;">
		            <a href="#">좋아요 <%=dto.getLike_count() %>개</a>
		              </div>
		              <time style="float: left; opacity: 0.7; clear: both; margin-left: 10px;">n일 전</time>
		              
		         </div> <!-- 버튼 컨테이너 -->
		         
		         <!-- 댓글 -->
		         <div class="ans" align="right" style="border-width: 1px;">
		         	<!-- 댓글을 달 텍스트에리어 -->
		            <textarea name="comment" placeholder="댓글 달기..." 
		            style="float: left;width:350px; margin-top: 16px; margin-bottom: 3px; height: 25px; border: none;"></textarea>
		            
		            <!-- 댓글 게시하기 버튼 -->
		            
		            <button type="submit" class="gesi" 
		            style="border: none; color: #0095f6; cursor: pointer; opacity: 0.7; margin-top: 16px; height: 25px; margin-right: 3px;">
		                게시</button>
		         </div>
		          
		     
		        
		         <div class="sajin" style="width:598px;
			           height: 598px;">
		          <img src="./image/ramgi.jpeg" align="left" class="sajinimg" style="width:598px; 
			            height: 598px;" alt="">
			            
			            
		        </div>
		        </div>
		        </div>
		        </div>
		
		
<%	}
	

		// 전체출력 후 "더보기" 버튼 구현
		
%>		<button type="button" id="more" style="font-weight: bold;">더보기</button>
		<script type="text/javascript">
		
		</script>
<%		
//	**********게시글 영역 끝***********
%>

</div>
</body>
</html>