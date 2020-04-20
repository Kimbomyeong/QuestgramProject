<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.BoardDao"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.FollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String boardId = request.getParameter("boardId");
	String userId = request.getParameter("userId");
	
	System.out.println(boardId + userId);
	
	BoardDao bdao = new BoardDao();
	List<BoardDto> list = bdao.getAllDatas(userId, boardId);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<data>
	<%
	for (BoardDto dto: list) {
	%>
	
		<boardId><%=dto.getId() %></boardId>
		<userId><%=dto.getUser_id() %></userId>
		<content><%=dto.getContent() %></content>
		<commentCount><%=dto.getComment_count() %></commentCount>
		<likeCount><%=dto.getLike_count() %></likeCount>
		<viewCount><%=dto.getView_count() %></viewCount>
		<shareCount><%=dto.getShare_count() %></shareCount>
		<createdAt><%=sdf.format(dto.getCreated_at()) %></createdAt>
		
		<name><%=dto.getName() %></name>
		<nickname><%=dto.getNickname() %></nickname>
		<profileImg><%=dto.getProfile_img() %></profileImg>
		
		<originName><%=dto.getOrigin_name() %></originName>
		<saveName><%=dto.getSave_name() %></saveName>

<%}
%>
</data>