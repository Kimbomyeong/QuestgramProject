<%@page import="data.dto.BoardDto"%>
<%@page import="data.dto.FollowDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한글 엔코딩
	request.setCharacterEncoding("utf-8");



%>

<jsp:useBean id="dto" class="data.dto.BoardDto"/>
<jsp:useBean id="dao" class="data.dao.BoardDao"/>

<jsp:setProperty property="user_id" name="dto"/>
<jsp:setProperty property="content" name="dto"/>
<%
	//insert 메소드 호출
	BoardDto bdto = new BoardDto();
	
	String id = request.getParameter("user_id");
	String content = request.getParameter("content");
	String hashtag = request.getParameter("hashtag");
	
	
	dao.insertBoard(dto);
	String board_id = dto.getId();
	System.out.println("hashtag :" + hashtag + "board_id :" + board_id);
    
    response.sendRedirect("../main.jsp");	


%>