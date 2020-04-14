<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//엔코딩
	request.setCharacterEncoding("utf-8");
   String id = request.getParameter("id");
%>

<jsp:useBean id="dto" class="data.dto.BoardDto"/>
<jsp:useBean id="dao" class="data.dao.BoardDao"/>

<jsp:setProperty property="user_id" name="dto"/>
<jsp:setProperty property="content" name="dto"/>
<%

	dao.updateBoard(dto);

    response.sendRedirect("../main.jsp");


%>