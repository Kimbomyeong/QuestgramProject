<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한글 엔코딩
	request.setCharacterEncoding("utf-8");



%>

<jsp:useBean id="dto" class="data.dto.BoardDto"/>
<jsp:useBean id="dao" class="data.dao.BoardDao"/>

<jsp:setProperty property="user_id" name="dto"/>
<jsp:setProperty property="content" name="dto"/>
<%
	//insert 메소드 호출
	
	String id = request.getParameter("user_id");
	String content = request.getParameter("content");
	
	dao.insertBoard(dto);
    System.out.println(id); 
    response.sendRedirect("../main.jsp");	


%>