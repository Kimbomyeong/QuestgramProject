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
	
	// ���� �ĺ�, ���� ��������
	String thisId = "3";
	// ���Ƿ� ������, ������ �� ���������� �Ѿ�� ������id��
	// String thisId = request.getParameter("thisId");
	UserDto udto = udao.getUser(thisId);
	
	//**********�ȷο� ���� ����*********
	String userId = (String)session.getAttribute("userid");
	
	
	String now = fdao.followNow(thisId, userId);	//�ȷο� ����
	//**********�ȷο� ���� ��*********
	
	
	//**********�Խñ� ���� ����*********
	String boardId = "start";	// ���� ���� ��
	
	String howMany = bdao.howMany(thisId);
	List<BoardDto> blist = bdao.getPrfBoard(thisId, boardId);
	//**********�Խñ� ���� ��***********

//				***********************�Խñ� ���� ����*************************
				for (BoardDto bdto: blist) {
					String bnow = fdao.followNow(bdto.getUser_id(), userId);
%>		
		
		<!-- �Խñ�, -->
  <div class="post-container">
  <input type="hidden" name="postnum" class="postnum" value="<%=bdto.getId()%>">
    <div class="wrap">

      <div class="post">
      
      
       
       
         <!-- �����ǵ� ��� -->
        <div class="post-header" >
          <!-- �����ʻ��� -->
          <a href="#" class="profile"><img src="Post/image/0.gif" alt=""></a>
          
          <!-- �ۼ��� �̸�  -->
          <a href="#"><%=bdto.getUser_id() %></a>
          
             
          <!-- �޴� �� ���� ��� -->
            <a href="#"><img src="Post/image/more.PNG" width="32px" height="20px" id="trigger" 
              name="trigger" class="trigger" alt="" style="float: right;"></a>
            <!-- �ٸ� �ۿ� �Խ�, ��ũ ����, �����ϱ�, ����, ����, ����, ��۱�� ���� -->
              <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" style="z-index:9999;">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
      
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form">
               <button type="button" class="btn btn-default btn-block">�Խù��� �̵�</button>
                <button type="button" class="btn btn-default btn-block">��ũ ����</button>
                <button type="button" class="btn btn-default btn-block">�����ϱ�</button>
                <button type="button" class="btn btn-default btn-block">����</button>
                <button type="button" class="btn btn-default btn-block"
                      onclick="location.href='Post/Post_Update_Form.jsp'">����</button>
                <button type="button" class="btn btn-default btn-block"
                      onclick="location.href='Post/Post_Delete_Action.jsp?id=<%=bdto.getId()%>'">����</button>
                <button type="button" class="btn btn-default btn-block">��� ��� ����</button>
          </form>
        </div>
     </div>
      
    </div>
  </div> <!-- modal �� -->

     
            
            
            
            
        </div> <!-- �����ǵ� ��� �� -->
        
        <!-- ���ε��� ���� -->
        <div class="sajin">
          <img src="Post/image/ramgi.jpeg" alt="">
        </div>
        
        <!-- ------------------------------------------- -->
        
        
        <!-- ���� �Ʒ��κ� -->
        <div class="post-footer">
           <!-- ��ư �����̳� -->
          <ul class="btn-container">
             <!-- ��Ʈ�� ��ư�����̳ʱ��� ȣ���� �� next span���� ���ƿ並 ã�� -->
             <!-- ���ƿ� ��ư -->
            <li><img src="../Post/image/heart.png" board_id="<%=bdto.getId()%>"
            width="42px" height="32px"  class="heart" name="heart" alt="" ></li>
            
            <!-- ��۴ޱ� ��ư -->
            <li><img src="../Post/image/balloon.png" width="41px" height="32px" alt=""></li>
            
            <!-- �����ϱ� ��ư -->
            <li><img src="../Post/image/plane.png" width="42px" height="32px" alt=""></li>
            
             <!-- �ϸ�ũ ��ư -->
             <img src="../Post/image/bookmark.png" width="43px" height="32px" class="bookmark" name="bookmark" alt="" style="float: right;">
           
          </ul>
          
          
          
          <!-- ���ƿ� �ؽ�Ʈ -->
          <div class="like-container">
            <a href="#">���ƿ�&nbsp;<span class="cnt"><%=bdto.getLike_count()%></span>��</a>
          </div>
          
          <!-- ���� -->
          <div class="text-container">
            <a href="#"><%=bdto.getUser_id() %></a>
              
              <span class="contents" id="contents">
              <h5><%=bdto.getContent() %></h5>
              </span>
              <span>
             
               <button type="button" id="more" style="border: none; background-color:#fff; color:#8e8e8e;">...�� ����</button>
              </span>   
          </div>
          
          <!-- ������� �ø� �Խñ����� ǥ�� -->
          <div class="time-container"><%=bdto.getCreated_at() %></div>
          
          
          <!-- ��� -->
          <div class="comment-container">
             <!-- ����� �� �ؽ�Ʈ������ -->
            <textarea name="comment" placeholder="��� �ޱ�..." style="float: left; width:535px;"></textarea>
            
            <!-- ��� �Խ��ϱ� ��ư -->
            
            <button type="submit" class="gesi">�Խ�</button>
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