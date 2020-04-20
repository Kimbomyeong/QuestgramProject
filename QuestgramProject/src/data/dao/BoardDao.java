package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import data.dto.BoardDto;
import mysql.db.DbConnect;

public class BoardDao {
   DbConnect db = new DbConnect();
   
   // 유저 프로필의 게시물만 5개씩 가져오기
      public List<BoardDto> getPrfBoard(String thisId, String boardId) {
         List<BoardDto> list = new ArrayList<BoardDto>();
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "SELECT board.*, user.name, user.nickname, user.profile_img "
               + "FROM board JOIN user "
               + "ON board.user_id = ? "
               + "WHERE board.id < (SELECT IF(? = 'start', MAX(id)+1, ?) FROM board) "
               + "GROUP BY board.id ORDER BY board.id DESC LIMIT 5;";
         
         conn = db.getConnection();
         try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, thisId);
            pstmt.setString(2, boardId);
            pstmt.setString(3, boardId);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
               BoardDto dto = new BoardDto();
               dto.setUser_id(rs.getString("user_id"));
               dto.setContent(rs.getString("content"));
               dto.setComment_count(rs.getString("comment_count"));
               dto.setLike_count(rs.getString("like_count"));
               dto.setView_count(rs.getString("view_count"));
               dto.setShare_count(rs.getString("share_count"));
               dto.setCreated_at(rs.getTimestamp("created_at"));
               dto.setUpdated_at(rs.getTimestamp("updated_at"));
               
               dto.setName(rs.getString("name"));
               dto.setNickname(rs.getString("nickname"));
               dto.setProfile_img(rs.getString("profile_img"));
               
