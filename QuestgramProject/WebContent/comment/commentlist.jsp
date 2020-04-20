<%@page import="data.dto.CommentDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<style>
.submenubtn {
	width: 30px;
	background-color: rgba(255, 255, 255, .7);
	margin:-22px 0 0 540px;
	cursor: pointer;
}
</style>
<link href="comment/css/style.css" rel="stylesheet" type="text/css" />
<%
	String board_id=request.getParameter("board_id");
	String user_id=request.getParameter("user_id");

%>
    <script>
    $(function(){
    	$(".submenubtn").hide();
    	$(".commentlist").hover(function(){
    		$(this).next(".submenubtn").show();
    	}, function() {
    		$(this).next(".submenubtn").hide();
    	}); 
    	$(".submenubtn").click(function(){
    		$("#submenu").modal();
    	}); 
    });
    </script>    
        <%
			CommentDao cdb = new CommentDao();
			List<CommentDto> list = cdb.getComment(board_id);
			for (CommentDto dto :list) {
		%>
		    <input type="hidden" name="couser_id"  value="<%=dto.getUser_id()%>" >
		    <div class="commentlist" style="margin: 3px 7px 8px; width:580px; height: 15px;float:left;">
			<div style="float:left; width: 450px;">
				&nbsp;&nbsp;<b style="" class="id" name="id"><%=dto.getId()%></b> 
				&nbsp;<p style="display:inline; width: 350px; background-color: white; border: none;"><%=dto.getContent()%></p>
			</div>
			<div style="float:right;">
			<div class="submenubtn" style=" z-index:9999;"><img style="cursor:pointer;" src="Post/image/more.PNG"/></div>
			<a class="joayo" num="<%=dto.getCommentno()%>" like_count="<%=dto.getLike_count()%>"><img class="joayo" src="Post/image/joayo.png" width="12px" height="12px" style="opacity: 0.6; float:left;"/></a>			</div>
        	</div>
        		<div class="submenu modal fade" id="submenu" role="dialog" style="z-index:9999;">
				    <div class="modal-dialog">
				      <!-- Modal content-->
				      <div class="modal-content" style="margin-top: 250px;">
				        <div class="smodal-body" style="padding:40px 50px;">
				          <form role="form" action="comment/commentdelete.jsp?commentno=<%=dto.getCommentno()%>">
							<input type="hidden" name="commentno" value="<%=dto.getCommentno()%>"> 
			      			<button type="button" class="btn btn-default btn-block" style="color:red;"><b>신고</b></button>
			                <button type="submit" class="btn btn-default btn-block"><b>삭제</b></button>
			                <button type="button" class="btn btn-default btn-block" onclick="$('.submenu').modal('hide')"><b>취소</b></button>
				          </form>
				        </div>
				     </div>
				    </div>
				  </div> <!-- modal 끝 -->
        		
		<%}%>
