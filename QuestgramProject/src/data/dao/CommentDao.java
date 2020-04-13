package data.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
				String sql="insert into comment values (null, board_id=?, user_id=?, content=?, like_count=?, parents_comments_id=?, now(),now()";
			
				conn=db.getConnection();
				try {
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, dto.getId());
					pstmt.setString(2, dto.getBoard_id());
					pstmt.setString(3, dto.getUser_id());
					pstmt.setString(4, dto.getContent());
					pstmt.setString(5, dto.getLike_count());
					pstmt.setString(6, dto.getParents_comments_id());
					pstmt.execute();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println("insert 오류:"+e.getMessage());
					e.printStackTrace();
				}finally{
					db.dbClose(pstmt, conn);
				}
			}
		
		public List<CommentDto> getAllCommentList()
		{
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<CommentDto> list=new Vector<CommentDto>();
			String sql="select * from comment order by id";
			
			conn=db.getConnection();
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				while(rs.next())
				{
					CommentDto dto= new CommentDto();
					dto.setId(rs.getString("id"));
					dto.setBoard_id(rs.getString("board_id"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setContent(rs.getString("Content"));
					dto.setLike_count(rs.getString("like_count"));
					dto.setParents_comments_id(rs.getString("parents_comments_id"));
					dto.setCreated_at(rs.getTimestamp("created_at"));
					dto.setUpdated_at(rs.getTimestamp("updated_at"));
					
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
		
		public CommentDto getComment(String id)
		{
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			CommentDto dto= new CommentDto();
			String sql="select * from comment where id=? order by id";
			
			conn=db.getConnection();
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				
				if(rs.next())
				{
					dto.setId(rs.getString("id"));
					dto.setBoard_id(rs.getString("board_id"));
					dto.setUser_id(rs.getString("user_id"));
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
					dto.setUser_id(rs.getString("user_id"));
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
		
		public void updateComment(String content, String id)
		{
			Connection conn=null;
			PreparedStatement pstmt=null;
			String sql="update comment set content=?,updated_at=now() where id=?";
		
			conn=db.getConnection();
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, content);
				pstmt.setString(2, id);

				pstmt.execute();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("update 오류:"+e.getMessage());
				e.printStackTrace();
			}finally{
				db.dbClose(pstmt, conn);
			}
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
