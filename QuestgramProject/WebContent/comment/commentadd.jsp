<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dto" class="data.dto.CommentDto"/>
<jsp:useBean id="dao" class="data.dao.CommentDao"/>
<jsp:setProperty name="dto" property="*"/>
<%
dao.insertComment(dto);

%>

