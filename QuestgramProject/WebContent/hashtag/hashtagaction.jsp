<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String board_id = request.getParameter("board_id");
	String hashtag = request.getParameter("hashtag");
	
	BoardDao bdao = new BoardDao();
	
	bdao.insertHashtag(board_id, hashtag);
%>