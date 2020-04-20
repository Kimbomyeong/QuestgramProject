<%@page import="data.dto.CommentDto"%>
<%@page import="data.dao.CommentDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="data.dao.ImageDao"%>
<%@page import="data.dto.UserDto"%>
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

<script src="js/slide.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Neucha' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="Post/css/slidestyle.css" type="text/css">

  
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
   
   //하트 클릭
   $(document).on("click",".heart",function(){
      var joayo = 0;
         var id = 0;
      var src=($(this).attr('src')==='Post/image/heart.png')
       ?'Post/image/red.png'
        :'Post/image/heart.png'
      $(this).attr('src',src);
      
      if(src=='Post/image/red.png')
         joayo=1;
      else
         joayo=0;
      
      //alert(joayo); // 1,0 스위칭 확인
      
      var sthis=$(this);
      
      //console.log(id,joayo); 0,1 / 0,0
      var board_id = $(this).attr("board_id");
      
      $.ajax({
         type:"get",
         url:"Post/Post_Like.jsp",
         dataType:"json",
         data:{"id":board_id,"joayo":joayo},
         success:function(data){
            //alert(data.joayo);

            $(sthis).parent().parent().next().next().find(".cnt").html(data.joayo);
         }
      }); //ajax 끝
      
   });// 하트 클릭 
   
   //북마크 클릭
   $(document).on("click","#bookmark",function(){
   
     
         var src=($(this).attr('src')==='Post/image/bookmark.png')
          ?'Post/image/black.png'
           :'Post/image/bookmark.png';
         $(this).attr('src',src);
      
   
   }); // 북마크 클릭 
   
   //내용 숨기기
   var cont = $("h5").text(); //내용 값 받아오기
   var bubun = cont.substring(0,5); // 처음에 노출될 내용
   
   
   $('#more').hide(); //더 보기 버튼
   
   
   $(document).on(function() {
      
    if(cont.length>=6)  {// 내용의 크기가 6이상일 경우
   
      $('span.content').text(bubun); //0~5까지의 글을 내용에 표시하고
        $('#more').show(); //더 보기 버튼을 띄움
   
        //더 보기 버튼 이벤트
       $('#more').on({
      'click':function(){
         $('span.content').text(cont).show(); //내용 전체 출력
         $('#more').hide(); //더 보기 버튼 숨기기
      }
      
       });// 더 보기   
   
    } else { //내용이 5이하일 경우
      $('span.content').show(); // 내용 전체 출력
    }
   
   });
   
   

   
   

});//끝


//모달 열기
 $(document).on("click",".trigger",function(){
    $("#myModal").modal();
 });
// 모달 끝

   



</script>
</head>

<body>
 
<% 
   //dao 선언
   BoardDao bdb = new BoardDao();
   UserDao udb = new UserDao();
   ImageDao idao = new ImageDao();
   
   // root 경로 - 이미지 경로 
   String context = request.getContextPath();
   
   //유저의 닉네임을받아온다 (세션명: userid)
      //user의 이메일을 토대로 ID를 받아옴
      String user_id=(String)session.getAttribute("userid");
 		String nickname = (String)session.getAttribute("nickname");   
   
      //board의 user id 받아오기
      String board_id = "start";
      // String board_id = request.getParameter("user_id");

   //list 가져오기
   List<BoardDto> list=bdb.getAllDatas(user_id, board_id);

   
   //System.out.println(user_id + ", " + list.size());
   
   
