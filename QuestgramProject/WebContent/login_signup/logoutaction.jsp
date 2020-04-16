<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// loginok 세션을 삭제한다
	session.removeAttribute("loginok");
	session.removeAttribute("loginid");
	session.removeAttribute("nickname");
	session.removeAttribute("userid");
	session.removeAttribute("username");
	
	System.out.println(session.getAttribute("loginid"));
    System.out.println(session.getAttribute("loginok"));
    System.out.println(session.getAttribute("nickname"));
    System.out.println(session.getAttribute("userid"));
    System.out.println(session.getAttribute("username"));
	
	response.sendRedirect("loginform.jsp");
%>