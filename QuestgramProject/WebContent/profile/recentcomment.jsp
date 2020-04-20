<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.CommentDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
.recent-comment {
	float: left;
	display: inline;
}
</style>
</head>
<body>
<%
	String user_id = (String)session.getAttribute("userid");
	CommentDao cdao=new CommentDao();
	List<CommentDto> clist=cdao.recentComment(user_id);
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");

	for(CommentDto cdto: clist){
%>		<p style="color: black;">
			<%=cdto.getId()%>&nbsp;님이 댓글을 남겼습니다<br>
			<%=cdto.getContent()%>&nbsp;(<%=sdf.format(cdto.getCreated_at()) %>)
		</p>
<%	}
%>
</body>
</html>