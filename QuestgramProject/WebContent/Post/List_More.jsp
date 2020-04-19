<%@page import="data.dto.ImageDto"%>
<%@page import="data.dao.ImageDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
   request.setCharacterEncoding("utf-8");
   
   String boardId = request.getParameter("boardId");
   String userId = request.getParameter("userId");
   
   System.out.println(boardId + userId);
   
   BoardDao bdao = new BoardDao();
   List<BoardDto> list = bdao.getAllDatas(userId, boardId);
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   ImageDao idao = new ImageDao();
%>
<list>
   <%
   for (BoardDto dto: list) {
	   List<String> imageList = idao.boardIdImage(dto.getId());
   %>
   <data>
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
      <%
      	for(String image : imageList){
      		%>
		      <imageList> <%= image %> </imageList>      		
      		<%
      	}
      %>
   </data>
<%}
%>
</list>