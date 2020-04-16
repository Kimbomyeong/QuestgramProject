<%@page import="data.dto.CommentDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link href="comment/css/style.css" rel="stylesheet" type="text/css" />
</head>
<%
	String board_id=request.getParameter("board_id");	
	String user_id=request.getParameter("user_id");

%>
<body>
         <!-- 댓글 -->
        <div class="comment-container" style="border-top: 1px solid #efefef;">
		<form action="comment/commentadd.jsp" method="post" style="height:45pt;">
		 <%
			CommentDao cdb = new CommentDao();
		%>
			<input type="hidden" name="user_id" value="<%=user_id%>"> 	
			<input type="hidden" name="board_id" value="<%=board_id%>"> 
			<input type="hidden" name="parents_comments_id" value="<%=1%>"> 
        <table>
		<tr>
			<td> <!-- 댓글을 달 텍스트에리어 -->
			<textarea class="content" name="content" placeholder="댓글 달기..."></textarea>
            </td>
			<td> <!-- 댓글 전송하기 버튼 -->
			<button type="submit" class="send">게시</button>
			<!-- <a href="#"><img src="Post/image/gesi.png" alt=""></a> -->
			</td>
		</tr>
	</table>
	</form>
          	
</body>
</html>