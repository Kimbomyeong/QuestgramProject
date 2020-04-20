<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String commentno=request.getParameter("commentno");

%>
<jsp:useBean id="dao" class="data.dao.CommentDao"/>

<%
dao.deleteComment(commentno);

%>