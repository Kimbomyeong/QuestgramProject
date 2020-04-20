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
	#btnFollow {
		color: white;
		font-size: 11pt; font-weight: bold;
		background-color: #0067a3;
		padding: 5px;
		width: 100px; height: 25px;
		border-radius: 10%;
	}
</style>

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
$(function() {
	
	$("#btnFollow").on("click", function() {
		var now = $(this).attr("now");
		var userid = $(this).attr("userid");
		var thisid = 3;		// 임의값. 변경해야 함.
		
		$.ajax({
			type: "post",
			dataType: "xml",
			data: {"userid":userid, "thisid":thisid, "now":now},
			url: "follow/followaction.jsp",
			success: function(data) {
				var result = $(data).find("now").text();
				$("#btnFollow").text(result);
				$("#btnFollow").attr("now", result);
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
	String thisid = "3";	// 임의값. 보고 있던 유저 프로필의 id값을 넘겨줄 예정.
	//String thisid = request.getParameter("thisid"); 
	String userid = (String)session.getAttribute("userid");

	FollowDao fdao = new FollowDao();
	String now = fdao.followNow(thisid, userid);
	
%>
	<span id="btnFollow" userid="<%=userid %>" now="<%=now %>"
		style="cursor: pointer;"><%=now %></span>

<%--	(안 먹혀서 위에 줬음..)
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
	<hr>
	<div class="fmodal" id="show-followers" title="팔로워">
	<%
		// 보던 프로필의 팔로워들
		List<FollowDto> werlist = fdao.getFollowers(thisid);
		for (FollowDto wer: werlist) {
	%>		<span>
				<input type="hidden" user_id="<%=wer.getId()%>">
				<a href="#">사진 url : <%=wer.getProfile_img() %></a>
				<b><%=wer.getNickname() %> (<%=wer.getName() %>)</b>
			</span><hr>
	<%	}
	%>
	</div>
	
	<div class="fmodal" id="show-followings" title="팔로잉">
	<%
		// 보던 프로필의 팔로잉들
		List<FollowDto> inglist = fdao.getFollowings(thisid);
		for (FollowDto ing: inglist) {
	%>		<span>
				<input type="hidden" user_id="<%=ing.getId()%>">
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
	
	<hr>
	
	<div id="recommend">
		<h3>팔로워 추천</h3>
	<%	
		List<FollowDto> rlist = fdao.rcmmdFollow(userid);
		for (FollowDto rcm: rlist) {
	%>		<span>
				<a href="#">사진 url : <%=rcm.getProfile_img() %></a>
				<b><%=rcm.getNickname() %> (<%=rcm.getName() %>)</b>
			</span><br>
	<%	}
	%>	

	</div>
	
</body>
</html>