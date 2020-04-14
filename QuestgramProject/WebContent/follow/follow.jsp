<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.FollowDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.FollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Follow</title>
<style type="text/css">
	.ui-dialog {
		border: 1px solid gray;
	}
</style>

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
$(function() {
	
	$("#btnFollow").on("click", function() {
		var now = $(this).text();
		var myid = 3;
		var id = 1;
		$.ajax({
			type: "post",
			dataType: "xml",
			data: {"myid":myid, "id":id, "now":now},
			url: "followaction.jsp",
			success: function(data) {
				var result = $(data).find("now").text();
				$("#btnFollow").text(result);
			}
		});
	});
	
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
	
	$("#followers").click(function() {
		$("#show-followers").dialog("open");
	});
	$("#followings").click(function() {
		$("#show-followings").dialog("open");
	});
	
});
</script>
</head>

<body>
<%
	// id 에는 임의값 "1"을 넣었지만, 나중에는 보고 있던 유저 프로필의 id값을 넘겨줄 예정
	// myid 에는 임의값 "3"을 넣었지만, 쿠키or세션으로 보는 '나'의 id값을 넘겨줄 예정
	UserDao udao = new UserDao();
	String id = "";
	String userid = (String)session.getAttribute("userid");
	FollowDao fdao = new FollowDao();
	
%>
	<span id="btnFollow"
		style="cursor: pointer; width: 20px; border: 1px solid pink;"><%=fdao.followNow(id, userid) %></span>

<%--	(안 먹혀서 위에 줬음)
	<script type="text/javascript">
		$("#btnFollow").on("click", function() {
			var now = $(this).text();
			if (now == "follow") {
				<%fdao.insertFollow(myid, id);%>
				$(this).text("unfollow");
				console.log("insert");
			} else {
				<%fdao.deleteFollow(myid, id);%>
				$(this).text("follow");
				console.log("delete");
			}
		});
	</script>
--%>
	
	<div class="fmodal" id="show-followers" title="팔로워">
	<%
		// 프로필의 팔로워들
		List<FollowDto> werlist = fdao.getFollowers(id);
		for (FollowDto wer: werlist) {
	%>		<span>
				<a href="#">사진 url : <%=wer.getProfile_img() %></a>
				<b><%=wer.getNickname() %> (<%=wer.getName() %>)</b>
			</span><hr>
	<%	}
	%>
	</div>
	
	<div class="fmodal" id="show-followings" title="팔로잉">
	<%
		// 프로필의 팔로잉들
		List<FollowDto> inglist = fdao.getFollowings(id);
		for (FollowDto ing: inglist) {
	%>		<span>
				<a href="#">사진 url : <%=ing.getProfile_img() %></a>
				<b><%=ing.getNickname() %> (<%=ing.getName() %>)</b>
			</span><hr>
	<%	}
	%>
	</div>
	
	<div>
		<button type="button" id="followers">followers</button>
		<button type="button" id="followings">followings</button>
	</div>
</body>
</html>