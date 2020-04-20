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
   
	/*
	 * // insert AND select test method public void hashtag(String board_id, String
	 * hashtag) { String sql = "INSERT hashtag VALUES(null, ?, ?, now());";
	 * Connection conn = null; PreparedStatement pstmt = null; conn =
	 * db.getConnection(); try { pstmt = conn.prepareStatement(sql);
	 * 
	 * } catch (SQLException e) { System.out.println("getAllDatas method error : " +
	 * e.getMessage()); } finally { db.dbClose(pstmt, conn); }
	 * 
	 * }
	 */
   
   // ���� �������� �Խù��� 5���� ��������
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
      
      // ������ ��ü �Խù� ���� ���ϱ�
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
         System.out.println("list2 ��� ����: "+e.getMessage());
         
      }
      finally {
         db.dbClose(rs, pstmt, conn);
      }
      
      return list2;
   }
   //list2 ��
   
   
   
   // �Խñ� ���
      // �ֽż�, �������� ������ �Խù��κ��� 5����! �� �ε�
      // �� �ڽŰ�, �� �ȷο����� �Խù��� �޾ƿ�
      public List<BoardDto> getAllDatas(String user_id, String board_id) {
         List<BoardDto> list = new ArrayList<BoardDto>();
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "SELECT Board.*, User.name, User.nickname, User.profile_img "
	               + "FROM Board JOIN (SELECT DISTINCT * FROM User "  
	              + "WHERE User.id IN ((SELECT target_user_id FROM Follow WHERE add_user_id = ?),?)) User "
	               + "ON Board.user_id = User.id "  
	               + "WHERE Board.id < (SELECT IF(? = 'start', MAX(id)+1, ?) FROM Board) " 
	              + "ORDER BY Board.id DESC LIMIT 5";
               // SELECT IF(����, ��1, ��2)
               // : ������ ���̸� ��1, �����̸� ��2�� ��ȯ
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
      } //��� ��
   
   //�Խù� �ø���(�߰�)
   
   //�Խù� �ø���(�߰�)
   
      public void insertBoard(BoardDto dto)
      {
         Connection conn=db.getConnection();
         PreparedStatement pstmt=null;
         String sql="INSERT INTO board (user_id, content, comment_count,"
               + "like_count, view_count, share_count, created_at, updated_at) "
               + "VALUES (?, ?, 0, 0, 0, 0, now(), now())";
         
         try {
            pstmt = conn.prepareStatement(sql); //sql �˻�
            
            //���ε�
            pstmt.setString(1, dto.getUser_id());
            pstmt.setString(2, dto.getContent());
         
            
            pstmt.execute(); //����
            
            
            
         } catch (SQLException e) {
            System.out.println("Insert�� ����: "+ e.getMessage());
            e.printStackTrace();
         } finally {
            db.dbClose(pstmt, conn);
         }
         
      } //insert ��
      
      
      //�Խñ� ����
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
            System.out.println("DELETE�� ����: "+e.getMessage());
            e.printStackTrace();
         }
      } //���� ��
      
      //����id�� �ش� ������ ���� �������� dto�� ���� �޼ҵ�
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
            System.out.println("getBoardData ���� : "+e.getMessage());
            
            e.printStackTrace();
         }finally {
            db.dbClose(rs, pstmt, conn);
         }
         
         return dto;
      }//getBoardData ��
      
      //�Խù� ����
      //����(content), ������¥(updated_at) 
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
            System.out.println("�Խù� ���� ���� : "+ e.getMessage());
            e.printStackTrace();
            
         }finally {
            db.dbClose(pstmt, conn);
         }
      } //���� ��
      
      //���ƿ�
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
            System.out.println("���ƿ� ����: "+e.getMessage());
            e.printStackTrace();
            
         }finally {
            db.dbClose(pstmt, conn);
         }
      } //���ƿ� ��
      
      //id�� �ش��ϴ� ���ƿ� ���� ��ȯ �޼ҵ�
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
               j=rs.getInt(1);//Į�������ε� ����
               
            }
            
         } catch (SQLException e) {
            System.out.println("���ƿ� ��ȯ ����: "+e.getMessage());
            e.printStackTrace();
         }finally {
            db.dbClose(rs, pstmt, conn);
         }
         
         
         return j;
      }//���ƿ� ���ڹ�ȯ ��
      
      //id�� �ش��ϴ� ��ȸ�� 1���� �޼ҵ�
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
            System.out.println("��ȸ�� ������ ����: "+e.getMessage());
            e.printStackTrace();
            
         }finally
         {
            db.dbClose(pstmt, conn);
         }
      }//��ȸ�� ��

      
   // board_id�� �ۼ����� user_id ���
         public String getUser_id(String board_id) {
            String user_id = "";
            Connection conn = db.getConnection();
            String sql = "SELECT user_id FROM Board WHERE id = ?";
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
               pstmt = conn.prepareStatement(sql);
               
               pstmt.setString(1, board_id);
               rs = pstmt.executeQuery();
               
               if(rs.next()) {
            	   user_id = rs.getString("user_id");
               }
            } catch (SQLException e) {
               System.out.println("board_id�� user_id��� : "+e.getMessage());
            } finally {
               db.dbClose(rs, pstmt, conn);
            }
            return user_id;   
         }
   
   //����id�� �ش� ���� �����͸� �������� �޼ҵ�
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
         System.out.println("getBoardData ���� : "+e.getMessage());

         e.printStackTrace();
      }finally {
         db.dbClose(rs, pstmt, conn);
      }

      return dto;
   }
   
// �ؽ��±� ����
	public void insertHashtag(String board_id, String hashtag) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into Hashtag (board_id, hashtag, created_at) values (?, ?, now())";

		conn = db.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_id);
			pstmt.setString(2, hashtag);

			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}

	// �ؽ��±� ���
	public List<String> hashtagList(String board_id) {
		List<String> list = new Vector<String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select hashtag from Hashtag where board_id = ?";

		conn = db.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("hashtag"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

	// �ؽ��±� ��ȣ �� ��ȯ
	public String getHashId(String board_id, String hashtag) {
		String hashid = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id from Hashtag where board_id = ? and hashtag = ?";

		conn = db.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_id);
			pstmt.setString(2, hashtag);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				hashid = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return hashid;
	}

	// �ؽ��±� ����
	public void deleteHash(String hashid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from Hashtag where id = ?";

		conn = db.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hashid);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 유저 아이디로 해당 유저가 작성한 글의 번호 얻기
	public List<String> getAllBoardId(String user_id) {
		List<String> list = new ArrayList<String>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT id FROM Board WHERE user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getString("id"));
			}
			
		} catch (SQLException e) {
			System.out.println("getAllBoardId : "+e.getMessage());
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
}