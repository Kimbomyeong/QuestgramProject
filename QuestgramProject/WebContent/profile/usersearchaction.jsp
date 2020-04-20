<%@page import="data.dto.UserDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String keyword = request.getParameter("keyword");

	UserDao udao = new UserDao();
	List<UserDto> list = udao.searchUser(keyword);
	
	String context = request.getContextPath();
%>
<list>
	<%
	for(UserDto dto : list){ %>
	<data>
		<userid><%= dto.getId() %> </userid>
		<username><%= dto.getName() %> </username>
		<usernickname><%= dto.getNickname() %></usernickname>
		<userprofileimg><%= dto.getProfile_img() %></userprofileimg>
		<context><%= context %></context>
	</data>
	<% 	
	}
	%>
</list>
