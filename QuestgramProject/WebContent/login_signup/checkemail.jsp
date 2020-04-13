<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");

	UserDao dao = new UserDao();
	
	boolean dupcheckemail = dao.dupCheckEmail(email);
	if(dupcheckemail){
		out.print("{\"emailcheck\" : \"success\"}");
	} else {
		out.print("{\"emailcheck\" : \"fail\"}");
	}
%>