               list.add(dto);
            }
         } catch (SQLException e) {
            System.out.println("getAllDatas method error : " + e.getMessage());
         } finally {
            db.dbClose(rs, pstmt, conn);
         }
         return list;
      }
      
      // 유저의 전체 게시물 갯수 구하기
      public String howMany(String thisId) {
         String howMany = "";
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "SELECT count(*) FROM board WHERE user_id = ?";
         
         conn = db.getConnection();
         try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, thisId);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
               howMany = Integer.toString(rs.getInt(1));
            }
         } catch (SQLException e) {
            System.out.println("getAllDatas method error : " + e.getMessage());
         } finally {
            db.dbClose(rs, pstmt, conn);
         }
         return howMany;
      }
   
   
   public List<BoardDto> getAllDatas2()
   {
      List<BoardDto> list2 = new Vector<BoardDto>();
      Connection conn = null;
      PreparedStatement pstmt=null;
      ResultSet rs = null;
      String sql ="SELECT * FROM board ORDER BY created_at DESC";
      
      conn=db.getConnection();
      
      try {
         pstmt=conn.prepareStatement(sql);
         rs=pstmt.executeQuery();
         while(rs.next())
         {
            BoardDto dto = new BoardDto();
            dto.setId(rs.getString("id"));
            dto.setUser_id(rs.getString("user_id"));
            dto.setContent(rs.getString("content"));
            dto.setComment_count(rs.getString("comment_count"));
            dto.setLike_count(rs.getString("like_count"));
            dto.setView_count(rs.getString("view_count"));
            dto.setCreated_at(rs.getTimestamp("created_at"));
            dto.setUpdated_at(rs.getTimestamp("updated_at"));
            
            list2.add(dto);
            
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         System.out.println("list2 출력 오류: "+e.getMessage());
         
      }
      finally {
         db.dbClose(rs, pstmt, conn);
      }
      
      return list2;
   }
   //list2 끝
   
   
   
   // 게시글 출력
      // 최신순, 페이지의 마지막 게시물로부터 5개만! 더 로드
      // 나 자신과, 내 팔로워들의 게시물만 받아옴
      public List<BoardDto> getAllDatas(String user_id, String board_id) {
         List<BoardDto> list = new ArrayList<BoardDto>();
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "SELECT board.*, user.name, user.nickname, user.profile_img "
               + "FROM board JOIN (SELECT DISTINCT * FROM user "
               + "JOIN (SELECT target_user_id FROM follow WHERE add_user_id = ?) follow "
               + "WHERE user.id IN (?, follow.target_user_id)) user "
               + "ON board.user_id = user.id "
               + "WHERE board.id < (SELECT IF(? = 'start', MAX(id)+1, ?) FROM board) "
               + "ORDER BY board.id DESC LIMIT 5";
               // SELECT IF(조건, 값1, 값2)
               // : 조건이 참이면 값1, 거짓이면 값2를 반환
         conn = db.getConnection();
         try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, user_id);
            pstmt.setString(3, board_id);
            pstmt.setString(4, board_id);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
               BoardDto dto = new BoardDto();
               dto.setId(rs.getString("id"));
               dto.setUser_id(rs.getString("user_id"));
               dto.setContent(rs.getString("content"));
               dto.setComment_count(rs.getString("comment_count"));
               dto.setLike_count(rs.getString("like_count"));
               dto.setView_count(rs.getString("view_count"));
               dto.setShare_count(rs.getString("share_count"));
               dto.setCreated_at(rs.getTimestamp("created_at"));
               dto.setUpdated_at(rs.getTimestamp("updated_at"));
               
               dto.setName(rs.getString("name"));
               dto.setNickname(rs.getString("nickname"));
               dto.setProfile_img(rs.getString("profile_img"));
               
               list.add(dto);
            }
         } catch (SQLException e) {
            System.out.println("getAllDatas method error : " + e.getMessage());
         } finally {
            db.dbClose(rs, pstmt, conn);
         }
         
         return list;
      } //출력 끝
   
   //게시물 올리기(추가)
   
   //게시물 올리기(추가)
   
      public void insertBoard(BoardDto dto)
      {
         Connection conn=db.getConnection();
         PreparedStatement pstmt=null;
         String sql="INSERT INTO board (user_id, content, comment_count,"
               + "like_count, view_count, share_count, created_at, updated_at) "
               + "VALUES (?, ?, 0, 0, 0, 0, now(), now())";
         
         try {
            pstmt = conn.prepareStatement(sql); //sql 검사
            
            //바인딩
            pstmt.setString(1, dto.getUser_id());
            pstmt.setString(2, dto.getContent());
         
            
            pstmt.execute(); //실행
            
            
            
         } catch (SQLException e) {
            System.out.println("Insert문 오류: "+ e.getMessage());
            e.printStackTrace();
         } finally {
            db.dbClose(pstmt, conn);
         }
         
      } //insert 끝
      
      
      //게시글 삭제
      public void deleteBoard(String id)
      {
         Connection conn = db.getConnection();
         String sql = "DELETE FROM board WHERE ID = ?";
         PreparedStatement pstmt = null;
         
         try {
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, id);
            pstmt.execute();
            
         } catch (SQLException e) {
            System.out.println("DELETE문 오류: "+e.getMessage());
            e.printStackTrace();
         }
      } //삭제 끝
      
      //유저id로 해당 유저의 정보 수정폼에 dto를 보낼 메소드
      public BoardDto getBoardData(String id)
      {
         BoardDto dto = new BoardDto();
         
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql="SELECT * FROM board WHERE ID = ?";
         
         conn=db.getConnection();
         
         try {
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, id);
            rs=pstmt.executeQuery();
            
            if(rs.next())
            {
               dto.setId(rs.getString("id"));
               dto.setUser_id(rs.getString("user_id"));
               dto.setContent(rs.getString("content"));
               dto.setComment_count(rs.getString("comment_count"));
               dto.setLike_count(rs.getString("like_count"));
               dto.setView_count(rs.getString("view_count"));
               dto.setShare_count(rs.getString("share_count"));
               dto.setCreated_at(rs.getTimestamp("created_at"));
               dto.setUpdated_at(rs.getTimestamp("updated_at"));
               
               
            }
         } catch (SQLException e) {
            System.out.println("getBoardData 오류 : "+e.getMessage());
            
            e.printStackTrace();
         }finally {
            db.dbClose(rs, pstmt, conn);
         }
         
         return dto;
      }//getBoardData 끝
      
      //게시물 수정
      //내용(content), 수정날짜(updated_at) 
      public void updateBoard(BoardDto dto) 
      {
         Connection conn = db.getConnection();
         String sql = "UPDATE board SET content=?, updated_at=now() WHERE ID = ?";
         PreparedStatement pstmt = null;
         
         try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getContent());
            pstmt.setString(2, dto.getId());
            
            pstmt.execute();
         } catch (SQLException e) {
            System.out.println("게시물 수정 오류 : "+ e.getMessage());
            e.printStackTrace();
            
         }finally {
            db.dbClose(pstmt, conn);
         }
      } //수정 끝
      
      //좋아요
      public void updateLikecount(String like_count,String id)
      {
         System.out.println(like_count);
         System.out.println(id);
         Connection conn=null;
         PreparedStatement pstmt=null;
         String sql="";
         
         conn=db.getConnection();
         
         if(like_count.equals("1"))
         {
            sql="UPDATE board SET like_count = like_count+1 WHERE id = ?";
         }
         else
            sql="UPDATE board SET like_count = like_count-1 WHERE id = ?";
         
         try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.execute();
         } catch (SQLException e) {
            System.out.println("좋아요 오류: "+e.getMessage());
            e.printStackTrace();
            
         }finally {
            db.dbClose(pstmt, conn);
         }
      } //좋아요 끝
      
      //id에 해당하는 좋아요 숫자 반환 메소드
      public int getLikecount(String id)
      {
         Connection conn=null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql="";
         int j=0;
         
         conn=db.getConnection();
         sql="SELECT like_count FROM board WHERE id=?";
         
         try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs=pstmt.executeQuery();
            
            if(rs.next())
            {
               j=rs.getInt(1);//칼럼명으로도 가능
               
            }
            
         } catch (SQLException e) {
            System.out.println("좋아요 반환 오류: "+e.getMessage());
            e.printStackTrace();
         }finally {
            db.dbClose(rs, pstmt, conn);
         }
         
         
         return j;
      }//좋아요 숫자반환 끝
      
      //id에 해당하는 조회수 1증가 메소드
      public void updateViewcount(String id)
      {
         Connection conn=null;
         PreparedStatement pstmt=null;
         String sql="UPDATE board SET view_count=view count+1 WHERE id=?";
         
         conn=db.getConnection();
         
         try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.execute();
            
         } catch (SQLException e) {
            System.out.println("조회수 증가문 오류: "+e.getMessage());
            e.printStackTrace();
            
         }finally
         {
            db.dbClose(pstmt, conn);
         }
      }//조회수 끝

      
   // board_id로 작성자의 user_id 얻기
   		public String getUser_id(String board_id) {
   			String user_id = "";
   			Connection conn = db.getConnection();
   			String sql = "SELECT user_id FROM Board WHERE id = ?";
   			PreparedStatement pstmt = null;
   			ResultSet rs = null;
   			try {
   				pstmt = conn.prepareStatement(sql);
   			} catch (SQLException e) {
   				System.out.println("board_id로 user_id얻기 : "+e.getMessage());
   			} finally {
   				db.dbClose(rs, pstmt, conn);
   			}
   			return user_id;	
   		}
	
	//보드id로 해당 보드 데이터를 가져오는 메소드
	public BoardDto getBoardDataWithUser(String board_id){
		BoardDto dto = new BoardDto();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="SELECT Board.id, Board.content, Board.user_id, Board.comment_count, Board.like_count, Board.view_count, Board.share_count, Board.created_at, Board.updated_at, User.id usernum, User.name, User.nickname, User.profile_img FROM Board JOIN User ON Board.user_id = User.id WHERE Board.ID = ?";

		conn=db.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, board_id);
			rs=pstmt.executeQuery();

			if(rs.next())
			{
				dto.setId(rs.getString("id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setContent(rs.getString("content"));
				dto.setComment_count(rs.getString("comment_count"));
				dto.setLike_count(rs.getString("like_count"));
				dto.setView_count(rs.getString("view_count"));
				dto.setShare_count(rs.getString("share_count"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setUpdated_at(rs.getTimestamp("updated_at"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setProfile_img(rs.getString("Profile_img"));
			}
		} catch (SQLException e) {
			System.out.println("getBoardData 오류 : "+e.getMessage());

			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}

		return dto;
	}
}