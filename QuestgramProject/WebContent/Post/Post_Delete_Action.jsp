<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%


String id = request.getParameter("id");

String my = (String)session.getAttribute("userid");

//dao 선언
BoardDao dao = new BoardDao();


	dao.deleteBoard(id);


%>