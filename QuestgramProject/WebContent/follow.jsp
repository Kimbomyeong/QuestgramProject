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

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
$(function() {
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
		// 임의값 "1"을 넣었지만,
		// 나중에는 보고 있던 유저 프로필의 id값을 넘겨줄 예정
		String id = "1";
		FollowDao fdb = new FollowDao();
	%>
	
	<div id="show-followers" title="팔로워">
	<%
		List<FollowDto> werlist = fdb.getFollowers(id);
		
		for (FollowDto wer: werlist) {
	%>		<span>
				<a href="#">사진 url : <%=wer.getProfile_img() %></a>
				<b><%=wer.getNickname() %> (<%=wer.getName() %>)</b>
			</span><hr>
	<%	}
	%>
	</div>
	
	<div id="show-followings" title="팔로잉">
	<%
		List<FollowDto> inglist = fdb.getFollowings(id);
		
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