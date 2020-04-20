<%@page import="data.dao.CommentDao"%>
<%@page import="data.dto.CommentDto"%>
<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="java.util.List"%>


<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

  
<title>Questgram</title>
<style type="text/css">
 .modal-header, h4, .close {
    background-color: #5cb85c;
    color:white !important;
    text-align: center;
    font-size: 30px;
  }
  .modal-footer {
    background-color: #f9f9f9;
  }

</style>
<link rel="stylesheet" href="Post/css/style.css">
<script type="text/javascript">
$(function(){
	//submenubtn 숨기고 댓글에 마우스 올리면 나타나게 하기
	$(".submenubtn").hide();
	$(".commentlist").hover(function(){
		$(this).next(".submenubtn").show();
	}, function() {
		$(this).next(".submenubtn").hide();
	}); 
	//submenubtn 클릭시 서브메뉴 보이기
	$(".submenubtn").click(function(){
		$("#submenu").modal();
	}); 
	 
	
	$(".delete").click(function(){
		//태그 안에 넣어둔 num 읽기
		var commentno=$(this).attr("commentno");
		$.ajax({
			type:"get",
			url:"commentdelete.jsp",
			dataType:"html",
			data:{"commentno":commentno},
			success:function(data) {
				$(this).parents().parents().parents().parents().parents().parents().siblings(".commentincontent").remove();
			}
		});
	});
	
	$(".joayo").click(function() {
		var joayo=0;//빨간 하트는 1로 변경
		var num=0;//해당 글의 num값
		var class1 = $(this).children("img").attr("src");
		num=$(this).children("img").attr("num");//클릭한 곳의 속성 num 얻기
		 if (class1=="Post/image/joayo.png") {
			$(this).children("img").attr("src","Post/image/joayo_r.png").css("width","19px").css("height","19px");
			joayo=1;
		 } else {
			$(this).children("img").attr("src","Post/image/joayo.png").css("width","19px").css("height","19px").css("opacity","0.6");
			joayo=0;
		 } 
		
		console.log(num,joayo);
		//내가 클릭한 span.joayo의 요소값을 따로 저장해둔다
		var sthis=$(this);
		$.ajax({
			type:"get",
			url:"Ex5_MemoJoayoDb.jsp",
			dataType:"json",
			data:{"num":num,"joayo":joayo},
			success:function(data){
				//alert(data.joayo);
				
				$(sthis).next().text(data.joayo);
			}
		});
	});
	
	//하트 클릭
	$('.heart').on({
	   'click':function(){
			var src=($(this).attr('src')==='Post/image/heart.png')
			 ?'Post/image/red.png'
		     :'Post/image/heart.png';
			$(this).attr('src',src);
		}
	
	}); // 하트 클릭 
	
	//북마크 클릭
	$('.bookmark').on({
	   'click':function(){
			var src=($(this).attr('src')==='Post/image/bookmark.png')
			 ?'Post/image/black.png'
		     :'Post/image/bookmark.png';
			$(this).attr('src',src);
		}
	
	}); // 북마크 클릭 
	
	//내용 숨기기
	var cont = $(".contentsin").text(); //내용 값 받아오기
	console.log(cont.length); //59
	var bubun = cont.substring(0,5); // 처음에 노출될 내용
	console.log(bubun.length); //5
	$('.more').hide(); //더 보기 버튼
	
	
	$(document).ready(function() {
		if(cont.length>=6) // 내용의 크기가 6이상일 경우
		 {
			$('span.contents').text(bubun); //0~5까지의 글을 내용에 표시하고
	        $('.more').show(); //더 보기 버튼을 띄움
		
	        //더 보기 버튼 이벤트
		    $('.more').on({
			'click':function(){
				$('span.contents').text(cont); //내용 전체 출력
				$('.more').hide(); //더 보기 버튼 숨기기
			}
			
	       });// 더 보기	
		
		 }
		 
		else{ //내용이 5이하일 경우
			$('span.contents').show(); // 내용 전체 출력
		}
		
		});

		$(".morecomment").click(function(){
			$(".ex-comment").hide();
			$(this).hide();
		});
		
});

//모달 열기
$(document).ready(function(){
	  $(".trigger").click(function(){
	    $("#myModal").modal();
	  });
});
</script>
</head>
<% 
	//dao 선언
	BoardDao bdb = new BoardDao();
	UserDao udb = new UserDao();
	
	//list 가져오기
	List<BoardDto> list2=bdb.getAllDatas2();
	
	
	//유저의 닉네임을받아온다 (세션명: userid)
	//user의 이메일을 토대로 받아옴
	String user_id=(String)session.getAttribute("userid");



