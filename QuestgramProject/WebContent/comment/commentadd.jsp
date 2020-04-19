<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dto" class="data.dto.CommentDto"/>
<jsp:useBean id="dao" class="data.dao.CommentDao"/>
<jsp:setProperty name="dto" property="usernum"/>
<jsp:setProperty name="dto" property="user_id"/>
<jsp:setProperty name="dto" property="board_id"/>
<jsp:setProperty name="dto" property="commentno"/>
<jsp:setProperty name="dto" property="parents_comments_id"/>
<jsp:setProperty name="dto" property="id"/>
<jsp:setProperty name="dto" property="content"/>
<jsp:setProperty name="dto" property="like_count"/>

<%
dao.insertComment(dto);
response.sendRedirect("../main.jsp");
%>

