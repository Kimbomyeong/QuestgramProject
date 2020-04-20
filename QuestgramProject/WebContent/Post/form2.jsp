<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.BoardDao"%>
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

input:focus {
	outline: none;
}

button:focus {
	outline: none;
}

textarea:focus {
	outline: none;
}

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
	$(function() {
		$(".submenubtn").hide();
		$(".commentincontent").hover(function() {
			$(this).children(".submenubtn").show();
		}, function() {
			$(this).children(".submenubtn").hide();
		});
		$(".submenubtn").click(function() {
			$("#submenu").modal();
		});

		$('.heart')
				.on(
						{
							'click' : function() {
								var src = ($(this).attr('src') === './image/heart.png') ? './image/red.png'
										: './image/heart.png';
								$(this).attr('src', src);
							}

						}); // 하트 클릭 

		//북마크 클릭
		$('.bookmark')
				.on(
						{
							'click' : function() {
								var src = ($(this).attr('src') === './image/bookmark.png') ? './image/black.png'
										: './image/bookmark.png';
								$(this).attr('src', src);
							}

						}); // 북마크 클릭 

		$(document).ready(function() {
			$(".trigger").click(function() {
				$(".myModal").modal();
			});
		}); //모달 열기

	});
</script>
</head>
<%
	String board_id = request.getParameter("board_id");
	String user_id = request.getParameter("user_id");
	BoardDao bdao = new BoardDao();
	BoardDto bdto = bdao.getBoardDataWithUser(board_id);
	System.out.println("보드아이디" + board_id);
	String root = request.getContextPath();
	System.out.println(root);