%>
<body>

  <!-- post-container -->
  
  <%
  	for(int i=0; i<list2.size(); i++)
  	{
  		BoardDto bdto=list2.get(i);
  		
  		//board_id를 구해줌
  		String board_id=bdto.getId();
  		
  		//bdto2에 user_id에 해당하는 데이터를 넣어줌
  		BoardDto bdto2=bdb.getBoardData(user_id);
  		
  		System.out.println(i);
  		System.out.println(bdto.getContent());
  		System.out.println(board_id);
  %>
  <!-- 게시글, -->
  <div class="post-container">
    <div class="wrap">

      <div class="post">
      
      	<!-- 뉴스피드 헤드 -->
        <div class="post-header">
          <!-- 프로필사진 -->
          <a href="#" class="profile"><img src="Post/image/0.gif" alt=""></a>
          
          <!-- 작성자 이름  -->
          <a href="#"><%=bdto.getUser_id() %></a>
          
          	
          <!-- 메뉴 더 보기 출력 -->
            <a href="#"><img src="Post/image/more.PNG" width="32px" height="20px"
              name="trigger" class="trigger" alt="" style="float: right;"></a>
      
            
        </div> <!-- 뉴스피드 헤더 끝 -->
        
        <!-- 업로드한 사진 -->
        <div class="sajin">
          <img src="Post/image/ramgi.jpeg" alt="">
        </div>
        
        <!-- ------------------------------------------- -->
        
        
        <!-- 사진 아래부분 -->
        <div class="post-footer">
        	<!-- 버튼 컨테이너 -->
          <ul class="btn-container">
          	
          	<!-- 좋아요 버튼 -->
            <li><a href="#"><img src="Post/image/heart.png" width="42px" height="32px" class="heart" name="heart" alt="" ></li>
            
            <!-- 댓글달기 버튼 -->
            <li><a href="#"><img src="Post/image/balloon.png" width="41px" height="32px" alt=""></a></li>
            
            <!-- 공유하기 버튼 -->
            <li><a href="#"><img src="Post/image/plane.png" width="42px" height="32px" alt=""></a></li>
            
             <!-- 북마크 버튼 -->
             <a href="#"><img src="Post/image/bookmark.png" width="43px" height="32px" class="bookmark" name="bookmark" alt="" style="float: right;"></a>
           
          </ul>
          
          
          <!-- 좋아요 텍스트 -->
          <div class="like-container">
            <a href="#">좋아요 n개</a>
          </div>
          
          <!-- 내용 -->
          <div class="text-container">
            <a href="#"><%=bdto.getUser_id() %></a>
              
              <span class="contents">
             	 <h5 class="contentsin"><%=bdto.getContent() %></h5>
              </span>
              <span>
            	<button type="button" class="more" style="border: none; background-color:#fff; color:#8e8e8e;">...더 보기</button>
              </span>	
          </div>
          
          
           <!-- 댓글 목록 출력 -->
           <div class="comment-container">
           <%
           CommentDao cdao=new CommentDao();
           List<CommentDto> list=cdao.getComment(board_id);
           if(list.size()>2){ %>
           <a class="form2" href="Post/form2.jsp?board_id=<%=board_id%>&user_id=<%=user_id%>" style="cursor:pointer; margin-left:15px; color:#8e8e8e;">댓글 <%=list.size()%>개 모두 보기</a>
           <div class="ex-comment">
	           <% for(int j=0;j<2;j++){
	          	 CommentDto cdto=list.get(j);%>
	          	 <div class="commentlist" style="margin: 10px 15px; height: 15px;">
	          	 	<input type="hidden" name="couser_id"  value="<%=cdto.getUser_id()%>" >
	        	    <div style="float: left; width: 580px; padding-right: 20px;">
						<b class="id" name="id"><%=cdto.getId()%></b>&nbsp;
						<p style="display:inline; width: 350px; background-color: white; border: none;"><%=cdto.getContent()%></p>
					</div>
					<div style="margin: 0 0 0 550px">
						<a  num="<%=cdto.getId()%> like_count="<%=cdto.getLike_count()%>><img class="joayo" src="Post/image/joayo.png" width="19px" height="19px" style="opacity: 0.6;"/></a>
					</div>
        		 </div>
        		<div class="submenubtn" style=" z-index:9999;"><img style="cursor:pointer;" src="Post/image/more.PNG"/></div>
        	</div>
        	
		        	<div class="submenu modal fade" id="submenu" role="dialog" style="z-index:9999;">
				    <div class="modal-dialog">
				      <!-- Modal content-->
				      <div class="modal-content" style="margin-top: 250px;">
				        <div class="smodal-body" style="padding:40px 50px;">
				          <form role="form" >
			      			<button type="button" class="btn btn-default btn-block" style="color:red;"><b>신고</b></button>
			                <button type="delete" commentno="<%=cdto.getCommentno()%>" class="btn btn-default btn-block"><b>삭제</b></button>
			                <button type="button" class="btn btn-default btn-block" onclick="$('.submenu').modal('hide')"><b>취소</b></button>
				          </form>
				        </div>
				     </div>
				    </div>
				  </div> <!-- modal 끝 -->
        		
        	<%}
	        }else{ %>
	           <jsp:include page="../comment/commentlist.jsp">		  
				 <jsp:param value="<%=board_id%>" name="board_id" />      
				 <jsp:param value="<%=user_id%>" name="user_id" />      
		       </jsp:include>
	       <%} %>
	       </div>
	       
	       <!-- 몇분전에 올린 게시글인지 표시 -->
           <div class="time-container">n분 전</div>
           <!-- 댓글 입력 폼-->
          <jsp:include page="../comment/commentform.jsp">		  
		  <jsp:param value="<%=board_id%>" name="board_id" /> 
		  <jsp:param value="<%=user_id%>" name="user_id" />      
          </jsp:include>
        </div> <!-- post footer -->
      </div> <!-- post -->

    </div> <!-- wrap -->
  </div> <!-- post-container -->
  <!-- post-container -->
  
 <%}%>
  
      <!-- 다른 앱에 게시, 링크 복사, 공유하기, 보관, 수정, 삭제, 댓글기능 해제 -->
              <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" style="z-index:9999;">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
      
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form">
      			<button type="button" class="btn btn-default btn-block">게시물로 이동</button>
                <button type="button" class="btn btn-default btn-block">링크 복사</button>
                <button type="button" class="btn btn-default btn-block">공유하기</button>
                <button type="button" class="btn btn-default btn-block">보관</button>
                <button type="button" class="btn btn-default btn-block">수정</button>
                <button type="button" class="btn btn-default btn-block">삭제</button>
                <button type="button" class="btn btn-default btn-block">댓글 기능 해제</button>
          </form>
        </div>
     </div>
      
    </div>
  </div> <!-- modal 끝 -->

</body>
</html>