package data.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import data.dto.CommentDto;

import java.sql.Connection;

import mysql.db.DbConnect;
public class CommentDao {
		mysql.db.DbConnect db=new DbConnect();
		public void insertComment(CommentDto dto)
			{
				Connection conn=null;
				PreparedStatement pstmt=null;
				String sql="insert into comment values (null, ?, ?, ?, 0, ?, now(),now())";
	
				conn=db.getConnection();
				try {
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, dto.getBoard_id());
					pstmt.setString(2, dto.getUser_id());
					pstmt.setString(3, dto.getContent());
					pstmt.setString(4, dto.getParents_comments_id());
					pstmt.execute();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println("insert 오류:"+e.getMessage());
					e.printStackTrace();
				}finally{
					db.dbClose(pstmt, conn);
				}
			}
		

		
		public List<CommentDto> getComment(String board_id)
		{
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<CommentDto> list=new ArrayList<>();
			String sql="SELECT User.id userNum, User.nickname id, User.profile_img, Comment.id commentNo, Comment.content, Comment.like_count, Comment.parents_comments_id, Comment.created_at, Comment.board_id FROM Comment JOIN User ON Comment.user_id = User.id WHERE board_id = ? ORDER BY Comment.created_at";
			conn=db.getConnection();
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, board_id);
				rs=pstmt.executeQuery();
				
				while(rs.next())
				{	
					CommentDto dto= new CommentDto();

					dto.setUsernum(rs.getString("usernum"));
					dto.setId(rs.getString("id"));
					dto.setProfile_img(rs.getString("profile_img"));
					dto.setCommentno(rs.getString("commentno"));
					dto.setContent(rs.getString("content"));
					dto.setLike_count(rs.getString("like_count"));
					dto.setParents_comments_id(rs.getString("parents_comments_id"));
					dto.setCreated_at(rs.getTimestamp("created_at"));
					dto.setBoard_id(rs.getString("board_id"));
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("select 오류:"+e.getMessage());
				e.printStackTrace();
			}finally{
				db.dbClose(rs, pstmt, conn);
			}
			return list;
		}
		
		public CommentDto getCommentCount(String id)
		{
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			CommentDto dto= new CommentDto();
			String sql="select count(*) from comment where id=?";
			
			conn=db.getConnection();
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				
				if(rs.next())
				{
					dto.setId(rs.getString("id"));
					dto.setBoard_id(rs.getString("board_id"));
					dto.setContent(rs.getString("Content"));
					dto.setLike_count(rs.getString("like_count"));
					dto.setParents_comments_id(rs.getString("parents_comments_id"));
					dto.setCreated_at(rs.getTimestamp("created_at"));
					dto.setUpdated_at(rs.getTimestamp("updated_at"));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("select 오류:"+e.getMessage());
				e.printStackTrace();
			}finally{
				db.dbClose(rs, pstmt, conn);
			}
			return dto;
		}
		
		public void updatelike_count(String like_count,String id)
		{
			Connection conn=null;
			PreparedStatement pstmt=null;
			String sql="";
			
			conn=db.getConnection();
			if(like_count.equals("1"))
				sql="update comment set like_count=like_count+1 where id=?";
			else
				sql="update comment set like_count=like_count-1 where id=?";
			
			try {
				pstmt=conn.prepareStatement(sql);
				//바인딩
				pstmt.setString(1, id);
				//실행
				pstmt.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				db.dbClose(pstmt, conn);
			}
		}
		
		//num 에 해당하는 좋아요 숫자 반환하는 메서드
		public int getlike_count(String id)
		{
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="";
			int j=0;
			
			conn=db.getConnection();
			sql="select like_count from comment where id=?";
			try {
				pstmt=conn.prepareStatement(sql);
				//바인딩
				pstmt.setString(1, id);
				//실행
				rs=pstmt.executeQuery();
				
				if(rs.next())
				{
					j=rs.getInt(1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				db.dbClose(rs, pstmt, conn);
			}
			return j;		
		}


		public void deleteComment(String id) {
			Connection conn=null;
			PreparedStatement pstmt=null;
			String sql="delete from comment where id=?";
		
			conn=db.getConnection();
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.execute();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("delete 오류:"+e.getMessage());
				e.printStackTrace();
			}finally{
				db.dbClose(pstmt, conn);
			}
		}
}