%>
<body>
	<header>
		<div id="box">
			<div id="logo">

				<a href="../main.jsp"><img src="../images/logo.png"></a>
			</div>
			<div id="search">
				<span id="glass"><i class="xi-search si-x"></i></span> <input
					type="text" placeholder="검색">
			</div>
			<nav>
				<ul class="form2nav">
					<li class="nav" id="home" width="35px" height="34px"><a
						href="../main.jsp"><img src="../images/home_b.PNG" /></a></li>
					<li class="nav" id="compass" width="33px" height="34px"><a
						href="#"><img src="../images/compass.PNG" /></a></li>
					<li class="nav" id="mainheart" width="34px" height="34px"><a
						href="#"><img src="../images/mainheart.PNG" /></a></li>
					<li class="nav"><a href="#"><div class="info"></div></a></li>
					<li class="nav" id="logout"><a
						href="../login_signup/logoutaction.jsp"> <span
							class="glyphicon glyphicon-off"
							style="font-size: 25px; margin-left: 20px;"></span>
					</a></li>
				</ul>
			</nav>
		</div>
	</header>

	<!-- 게시글, -->
	<div class="post-container">
		<div class="wrap">

			<table class="post table table-bordered"  style="width:930px; height:450px; border: 1px solid #efefef;">
				<tr>
					<td rowspan="4" style="padding: 0;">
						<div class="sajin"></div> <img src="./image/ramgi.jpeg"
						class="sajinimg" style="width: 598px; height: 460px;" alt="">
						</div>
					</td>
					<td style="padding: 0;">
						<!--뉴스피드 헤드-->
						<div class="post-header" align="right">

							<!-- 프로필사진 -->
							<a href="#" class="profile"> <img src="./image/0.gif" alt=""
								align=""></a>

							<!-- 작성자 이름,팔로우,더보기 버튼까지  -->
							<div class="head"
								style="overflow: inherit; position: relative; top: 35%">

								<a href="#" style="float: left; font-weight: bold;"><%=bdto.getNickname()%></a>
								<span style="float: left; font-weight: bold; padding: 0 3px;">·</span>
								<a href="#" style="float: left; font-weight: bold;">팔로잉</a> <a
									href="#"><img src="./image/more.PNG" width="26px"
									height="18px" class="trigger" name="trigger" class="trigger"
									alt="" style="float: right; margin-right: 10px;"></a>
							</div>
							<!-- head -->
						</div> <!-- 뉴스피드 헤드 끝 -->
					</td>
				</tr>
				<tr>
					<td style="padding: 0;">
						<div class="text-container" align="right">
							<!-- 프로필사진 -->
							<div class="usercomment">
								<a href="#" class="profile"
									style="display: inline; overflow: hidden;"> <img
									src="./image/0.gif" alt="" align="">
								</a> <a href="#"
									style="display: inline; overflow: hidden; float: left; font-weight: bold; margin-top: 25px; margin-right: 10px;"><%=bdto.getNickname()%></a>
								<span class="firstcomment"> <%=bdto.getContent()%></span>
								<time
									style="float: left; opacity: 0.7; clear: both; margin: 15px 20px 20px 60px; font-size: 10px;">n일전</time>
							</div>
							<!--댓글 리스트 출력-->
							<%
								CommentDao cdao = new CommentDao();
								List<CommentDto> cdto = cdao.getComment(board_id);
								for (CommentDto dto : cdto) {
							%>
							<br>
							<div class="commentincontent" style="">
								<input type="hidden" name="user_id" value="<%=dto.getUser_id() %>">
								<span style="float: left; margin-right: 13px; margin-top: 5px;">
								<img style="width: 32px; height: 32px; border-radius: 100%;"
									src="<%=dto.getProfile_img()%>" /></span> <b
									style="float: left; margin-top: 5px; margin-right: 10px;"><%=dto.getId()%></b>
								<span style="float: left; margin-top: 5px;"><%=dto.getContent()%></span>
								<div class="submenubtn" style="z-index: 9999;">
								<img style="cursor: pointer;" src="../Post/image/more.PNG" />
								</div>
								<span class="joayo"><img style="float: right; width: 15px; height: 15px;"
									src="../images/mainheart.PNG" /></span> <br>
								<div
									style="float: left; clear: both; margin-top: -20px; margin-left: 45px; color: #8e8e8e;">
									<br>
									<span><%=dto.getCreated_at()%></span>&nbsp;&nbsp;&nbsp; <span><a
										style="font-weight: bold; color: #8e8e8e;">답글 달기</a></span>
								</div>
							</div>
						<div class="submenu modal fade" id="submenu" role="dialog"
							style="z-index: 9999;">
							<div class="modal-dialog">
								<!-- Modal content-->
								<div class="modal-content" style="margin-top: 250px;">
									<div class="smodal-body" style="padding: 40px 50px;">
										<form role="form" action="../comment/commentdelete2.jsp"
											method="post">
											<input type="hidden" name="commentno" value="<%=dto.getCommentno()%>"> 
											<input type="hidden" name="user_id" value="<%=dto.getUser_id()%>">
											<input type="hidden" name="board_id" value="<%=dto.getBoard_id()%>">
											<button type="button" class="btn btn-default btn-block"
												style="color: red;">
												<b>신고</b>
											</button>
											<button type="submit" class="btn btn-default btn-block">
												<b>삭제</b>
											</button>
											<button type="button" class="btn btn-default btn-block"
												onclick="$('.submenu').modal('hide')">
												<b>취소</b>
											</button>
										</form>
									</div>
								</div>
							</div>
						</div> <!-- modal 끝 --> <%} %>
						</div>
					</td>
				</tr>
				<tr>
					<td style="padding: 0;">
						<!-- 버튼 컨테이너 -->
						<div class="btn1" align="right">
							<ul class="btn-container">

								<!-- 좋아요 버튼 -->
								<li><a href="#"><img src="./image/heart.png"
										width="42px" height="33px" class="heart" class="heart"
										name="heart" alt=""
										style="margin-top: 10px; margin-left: 5px;"></li>

								<!-- 댓글달기 버튼 -->
								<li><a href="#"><img src="./image/balloon.png"
										width="40px" height="30px" alt="" style="margin-top: 10px;"></a></li>

								<!-- 공유하기 버튼 -->
								<li><a href="#"><img src="./image/plane.png"
										width="40px" height="32px" alt="" style="margin-top: 10px;"></a></li>

								<!-- 북마크 버튼 -->
								<a href="#"><img src="./image/bookmark.png" width="43px"
									height="32px" class="bookmark" class="bookmark" name="bookmark"
									alt=""
									style="float: right; margin-right: -5px; margin-top: 12px;"></a>

							</ul>
							<!-- 좋아요 버튼 -->
							<div class="like-container"
								style="overflow: inherit; float: left; margin-left: 10px; margin-top: -8px; margin-bottom: 2px;">
								<a href="#" style="margin-left: 10px;"><b>좋아요 <%=bdto.getLike_count()%>개
								</b></a>
							</div>
							<time
								style="float: left; opacity: 0.7; clear: both; margin-left: 20px; font-size: 10px; margin-top: 5px;">n일
								전</time>

						</div> <!-- 버튼 컨테이너 -->
					</td>
				</tr>
				<tr>
					<td style="padding: 0;">
						<!-- 댓글 -->
						<div class="ans" align="right">
							<form action="../comment/commentadd2.jsp" method="post"
								style="height: 45pt;">
								<%
									CommentDao cdb = new CommentDao();
								%>
								<input type="hidden" name="user_id" value="<%=user_id%>">
								<input type="hidden" name="board_id" value="<%=board_id%>">
								<input type="hidden" name="parents_comments_id" value="<%=1%>">
								<table>
									<tr>
										<td>
											<!-- 댓글을 달 텍스트에리어 --> <textarea name="content"
												style="resize: none;" class="comment" placeholder="댓글 달기..."></textarea>
										</td>
										<!-- 댓글 게시하기 버튼 -->
										<td>
											<button type="submit" class="gesi">게시</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>



	<main>
		<div class="container" style="margin-top:20px;">

			<div class="gallery">
				<%
					for (int j = 0; j < 12; j++) {
				%>
				<div class="gallery-item" tabindex="0">

					<img src="./image/0.gif" class="gallery-image" alt="">

					<div class="gallery-item-info">

						<ul>
							<li class="gallery-item-likes"><span class="visually-hidden">Likes:</span>
								<i class="fas fa-heart xi-heart" aria-hidden="true"></i> 56</li>
							<li class="gallery-item-comments"><span
								class="visually-hidden">Comments:</span> <i
								class="fas fa-comment xi-speech" aria-hidden="true"></i> 2</li>
						</ul>

					</div>

				</div>
				<%
					}
				%>
			</div>
			<!-- End of gallery -->

			<!-- <div class="loader"></div> -->

		</div>
		<!-- End of container -->

	</main>
	<!--modal-->
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

</body>
</html>