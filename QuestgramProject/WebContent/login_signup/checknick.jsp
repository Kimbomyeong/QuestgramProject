<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String nick = request.getParameter("nick");
	
	UserDao dao = new UserDao();
	
	boolean dupchecknick = dao.dupCheckNickname(nick);
	if(dupchecknick){
		out.print("{\"nickcheck\" : \"success\"}");
	} else {
		out.print("{\"nickcheck\" : \"fail\"}");
	}
%>