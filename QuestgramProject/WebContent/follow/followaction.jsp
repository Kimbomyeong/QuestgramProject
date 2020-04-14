<%@page import="data.dao.FollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String myid = request.getParameter("myid");
	String now = request.getParameter("now");
	
	FollowDao fdb = new FollowDao();
	
	if (now.equals("follow")) {
		fdb.insertFollow(myid, id);
		now = "unfollow";
	} else {
		fdb.deleteFollow(myid, id);
		now = "follow";
	}
%>
<now><%=now %></now>