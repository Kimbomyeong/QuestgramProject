<%@page import="data.dto.CommentDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link href="comment/css/style.css" rel="stylesheet" type="text/css" />
<%
	String board_id=request.getParameter("boardId");
	String user_id=request.getParameter("user_id");

%>
    <script>
    $(function(){
    	$(".joayo").click(function(){
    		$(this).child.attr("src","images/mainheart_b.PNG");
    	});
    
    });
			
    
    </script>    
        <%
			CommentDao cdb = new CommentDao();
			List<CommentDto> list = cdb.getComment(board_id);
			for (CommentDto dto :list) {
		%>
		    <div class="commentlist" style="margin: 3px 7px 8px; height: 15px;">
				<div style="float:left; width: 450px;">
					&nbsp;&nbsp;<b style="" class="id" name="id"><%=dto.getId()%></b> 
					&nbsp;<p style="display:inline; width: 350px; background-color: white; border: none;"><%=dto.getContent()%></p>
				</div>
				<div style="float:right;">
					<a href="#" class="joayo" onclick="change()"><img src="images/mainheart.PNG" width="19px" height="19px" style="opacity: 0.6;"/></a>
				</div>
        	</div>
		<%}%>
