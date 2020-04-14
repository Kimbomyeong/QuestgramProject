<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	String password = request.getParameter("password");
	HttpSession emailSession = request.getSession();
	String email = (String)emailSession.getAttribute("email");
	
	System.out.println(email);
	UserDao dao = new UserDao();
	
	dao.changePassword(email, password);
	emailSession.removeAttribute("email");
	response.sendRedirect("loginform.jsp");
%>