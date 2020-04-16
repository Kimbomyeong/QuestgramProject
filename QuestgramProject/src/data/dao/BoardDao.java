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
	
	// �Խñ� ��� (�ֽż�, �������� ������ �Խù��κ��� 5����! �� �ε�)
	public List<BoardDto> getAllDatas(String board_id) {
		List<BoardDto> list = new ArrayList<BoardDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT board.*, user.name, user.nickname, user.profile_img "
				+ "FROM board JOIN user "
				+ "WHERE board.id < (SELECT IF(? = 'start', MAX(id), ?) FROM board) "
				+ "AND user.id = board.user_id ORDER BY board.id DESC limit 30;";
				// SELECT IF(����, ��1, ��2)
				// : ������ ���̸� ��1, �����̸� ��2�� ��ȯ
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_id);
			pstmt.setString(2, board_id);
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
			String sql = "UPDATE board SET content=?, update_at=now() WHERE ID = ?";
			PreparedStatement pstmt = null;
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getContent());
				
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
}
