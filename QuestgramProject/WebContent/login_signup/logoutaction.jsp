<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// loginok 세션을 삭제한다
	session.removeAttribute("loginok");
	session.removeAttribute("loginid");
	session.removeAttribute("nickname");
	
	System.out.println(session.getAttribute("loginid"));
    System.out.println(session.getAttribute("loginok"));
    System.out.println(session.getAttribute("nickname"));
	
	response.sendRedirect("loginform.jsp");
%>