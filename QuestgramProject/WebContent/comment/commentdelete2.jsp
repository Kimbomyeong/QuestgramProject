<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String commentno=request.getParameter("commentno");
String user_id=request.getParameter("user_id");
String board_id=request.getParameter("board_id");
%>
<jsp:useBean id="dao" class="data.dao.CommentDao"/>

<%
dao.deleteComment(commentno);
response.sendRedirect("../Post/form2.jsp?board_id="+board_id+"user_id="+user_id);

%>