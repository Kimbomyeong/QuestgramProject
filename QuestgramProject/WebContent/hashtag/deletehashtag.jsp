<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	request.setCharacterEncoding("utf-8");
	
	String hashid = request.getParameter("hashid");
	
	BoardDao bdao = new BoardDao();
	
	bdao.deleteHash(hashid);
	
	response.sendRedirect("../main.jsp");
%>