%>
  <!-- post-container -->
  <input type="hidden" id="boardsize" name="boardsize" value="<%=list.size()%>">
   <input type="hidden" id="userId" name="userId" value="<%=user_id%>">
  
  
  <%
  BoardDto dto = new BoardDto();
  UserDto udto = new UserDto();
  // 유저 닉네임으로 해당 유저 정보 얻기
  udto = udb.getUser(user_id);
  
  // 유저 닉네임으로 board_id얻기 - 이미지 출력 
  String lat_board_id = idao.getBoard_id(user_id);
  
  List<String> listImage = new ArrayList<String>();
  
  %>
  
  <div class="post-body">
  <%
  for(BoardDto l:list)
     { 
	  String boardId = l.getId();
	  
	  	// board_id에 해당하는 이미지 
		listImage = idao.boardIdImage(boardId);
	  	
	  	// board_id로 작성자 uesr_id 얻기
	  	String create_user_id = bdb.getUser_id(boardId);
	  	// user_id로 유저 정보 얻기
	  	UserDto uudto = udb.getUser(create_user_id);
  %>
  <!-- 게시글, -->
  <div class="post-container">
  <input type="hidden" name="postnum" class="postnum" value="<%=l.getId()%>">
    <div class="wrap">

      <div class="post">
      
      
       
       
         <!-- 뉴스피드 헤드 -->
        <div class="post-header" >
          <!-- 프로필사진 -->
          <a href="profile/usermain.jsp?thisId=<%= create_user_id %>" class="profile"><img src="http://localhost:9000<%= context %>/save/<%= uudto.getProfile_img() %>" style="border-radius: 100%;"></a>
          
          <!-- 작성자 이름  -->
          <a href="profile/usermain.jsp?thisId=<%= create_user_id %>"><%=l.getNickname() %></a>
          
             
          <!-- 메뉴 더 보기 출력 -->
            <a href="#"><img src="Post/image/more.PNG" width="32px" height="20px" id="trigger" 
              name="trigger" class="trigger" alt="" style="float: right;"></a>
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
                <button type="button" class="btn btn-default btn-block"
                      onclick="location.href='Post/Post_Update_Form.jsp'">수정</button>
                <button type="button" class="btn btn-default btn-block"
                      onclick="location.href='Post/Post_Delete_Action.jsp?id=<%=board_id%>'">삭제</button>
                <button type="button" class="btn btn-default btn-block">댓글 기능 해제</button>
          </form>
        </div>
     </div>
      
    </div>
  </div> <!-- modal 끝 -->

     
            
            
            
            
        </div> <!-- 뉴스피드 헤더 끝 -->
        
        <!-- 업로드한 사진 -->
         <%
      // 쓴글에 이미지가 있을때만 사진영역 출력하기 
      int imageCount = idao.getImageCount(boardId);
      // 보드 아이디의 user_id와 현재 로그인된 user_id 비교 
      
      if(imageCount > 0){     
       %>
        <div class="sajin">
          <div id="wrapper_<%= boardId %>" class="wrapper">
          <input type="hidden" id="imgPos_<%=boardId%>" pos="0" totalSlides="<%= listImage.size() %>" sliderwidth="">
      		<div id="slider-wrap_<%= boardId %>" class="slider-wrap" board_id="<%= boardId %>"  onmouseover="" onmouseout="">
          		<ul id="slider_<%= boardId %>" class="slider">
          <%
          for(String str : listImage){
          %>
		        	<li class="imgli_<%= boardId %>">                
						<img src="http://localhost:9000<%= context %>/save/<%= str %>" />	
		            </li> 
         <%  
         }
          %>            
          		</ul>
        	<!--controls-->       	 
            <div class="btns next" onclick="slideRight(<%=boardId%>);" id="next_<%= boardId %>"><i class="fa fa-chevron-circle-right fa-2x" aria-hidden="true"></i></div>
            <div class="btns previous" onclick="slideLeft(<%=boardId%>);" id="previous_<%= boardId %>"><i class="fa fa-chevron-circle-left fa-2x"></i></div>
            <div class="counter" id="counter_<%= boardId %>"></div>            
            <!--controls--> 
      		
       		</div>	
   		</div>
            
       </div>	
   	<% } 
      %>
          		
          		
          		
        
        <!-- ------------------------------------------- -->
        <!-- 이미지 출력에 필요한 자바스크립트 변수 -->
        <script type="text/javascript" class="script">
		//current position
		$(document).ready(function(){
			addImageSlide(<%= boardId %>, <%= listImage.size()%>);
		});
		
		function addImageSlide(boardId, size) {
			//number of slides
			//var board_id = $('.slider-wrap ul li').attr("board_id");
			//get the slide width
			$('#imgPos_'+boardId).attr("sliderwidth", 600);
			$('#slider_'+boardId).width(size * 600);
			$.each($('#slider-wrap_'+boardId +' ul li'), function() { 
			       //create a pagination
			       var li = document.createElement('li');
			       $('#pagination-wrap_'+boardId+' ul').append(li);    
			    });
			pagination(boardId, 0);
		}
		
 		</script> 
        
        <!-- 사진 아래부분 -->
        <div class="post-footer">
           <!-- 버튼 컨테이너 -->
          <ul class="btn-container">
             <!-- 페어런트로 버튼컨테이너까지 호출한 뒤 next span으로 좋아요를 찾자 -->
             <!-- 좋아요 버튼 -->
            <li><img src="Post/image/heart.png" board_id="<%=l.getId()%>"
            width="42px" height="32px"  class="heart" name="heart" style="cursor: pointer;"></li>
            
            <!-- 댓글달기 버튼 -->
            <li><img src="Post/image/balloon.png" width="41px" height="32px" style="cursor: pointer;" onclick="commentfocus(<%= boardId %>);"></li>
            
            <!-- 공유하기 버튼 -->
            <li><img src="Post/image/plane.png" width="42px" height="32px" style="cursor: pointer;"></li>
            
             <% 
            if(imageCount > 1){ %>
            <!-- 사진 옆으로 밀때 표시되는 동그라미  -->
            <li><span class="pagination-wrap" id="pagination-wrap_<%= boardId %>" style="margin-left: 350px;"> <ul> </ul> </span></li>
            
           <%   
            } %>
            
             <!-- 북마크 버튼 -->
             <a href="#"><img src="Post/image/bookmark.png" width="43px" height="32px" class="bookmark" name="bookmark" alt="" style="float: right;"></a>
           
          </ul>
          

<div class="super">
						<table class="formtable">
							<tr>
								<th style="width: 50px;">#</th>
								<td style="width: 600px;"><input class="hashtag" name="hashtag"
									style="width: 450px;" type="text"
									onkeyup="if(event.keyCode == 13) {var board_id = <%=boardId %>; var hashtag = value; 
										console.log($(this).val());
										$.ajax({
											type: 'post',
											dataType: 'html',
											data: {'board_id': board_id, 'hashtag': hashtag},
											url: '../QuestProject/hashtag/hashtagaction.jsp',
											success: function(data) {
												// 데이터 존재 x
											}
										});										
										location.reload();
										$(this).val('');
										$(this).focus();
									}"
									/>
									<br>
									<span>
									<%
									
										List<String> hashlist = bdb.hashtagList(boardId);
										String hashtag = "";
										String hashid = "";
										String str = "";
										for(String hash:hashlist){
											hashtag = "#" + hash + " ";
											hashid = bdb.getHashId(boardId, hash);
											str = "<a href=\"#\">" + hashtag + "</a>" + "<a href=\"hashtag/deletehashtag.jsp?hashid=" + hashid + "\">x</a>";
											%>
												<%=str %>
											<%
										}
										%>
									</span>
									</td>
								
							</tr>
						</table>
					</div>
          
          
          <!-- 좋아요 텍스트 -->
          <div class="like-container">
            <a href="#">좋아요&nbsp;<span class="cnt"><%=l.getLike_count()%></span>개</a>
          </div>
          
          <!-- 내용 -->
          <div class="text-container">
            <a href="#"><%=l.getNickname() %></a>
              
              <span class="contents" id="contents">
              <h5><%=l.getContent() %></h5>
              </span>
              <span>
             
               <button type="button" id="more" style="border: none; background-color:#fff; color:#8e8e8e;" onclick="location.href='Post/form2.jsp?board_id=<%=l.getId() %>'">...더 보기</button>
              </span>   
          </div>
          
          <!-- 댓글 목록 출력 -->
           <div class="comment-container">
	           <%
	           CommentDao cdao=new CommentDao();
	           List<CommentDto> clist=cdao.getComment(boardId);
	           if(clist.size()>2){ 
	           %>
	           <a href="Post/form2.jsp" style="cursor:pointer; color:#8e8e8e;">댓글 <%=clist.size()%>개 모두 보기</a>
	           <div class="ex-comment">
		           <% for(int j=0; j<2; j++){
		          	 	CommentDto cdto = clist.get(j);
		          	 %>
	        	   	<div style="float:left; width: 450px;">
						<!-- <img style="border-radius:100%; width:45px; height:45px;" name="profile_img" src="profile/images/"/> -->&nbsp;&nbsp;
						<b class="id" name="id"><%=cdto.getId()%></b>&nbsp;
							
						<p style="display:inline; width: 350px; background-color: white; border: none;"><%=cdto.getContent()%></p>
					</div>
					<div style="float:right;">
						<a href="#" class="joayo" onclick="change()"><img src="images/mainheart.PNG" width="15px" height="15px"/></a>
						<span>좋아요 <%= cdto.getLike_count() %>개</span> 
					</div>
	        	</div>
	        	<%}
		           
	        	}else{ %>
		           	<jsp:include page="../comment/commentlist.jsp">		  
						<jsp:param value="<%= boardId %>" name="boardId" />      
						<jsp:param value="<%=user_id%>" name="user_id" />      
			      	</jsp:include>
	       	<% } %>
	       </div>
	       
	       
          <!-- 몇분전에 올린 게시글인지 표시 -->
         <div class="time-container" style="margin-left:20px; color:#8e8e8e; font-size:8pt; clear:both;">n분 전</div>
          
          <!-- 댓글 -->
          <!-- 
          <div class="comment-container"> -->
             <!-- 댓글을 달 텍스트에리어 -->
             <!-- 
            <textarea name="comment" placeholder="댓글 달기..." style="float: left; width:535px;"></textarea>
             -->
            
            <!-- 댓글 입력 폼-->
	          <jsp:include page="../comment/commentform.jsp">		  
			  	<jsp:param value="<%= boardId %>" name="id" /> 
			  	<jsp:param value="<%=user_id%>" name="user_id" />
			  </jsp:include>
            <!-- <a href="#"><img src="Post/image/gesi.png" alt=""></a> -->
          
          
        </div> <!-- post footer -->
      </div> <!-- post -->

    </div> <!-- wrap -->
  </div> <!-- post-container -->
  <!-- post-container -->
 
  
 <%}%>
   
  
   <div class="tail">
   </div>
   
  <button type="button" id="list_more">더 보기</button> 
  <script type="text/javascript">
  
  
 
  $('#list_more').on("click", function() {
	     var size = $(".post-container").length;
	      var last = $(".postnum").eq(size-1).val();
	      var userId = $("#userId").val();
	      console.log(size, last, userId);
	      var context = "<%=context%>";
	      $.ajax({
	         type: "post",
	         dataType: "xml",
	         data: {"userId": userId, "boardId": last},
	         url: "Post/List_More.jsp",
	         success: function(data) {
	            var str = "";   // html 출력문에 넣을 텍스트
	            
	            $(data).find("data").each(function(i) {
	               var dt = $(this);      // 한 줄짜리 데이터
	               var boardId = dt.find("boardId").text();
	               var userId = dt.find("userId").text();
	               var content = dt.find("content").text();
	               var commentCount = dt.find("commentCount").text();
	               var likeCount = dt.find("likeCount").text();
	               var viewCount = dt.find("viewCount").text();
	               var shareCount = dt.find("shareCount").text();
	               var createdAt = dt.find("createdAt").text();
	               var name = dt.find("name").text();
	               var nickname = dt.find("nickname").text();
	               var profileImg = dt.find("profileImg").text();
	               var originName = dt.find("originName").text();
	               var saveName = dt.find("saveName").text();
	               var imageList = dt.find("imageList");
	      
	            
	               
	               
	               
	                 
	                   
	                 
	               str += "<h2>ajax page</h2>";
	               str += "<div class='post-container' style='padding: 137px 0 60px; background-color: #fafafa;'>";
	               str += "<input type='hidden' name='postnum' class='postnum' value="+boardId+">";
	               str += "<div class='wrap'>";
	               str += "<div class='post'>";
	               str += "<div class='post-header'>";
	               str += "<a href='#' class='profile'><img src='Post/image/0.gif' alt=''></a>";
	               str += "<a href='#'>"+nickname+"</a>";
	               str += "<a href='#'><img src='Post/image/more.PNG' width='32px' height='20px' id='trigger'name='trigger' class='trigger' alt='' style='float: right;'></a>";
	                  str += "<div class='modal fade' id='myModal' role='dialog' style='z-index:9999;''>"
	                  str += "<div class='modal-dialog'>";
	                  str += "<div class='modal-content'>";
	                  str += "<div class='modal-body' style='padding:40px 50px;'>";
	                  str += "<form role='form'>";
	                  str +="<button type='button' class='btn btn-default btn-block'>게시물로 이동</button>";
	                   str +="<button type='button' class='btn btn-default btn-block'>링크 복사</button>";
	                   str +="<button type='button' class='btn btn-default btn-block'>공유하기</button>";
	                   str +="<button type='button' class='btn btn-default btn-block'>보관</button>";
	                   str +="<button type='button' class='btn btn-default btn-block'"
	                       +"onclick='location.href='Post/Post_Update_Form.jsp'>수정</button>";
	                   str +="<button type='button' class='btn btn-default btn-block'"
	                      +"onclick='location.href='Post/Post_Delete_Action.jsp?id="+boardId+">삭제</button>";
	                   str +="<button type='button' class='btn btn-default btn-block'>댓글 기능 해제</button>";
	                   str +="</form>";
	                   str +="</div>";
	                   str +="</div>";
	                   str +="</div>";
	                   str +="</div>";
	                   str +="</div>";
	                   
	              
	                   var image = "";
	                   // 이미지가 있는 글에만 이미지 추가 
	                   if(imageList.length >= 1){
	                	   
	                   
	                	   
	                   
	                	   str +="<div class='sajin'>";
	                       str += "<div id='wrapper_"+boardId+"' class='wrapper'>";
	                       str += "<input type='hidden' id='imgPos_"+boardId+"' pos='0' totalSlides='"+imageList.length+"' sliderwidth=''>";
	                 		str += "<div id='slider-wrap_"+boardId+"' class='slider-wrap' board_id='"+boardId+"'  onmouseover='' onmouseout=''>";
	                     	str += "<ul id='slider_"+boardId+"' class='slider'>";
	                       
	                   for(var i=0; i<imageList.length; i++){
	                	   image = imageList.get(i).innerHTML;
	                       str += "<li class='imgli_"+boardId+"'>";                
	    					str += "<img src='http://localhost:9000"+context+"/save/"+image.trim()+"' />";
	    					str += "</li>";
	                   }
	    					
	    					str += "</ul>";
	    		        	<!--controls-->       	 
	    		            str += "<div class='btns next' onclick='slideRight("+boardId+");' id='next_"+boardId+"'><i class='fa fa-chevron-circle-right fa-2x' aria-hidden='true'></i></div>";
	    		            str += "<div class='btns previous' onclick='slideLeft("+boardId+");' id='previous_"+boardId+"'><i class='fa fa-chevron-circle-left fa-2x'></i></div>";
	    		            str += "<div class='counter' id='counter_"+boardId+"'></div>";            
	    		            <!--controls--> 
	    		      		
	    		       		str += "</div>";	
	    		   			str += "</div>";
	    		            
	    		       		str += "</div>";	
	                       str +="</div>";
	                       
	                   }    
	                   str +="<div class='post-footer'>";
	                   str +="<ul class='btn-container'>";
	                   str +="<li><img src='Post/image/heart.png' width='42px' height='32px'  class='heart' name='heart' alt='' board_id="+boardId+"></li>";
	                   str +="<li><img src='Post/image/balloon.png' width='41px' height='32px' alt=''></li>";
	                   str +="<li><img src='Post/image/plane.png' width='42px' height='32px' alt=''></li>";
	                   if(imageList.length > 1){ 
	                       <!-- 사진 옆으로 밀때 표시되는 동그라미  -->
	                       str += "<li><span class='pagination-wrap' id='pagination-wrap_"+boardId+"' style='margin-left: 350px;'> <ul> </ul> </span></li>";                 
                       } 
	                   
	                   
	                 str +="<img src='Post/image/bookmark.png' width='43px' height='32px' class='bookmark' name='bookmark' alt='' style='float: right;'>";
	                 str +="</ul>";
	                 str +="<div class='like-container'>";
	                 str +="<a href='#'>좋아요<span class='cnt'></span></a>";
	                 str +="</div>";
	                 str +="<div class='text-container' style='font-size: 14px;line-height: 18px;'>";
	                 str +="<a href='#' style='font-weight: 600;'>"+nickname+"</a>";
	                   str +="<span class='contents' id='contents'>";
	                   str +="<h6>"+content+"</h6>";
	                   str +="</span>";
	                   str +="<span>";
	                    str +="<button type='button' id='more' style='border: none; background-color:#fff; color:#8e8e8e;'>...더 보기</button>";
	                    str +="</span>";
	                   str +="</div>"; 
	                   str +="<div class='time-container'>n분 전에 올라온 게시글</div>";
	                   str +="<div class='comment-container'>";
	                   str +="<textarea name='comment' placeholder='댓글 달기...' style='float: left; width:535px;'></textarea>";
	                   str +="<button type='submit' class='gesi'>게시</button>";
	                    str +="</div>";
	                    str +="</div>";
	                    str +="</div>";
	                    str +="</div>";
	                    str +="</div>";
	 		            $("div.tail").append(str);
	           			str = "";
	           			if(imageList.length > 0) {
		           			addImageSlide(boardId, imageList.length);	           				
	           			}
	                    
	       
	                    
	      
	   

	               /* str += "예시: <br>";
	               str += "boardId : " + boardId; */
	            });
	            hoverEvent();
	         }
	      });
	   }); //ajax 끝

           </script>
           
   <button type="button" onclick="location.href='Post/Post_insert_Form.jsp'">게시물올리기</button>         
</body>
</html>
