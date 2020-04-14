<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>profile</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="shortcut icon" type="image/x-icon"
	href="images/questgram.ico">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/profile.css">
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
		$(".menu").click(function(){	
			$(".nav-stacked > li").removeClass("a_click");
			$(this).parent().addClass("a_click");

		});
	});
	
</script>
</head>
<body>
	<!-- navbar -->
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
					<li class="nav" id="home" width="35px" height="34px"><a href="../main.jsp"><img src="../images/home_b.PNG"/></a></li>
					<li class="nav" id="compass" width="33px" height="34px"><a href="#"><img src="../images/compass.PNG"/></a></li>
					<li class="nav" id="mainheart" width="34px" height="34px"><a href="#"><img src="../images/mainheart.PNG"/></a></li>
					<li class="nav"><a href="#"><div class="info"></div></a></li>
					<a href="../login_signup/logoutaction.jsp">
          			<span class="glyphicon glyphicon-off" style="font-size: 25px; margin-left: 20px; "></span>
        			</a>		
				</ul>
			</nav>
		</div>
	</header>
	<!-- /navbar -->

	<div class="container">
		<div class="row " style="border: 1px solid #BDBDBD;">
			<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 hidden-xs">
				<ul class="nav nav-stacked">
					<li class="a_click active"><a href="#profile"
						data-toggle="tab" class="menu">프로필 편집</a></li>
					<li><a href="#pwd" data-toggle="tab" class="menu">비밀번호 변경
					</a></li>
					<li><a href="#app" data-toggle="tab" class="menu">허가된 앱</a></li>
					<li><a href="#comment" data-toggle="tab" class="menu">댓글</a></li>
					<li><a href="#emails" data-toggle="tab" class="menu">이메일 및
							SMS</a></li>
					<li><a href="#phones" data-toggle="tab" class="menu">연락처
							관리 </a></li>
				</ul>
			</div>
			<!-- col-xs-4 -->

			<div class="col-sm-8 col-xs-12 ">
				<div class="tab-content" style="min-height: 333px;">
					<!-- 1. id가 profile일때 -->
					<div class="tab-pane in active" id="profile">
						<form class="form-horizontal">
							<div class="form-group">
								<div class="col-sm-3 control-label">
									<img src="../images/basic.png" class="profile_image">
								</div>
								<div class="col-sm-9 control-label " id="basic">
									<div style="float: left;">
										<div style="font-size: 20px;"></div>
										<label class="btn-file"
											style="cursor: pointer; color: #6699ff;"> 프로필 사진 수정 <input
											type="file" style="display: none;">
										</label>
									</div>

								</div>
							</div>

							<div class="form-group">
								<label for="name" class="col-sm-3 control-label">이름</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="name" />
								</div>
							</div>

							<div class="form-group">
								<label for="user_name" class="col-sm-3 control-label">사용자
									이름</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="user_name" />

								</div>
							</div>

							<div class="form-group">
								<label for="web" class="col-sm-3 control-label">주소</label>
								<div class="col-sm-9">
									<input multiple type="text" class="form-control" id="web" />
								</div>
							</div>
							<div class="form-group">
								<label for="intro" class="col-sm-3 control-label">소개</label>
								<div class="col-sm-9 ">
									<input type="text" class="form-control" id="intro">

								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<span id="helpBlock" class="help-block">개인정보</span>
								</div>
							</div>


							<div class="form-group">
								<label for="email" class="col-sm-3 control-label">이메일</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="email" />
								</div>
							</div>
							<div class="form-group">
								<label for="phone" class="col-sm-3 control-label">전화번호</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="phone" />
								</div>
							</div>

							<div class="form-group">
								<label for="gender" class="col-sm-3 control-label">성별</label>
								<div class="col-sm-4">
									<select class="form-control" name="gender" id="gender">
										<option value="none">선택안함</option>
										<option value="male">남성</option>
										<option value="female">여성</option>
									</select>

								</div>
							</div>


							<div class="form-group">
								<label class="col-sm-3 control-label">비슷한 계정 추천</label>

								<div class="col-sm-8 control-label">
									<label> <input type="checkbox" /> 팔로우할 만한 비슷한 계정을 추천할
										때 회원님의 계정을 포함합니다.
									</label>
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-6 col-sm-offset-3">
									<button type="submit" class="btn btn-primary">제출</button>
								</div>
							</div>
						</form>
					</div>
					<!-- id=profile (프로필 변경 ) -->
					<div class="tab-pane" id="pwd">

						<div class="form-horizontal pwdDiv">
							<form action="pwdAction" name="pwdForm" id="pwdForm" novalidate>
								<div class="form-group">
									<label class="col-sm-3 control-label">이전 비밀번호</label>
									<div class="col-sm-9">
										<input type="password" class="form-control" id="prev_pwd"
											name="prev_pwd" ng-required="true" ng-model="prev_pwd" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">새 비밀번호</label>
									<div class="col-sm-9">
										<input type="password" class="form-control" id="new_pwd1"
											name="new_pwd1" ng-required="true" ng-model="new_pwd1" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">새 비밀번호 확인</label>
									<div class="col-sm-9">
										<input type="password" class="form-control" id="new_pwd2"
											name="new_pwd2" ng-required="true" ng-model="new_pwd2">
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-6 col-sm-offset-3">
										<button id="pwdBtn" ng-disabled="pwdForm.$invalid"
											type="submit" class="btn btn-primary">비밀번호 변경</button>
									</div>
									<br />
									<div class="col-sm-9 col-sm-offset-3">

										<p id="pwdCheck"></p>

									</div>

								</div>
						</div>


						</form>

					</div>



					<div class="tab-pane" id="app">

						<div class="form-group">
							<div class="col-sm-offset-1 contorl-label"
								style="padding-top: 50px;">
								<h3>
									<small>Instagram 계정에 액세스하도록 허용한 앱이 없습니다.</small>
								</h3>
							</div>
						</div>


					</div>

					<div class="tab-pane" id="comment">
						<div style="padding-top: 50px;"></div>
						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<label> <input type="checkbox" />부적절한 댓글 숨기기
								</label>
								<div>불쾌한 내용으로 자주 신고되는 단어 또는 문구가 포함된 댓글을 숨깁니다.</div>
							</div>
						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<label>맞춤 키워드 </label>
								<div>아래의 단어나 문구가 포함된 댓글은 숨겨집니다.</div>
								</br> <input type="text" class="form-control" id="intro"
									placeholder="쉼표(,)로 구분하여 키워드를 추가하세요">
							</div>
						</div>


					</div>

					<div class="tab-pane" id="emails">
						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<h3 style="font-weight: bold;">받아보기:</h3>
							</div>
						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<label> <input type="checkbox" checked>
								</label> <label>뉴스 이메일</label>
								<p>새로운 제품에 대한 소식을 가장 먼저 받아보세요.</p>
							</div>

						</div>
						<br />

						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<label> <input type="checkbox" checked>
								</label> <label>알림 이메일</label>
								<p>유용한 최신 정보를 빠짐없이 받아보세요.</p>
							</div>

						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<label> <input type="checkbox" checked>
								</label> <label>제품 이메일</label>
								<p>Instagram 도구 사용에 대한 팁을 확인해보세요.</p>
							</div>

						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<label> <input type="checkbox" checked>
								</label> <label>설문 조사 이메일</label>
								<p>의견을 보내 조사 연구에 참여하세요.</p>
							</div>

						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-1 control-label">
								<label> <input type="checkbox" checked>
								</label> <label>SMS 메시지</label>
								<p>SMS로 알림을 받아보세요.</p>
							</div>

						</div>
						<br />
					</div>


					<div class="tab-pane " id="phones">
						<div class="form-group">
							<div class="control-label col-sm-offset-1">
								<h3 style="font-weight: bold;">연락처 관리</h3>
							</div>
						</div>
						<div class="form-group">
							<div class="control-label col-sm-offset-1">
								<p>Instagram에 업로드한 연락처입니다. 연락처를 삭제하려면 해당 연락처를 선택하고 삭제를 누르세요.
									동기화된 모든 연락처를 삭제할 수도 있습니다. 단, 연락처 업로드 기능이 계속 설정되어 있는 경우 여기에서
									연락처를 삭제해도 해당 정보가 다시 업로드됩니다.</p>
								<br />
								<p>업로드한 연락처 정보는 Instagram이 회원님에게 친구를 추천하거나 이용 환경을 개선하는 데
									사용됩니다. 이 연락처 정보는 회원님만 볼 수 있습니다.
							</div>
						</div>
						<div class="form-group">
							<div class="control-label col-sm-offset-1">
								<div class="bottom_border">
									<h4 style="font-weight: bold;">동기화된 연락처 0개</h4>
								</div>

								<p>Instagram에 연락처를 업로드하면 여기에 표시됩니다.</p>

								<button type="submit" class="btn btn-primary disabled">삭제</button>
								<br />

							</div>
						</div>

					</div>
				</div>

			</div>
			<!-- col-xs-8 -->

		</div>
		<!-- row -->

	</div>
	<!-- container -->
</body>
</html>