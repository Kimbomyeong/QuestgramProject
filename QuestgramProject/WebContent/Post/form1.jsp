<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" content="width=device-width, initial-scale=1">
 
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
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	
	//하트 클릭
	$('#heart').on({
	   'click':function(){
			var src=($(this).attr('src')==='./image/heart.png')
			 ?'./image/red.png'
		     :'./image/heart.png';
			$(this).attr('src',src);
		}
	
	}); // 하트 클릭 
	
	//북마크 클릭
	$('#bookmark').on({
	   'click':function(){
			var src=($(this).attr('src')==='./image/bookmark.png')
			 ?'./image/black.png'
		     :'./image/bookmark.png';
			$(this).attr('src',src);
		}
	
	}); // 북마크 클릭 
	
	//모달 열기
    $(document).ready(function(){
		  $("#trigger").click(function(){
		    $("#myModal").modal();
		  });
		}); //모달 열기
		
	//내용 숨기기
	var cont = $("h5").text(); //내용 값 받아오기
	console.log(cont.length); //59
	var bubun = cont.substring(0,5); // 처음에 노출될 내용
	console.log(bubun.length); //5
	$('#more').hide(); //더 보기 버튼
	
	/* $('span.content').hide(); */
	
	$(document).ready(function() {
		
	 if(cont.length>=6) // 내용의 크기가 6이상일 경우
	 {
		$('span.content').text(bubun); //0~5까지의 글을 내용에 표시하고
        $('#more').show(); //더 보기 버튼을 띄움
	
        //더 보기 버튼 이벤트
	    $('#more').on({
		'click':function(){
			$('span.content').text(cont).show(); //내용 전체 출력
			$('#more').hide(); //더 보기 버튼 숨기기
		}
		
       });// 더 보기	
	
	 }
	 
	else{ //내용이 5이하일 경우
		$('span.content').show(); // 내용 전체 출력
	}
	
	});
	

 		
	
	
});


</script>
</head>
<body>

  <!-- post-container -->
  
  
  <!-- 게시글, -->
  <div class="post-container">
    <div class="wrap">

      <div class="post">
      
      	<!-- 뉴스피드 헤드 -->
        <div class="post-header">
          <!-- 프로필사진 -->
          <a href="#" class="profile"><img src="./image/0.gif" alt=""></a>
          
          <!-- 작성자 이름  -->
          <a href="#">작성자</a>
          
          	
          <!-- 메뉴 더 보기 출력 -->
            <a href="#"><img src="./image/more.PNG" width="63px" height="46px" id="trigger" 
              name="trigger" class="trigger" alt="" style="float: right;"></a>
            <!-- 다른 앱에 게시, 링크 복사, 공유하기, 보관, 수정, 삭제, 댓글기능 해제 -->
              <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
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

     
            
            
            
            
        </div> <!-- 뉴스피드 헤더 끝 -->
        
        <!-- 업로드한 사진 -->
        <div class="sajin">
          <img src="./image/ramgi.jpeg" alt="">
        </div>
        
        <!-- ------------------------------------------- -->
        
        
        <!-- 사진 아래부분 -->
        <div class="post-footer">
        	<!-- 버튼 컨테이너 -->
          <ul class="btn-container">
          	
          	<!-- 좋아요 버튼 -->
            <li><a href="#"><img src="./image/heart.png" width="42px" height="32px" id="heart" class="heart" name="heart" alt="" ></li>
            
            <!-- 댓글달기 버튼 -->
            <li><a href="#"><img src="./image/balloon.png" width="41px" height="32px" alt=""></a></li>
            
            <!-- 공유하기 버튼 -->
            <li><a href="#"><img src="./image/plane.png" width="42px" height="32px" alt=""></a></li>
            
             <!-- 북마크 버튼 -->
             <a href="#"><img src="./image/bookmark.png" width="43px" height="32px" id="bookmark" class="bookmark" name="bookmark" alt="" style="float: right;"></a>
           
          </ul>
          
          
          
          <!-- 좋아요 텍스트 -->
          <div class="like-container">
            <a href="#">좋아요 n개</a>
          </div>
          
          <!-- 내용 -->
          <div class="text-container">
            <a href="#">작성자</a>
              
              <span class="content" id="content">
              <h5>4월9일 목요일 오후4시 스토리보드 발표.
	              4월21일 화요일 중간프로젝트 발표.</h5>
              </span>
              <span>
            	<button type="button" id="more" style="color: #262626; border: none; opacity: 0.7;">...더 보기</button>
              </span>	
          </div>
          
          <!-- 몇분전에 올린 게시글인지 표시 -->
          <div class="time-container">n분 전에 올라온 게시글</div>
          
          
          <!-- 댓글 -->
          <div class="comment-container">
          	<!-- 댓글을 달 텍스트에리어 -->
            <textarea name="comment" placeholder="댓글 달기..." style="float: left;width:500px;"></textarea>
            
            <!-- 댓글 게시하기 버튼 -->
            
            <button type="submit" class="gesi" style="color: #0095f6; border: none; cursor: pointer; opacity: 0.7;">게시</button>
            <!-- <a href="#"><img src="./image/gesi.png" alt=""></a> -->
          </div>
        </div> <!-- post footer -->
      </div> <!-- post -->

    </div> <!-- wrap -->
  </div> <!-- post-container -->
  <!-- post-container -->
  
  
  

</body>
</html>