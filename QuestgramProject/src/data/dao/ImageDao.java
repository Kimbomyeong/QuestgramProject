package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.ImageDto;
import mysql.db.DbConnect;

public class ImageDao {
	DbConnect db = new DbConnect();
	// Image insert
	public void insertImage(ImageDto dto) {
		Connection conn = db.getConnection();
		String sql = "INSERT INTO Image VALUES (null,?,?,?,now())";  
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBoard_id());
			pstmt.setString(2, dto.getOrigin_name());
			pstmt.setString(3, dto.getSave_name());
			
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("���� INSERT �� ���� "+e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// �ۿ� ������ ��ִ��� ���ڷ� ��ȯ�ϴ� �޼ҵ� 
	public int getImageCount(String board_id) {
		int imageCount = 0;
		Connection conn = db.getConnection();
		String sql = "SELECT COUNT(*) FROM Image WHERE board_id = ?";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				imageCount = rs.getInt("COUNT(*)");
			}
			
		} catch (SQLException e) {
			System.out.println("�Խñۿ� ���� ���� ��ȯ�ϴ� �޼ҵ� : "+e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return imageCount;
	}
	
	// board_id�� �ش��ϴ� ������ �����̸� ��ȯ�ϱ� 
	public List<String> boardIdImage(String board_id) {
		List<String> list = new ArrayList<String>();
		Connection conn = db.getConnection();
		String sql = "SELECT save_name FROM Image WHERE board_id = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("save_name"));
			}			
		} catch (SQLException e) {
			System.out.println("board_id�� �ش��ϴ� �����̸� ��ȯ : "+e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

	// board_id�� �������� �޼ҵ�
	public String getBoard_id(String id) {
		String board_id = "";
		Connection conn = db.getConnection();
		String sql = "SELECT Board.id FROM Board JOIN User "
				+ "ON User.id = Board.user_id "
				+ "WHERE User.id = ? ORDER BY Board.id DESC LIMIT 1";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board_id = rs.getString("Board.id");
			}
		} catch (SQLException e) {
			System.out.println("board_id ��ȯ �޼ҵ� ���� : "+e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return board_id;
	}
	
}