<%@page import="data.dao.FollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String userid = request.getParameter("userid");
	String now = request.getParameter("now");
	System.out.println(id + userid + now);
	FollowDao fdb = new FollowDao();
	
	if (now.equals("follow")) {
		fdb.insertFollow(userid, id);
		now = "unfollow";
	} else {
		fdb.deleteFollow(userid, id);
		now = "follow";
	}
%>
<now><%=now %></now>