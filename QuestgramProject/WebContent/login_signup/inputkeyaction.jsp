<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");	
%>
<jsp:useBean id="dto" class="data.dto.UserDto"/>
<jsp:useBean id="dao" class="data.dao.UserDao"/>

<jsp:setProperty property="email" name="dto"/>
<jsp:setProperty property="password" name="dto"/>
<jsp:setProperty property="nickname" name="dto"/>
<jsp:setProperty property="name" name="dto"/>
<%
	// insert
	dao.insertUser(dto);
%>