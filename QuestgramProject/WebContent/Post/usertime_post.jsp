<%@page import="data.dao.CommentDao"%>
<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.BoardDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.FollowDao"%>
<%@page import="data.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%	
	UserDao udao = new UserDao();
	FollowDao fdao = new FollowDao();
	BoardDao bdao = new BoardDao();
	CommentDao cdao = new CommentDao();
	
	// 유저 식별, 정보 가져오기
	String thisId = "3";
	// 임의로 줬지만, 원래는 앞 페이지에서 넘어온 프로필id값
	// String thisId = request.getParameter("thisId");
	UserDto udto = udao.getUser(thisId);
	
	//**********팔로우 영역 구현*********
	String userId = (String)session.getAttribute("userid");
	
	
	String now = fdao.followNow(thisId, userId);	//팔로우 여부
	//**********팔로우 영역 끝*********
	
	
	//**********게시글 영역 구현*********
	String boardId = "start";	// 최초 실행 값
	
	String howMany = bdao.howMany(thisId);
	List<BoardDto> blist = bdao.getPrfBoard(thisId, boardId);
	//**********게시글 영역 끝***********

//				***********************게시글 영역 시작*************************
				for (BoardDto bdto: blist) {
					String bnow = fdao.followNow(bdto.getUser_id(), userId);
%>		
		
		<!-- 게시글, -->
  <div class="post-container">
  <input type="hidden" name="postnum" class="postnum" value="<%=bdto.getId()%>">
    <div class="wrap">

      <div class="post">
      
      
       
       
         <!-- 뉴스피드 헤드 -->
        <div class="post-header" >
          <!-- 프로필사진 -->
          <a href="#" class="profile"><img src="Post/image/0.gif" alt=""></a>
          
          <!-- 작성자 이름  -->
          <a href="#"><%=bdto.getUser_id() %></a>
          
             
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
                      onclick="location.href='Post/Post_Delete_Action.jsp?id=<%=bdto.getId()%>'">삭제</button>
                <button type="button" class="btn btn-default btn-block">댓글 기능 해제</button>
          </form>
        </div>
     </div>
      
    </div>
  </div> <!-- modal 끝 -->

     
            
            
            
            
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
             <!-- 페어런트로 버튼컨테이너까지 호출한 뒤 next span으로 좋아요를 찾자 -->
             <!-- 좋아요 버튼 -->
            <li><img src="../Post/image/heart.png" board_id="<%=bdto.getId()%>"
            width="42px" height="32px"  class="heart" name="heart" alt="" ></li>
            
            <!-- 댓글달기 버튼 -->
            <li><img src="../Post/image/balloon.png" width="41px" height="32px" alt=""></li>
            
            <!-- 공유하기 버튼 -->
            <li><img src="../Post/image/plane.png" width="42px" height="32px" alt=""></li>
            
             <!-- 북마크 버튼 -->
             <img src="../Post/image/bookmark.png" width="43px" height="32px" class="bookmark" name="bookmark" alt="" style="float: right;">
           
          </ul>
          
          
          
          <!-- 좋아요 텍스트 -->
          <div class="like-container">
            <a href="#">좋아요&nbsp;<span class="cnt"><%=bdto.getLike_count()%></span>개</a>
          </div>
          
          <!-- 내용 -->
          <div class="text-container">
            <a href="#"><%=bdto.getUser_id() %></a>
              
              <span class="contents" id="contents">
              <h5><%=bdto.getContent() %></h5>
              </span>
              <span>
             
               <button type="button" id="more" style="border: none; background-color:#fff; color:#8e8e8e;">...더 보기</button>
              </span>   
          </div>
          
          <!-- 몇분전에 올린 게시글인지 표시 -->
          <div class="time-container"><%=bdto.getCreated_at() %></div>
          
          
          <!-- 댓글 -->
          <div class="comment-container">
             <!-- 댓글을 달 텍스트에리어 -->
            <textarea name="comment" placeholder="댓글 달기..." style="float: left; width:535px;"></textarea>
            
            <!-- 댓글 게시하기 버튼 -->
            
            <button type="submit" class="gesi">게시</button>
            <!-- <a href="#"><img src="Post/image/gesi.png" alt=""></a> -->
          </div>
        </div> <!-- post footer -->
      </div> <!-- post -->

    </div> <!-- wrap -->
  </div> <!-- post-container -->
  <!-- post-container -->
 
  
 <%}%>
</body>
</html>