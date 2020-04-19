<!-- boardtest.jsp 출력 테스트용 임시파일 -->

<%@page import="data.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Test</title>
<script type="text/javascript">
$(function() {
   
});
</script>

</head>

<body>
<%
   BoardDao bdb = new BoardDao();
   //동적으로 "start"값에 board_id를 넣도록 수정예정
   List<BoardDto> blist = bdb.getAllDatas("1");
   
   for (BoardDto dto: blist) {
%>      <div class="post" board_id="<%= dto.getId()%>">
         <span class="user">
            ~작성자 표시 영역~<br>
            프로필url: <%= dto.getProfile_img() %><br>
            아이디(닉네임): <%= dto.getNickname() %><br>
            이름: <%= dto.getName() %>
            <hr>
         </span>
         <span class="counts">
            좋아요 <%= dto.getLike_count() %>개<br>
            공유수 <%= dto.getShare_count() %><br>
            조회수 <%= dto.getView_count() %><br>
            <hr>
         </span>
         <span class="content">
            ~내용 출력 영역~<br>
            <%= dto.getContent() %>
            <hr>
         </span>
         
         <div class="comment" board_id="<%=dto.getId()%>">
            <hr>
            ~댓글 출력 영역~ board_id를 넘겨줘야 함<br>
            여기서 "List<\CommentDto> clist = new CommentDto(넘겨준board_id)" 작성해서<br>
            여기서 for문 "for (CommentDto cdto: clist)" 사용해 댓글 출력
         </div>
      </div>
      <hr>
<%   }
%>
   
</body>
</html>