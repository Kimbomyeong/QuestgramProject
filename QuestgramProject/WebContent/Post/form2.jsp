<%@page import="java.util.List"%>
<%@page import="data.dto.CommentDto"%>
<%@page import="data.dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" content="width=device-width, initial-scale=1">

<title>Questgram</title>
<link rel="stylesheet" href="./css/style2.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
body {
	background-color: #fafafa;
}

input:focus{outline:none;}
button:focus{outline:none;}
textarea:focus{outline:none;}


.modal-header, h4, .close {
	background-color: #5cb85c;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

.modal-footer {
	background-color: #f9f9f9;
}

a {
	cursor: pointer;
	color: black;
}

ul {
	float: left;
	margin-left: -40px;
	width: 435px;
}

li {
	list-style-type: none;
	float: left;
}
</style>
<script type="text/javascript">
$(function(){
	//하트 클릭.
/* $(".heart").click(function(){
	
		$(this).attr('src','./image/red.png');
	}); */
	
	$('.heart').on({
	   'click':function(){
			var src=($(this).attr('src')==='./image/heart.png')
			 ?'./image/red.png'
		     :'./image/heart.png';
			$(this).attr('src',src);
		}
	
	}); // 하트 클릭 
	
	//북마크 클릭
	$('.bookmark').on({
	   'click':function(){
			var src=($(this).attr('src')==='./image/bookmark.png')
			 ?'./image/black.png'
		     :'./image/bookmark.png';
			$(this).attr('src',src);
		}
	
	}); // 북마크 클릭 
	
	
    $(document).ready(function(){
		  $(".trigger").click(function(){
		    $(".myModal").modal();
		  });
		}); //모달 열기
	
});


</script>
</head>
<%
String board_id=request.getParameter("board_id");
String user_id=request.getParameter("user_id");

CommentDao cdao=new CommentDao();
%>
<body>


	<!-- 게시글, -->
	<div class="post-container">
		<div class="wrap">

			<div class="post">

				<!--뉴스피드 헤드-->
				<div class="post-header" align="right">

					<!-- 프로필사진 -->
					<a href="#" class="profile"> <img src="./image/0.gif" alt=""
						align=""></a>

					<!-- 작성자 이름,팔로우,더보기 버튼까지  -->
					<div class="head"
						style="overflow: inherit; position: relative; top: 40%">

						<a href="#" style="float: left; font-weight: bold;">작성자</a> <span
							style="float: left; font-weight: bold; padding: 0 3px;">·</span>
						<a href="#" style="float: left; font-weight: bold;">팔로우</a> <a
							href="#"><img src="./image/more.PNG" width="26px"
							height="18px" class="trigger" name="trigger" class="trigger"
							alt="" style="float: right; margin-right: 10px;"></a>

						<div class="modal fade" class="myModal" role="dialog">
							<div class="modal-dialog">

								<!-- Modal content-->
								<div class="modal-content">

									<div class="modal-body" style="padding: 40px 50px;">
										<form role="form">
											<button type="button" class="btn btn-default btn-block">게시물로
												이동</button>
											<button type="button" class="btn btn-default btn-block">링크
												복사</button>
											<button type="button" class="btn btn-default btn-block">공유하기</button>
											<button type="button" class="btn btn-default btn-block">보관</button>
											<button type="button" class="btn btn-default btn-block">수정</button>
											<button type="button" class="btn btn-default btn-block">삭제</button>
											<button type="button" class="btn btn-default btn-block">댓글
												기능 해제</button>
										</form>
									</div>
								</div>

							</div>
						</div>
						<!-- modal 끝 -->

					</div>
					<!-- head -->



				</div>
				<!-- 뉴스피드 헤드 끝 -->
				<div class="text-container" align="right"
					style="border-top: 1px solid #efefef;">
					<!-- 프로필사진 -->
					<a href="#" class="profile"> <img src="./image/0.gif" alt=""
						align=""></a> <a href="#"
						style="display: block; overflow: inherit; position: relative; top: 11%; float: left; font-weight: bold">작성자</a>
					<span style="float: left; margin: -10px 50px 10px 60px;"> 
					</span>
					<time style="float: left; opacity: 0.7; clear: both; margin: 10px 20px 20px 60px; font-size: 10px;">n일전</time>
					<!--댓글 리스트 출력-->
					<%List<CommentDto> cdto=cdao.getComment(board_id);
					for(CommentDto dto:cdto){%>
						<span><img src="<%=dto.getProfile_img()%>"/></span>
						<span><%=dto.getId()%></span>
						<span><%=dto.getContent()%></span>
						<span style="float:right; width:15px; height:15px;"><img src="images/mainheart.PNG"/></span>
						<div>
						<span><%=dto.getCreated_at() %></span>&nbsp;&nbsp;&nbsp;
						<span><a style="font-weight:bold; color:#717171;">답글 달기</a></span>
						</div>
						<%} %>
				</div>
				<!-- 버튼 컨테이너 -->
				<div class="btn1" align="right"
					style="border-top: 1px solid #efefef;">
					<ul class="btn-container">

						<!-- 좋아요 버튼 -->
						<li><a href="#"><img src="./image/heart.png" width="42px"
								height="33px" class="heart" class="heart" name="heart" alt=""
								style="margin-top: 10px; margin-left: 5px;"></li>

						<!-- 댓글달기 버튼 -->
						<li><a href="#"><img src="./image/balloon.png"
								width="40px" height="30px" alt="" style="margin-top: 10px;"></a></li>

						<!-- 공유하기 버튼 -->
						<li><a href="#"><img src="./image/plane.png" width="40px"
								height="32px" alt="" style="margin-top: 10px;"></a></li>

						<!-- 북마크 버튼 -->
						<a href="#"><img src="./image/bookmark.png" width="43px"
							height="32px" class="bookmark" class="bookmark" name="bookmark"
							alt="" style="float: right; margin-right: -5px; margin-top: 12px;"></a>

					</ul>
					<!-- 좋아요 버튼 -->
					<div class="like-container"
						style="overflow: inherit; float: left; margin-left: 10px; margin-top: -5px;">
						<a href="#" style="margin-left: 10px;">좋아요 n개</a>
					</div>
					<time
						style="float: left; opacity: 0.7; clear: both; margin-left: 20px; font-size: 10px; margin-top: 5px;">n일	전</time>

				</div>
				<!-- 버튼 컨테이너 -->

				<!-- 댓글 -->
				<div class="ans" align="right"
					style="border-top: 1px solid #efefef;">
					<!-- 댓글을 달 텍스트에리어 -->
					<textarea name="comment" class="comment" placeholder="댓글 달기..."></textarea>

					<!-- 댓글 게시하기 버튼 -->

					<button type="submit" class="gesi">게시</button>
				</div>



				<div class="sajin" ></div>
					<img src="./image/ramgi.jpeg" class="sajinimg"
						style="width: 598px; height: 460px;" alt="">
				</div>
			</div>
		</div>
	</div>






	<!-- ------------------------------------------- -->





	<main>

		<div class="container">

			<div class="gallery">

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 56</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 2</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 89</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 5</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-type">

						<span class="visually-hidden">Gallery</span><i
							class="fas fa-clone" aria-hidden="true"></i>

					</div>

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 42</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 1</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-type">

						<span class="visually-hidden">Video</span><i class="fas fa-video"
							aria-hidden="true"></i>

					</div>

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 38</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 0</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-type">

						<span class="visually-hidden">Gallery</span><i
							class="fas fa-clone" aria-hidden="true"></i>

					</div>

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 47</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 1</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 94</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 3</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-type">

						<span class="visually-hidden">Gallery</span><i
							class="fas fa-clone" aria-hidden="true"></i>

					</div>

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 52</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 4</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 66</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 2</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-type">

						<span class="visually-hidden">Gallery</span><i
							class="fas fa-clone" aria-hidden="true"></i>

					</div>

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 45</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 0</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 34</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 1</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 41</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 0</li>
						</ul>

					</div>

				</div>

				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-type">

						<span class="visually-hidden">Video</span><i class="fas fa-video"
							aria-hidden="true"></i>

					</div>

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i
								class="fas fa-heart" aria-hidden="true"></i> 30</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span><i
								class="fas fa-comment" aria-hidden="true"></i> 2</li>
						</ul>

					</div>

				</div>

			</div>
			<!-- End of gallery -->

			<!-- <div class="loader"></div> -->

		</div>
		<!-- End of container -->

	</main>

<% System.out.println(board_id); %>
<% System.out.println(user_id); %>

</body>
</html>