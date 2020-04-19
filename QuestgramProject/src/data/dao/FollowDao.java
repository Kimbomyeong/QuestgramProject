package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.FollowDto;
import data.dto.UserDto;
import mysql.db.DbConnect;

public class FollowDao {
	DbConnect db = new DbConnect();
	
	// �ȷο�
	// (�ߺ����� ���� ���� �� ��. �ȷο� ��ư�� Ȱ��ȭ���� �����Ƿ�.)
	public void insertFollow(String add, String target) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT Follow VALUES(null, ?, ?, now())";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, add);
			pstmt.setString(2, target);
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("insert Follow error : " + e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	// �ȷο� ����
	public void deleteFollow(String add, String target) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM Follow WHERE add_user_id = ? AND target_user_id = ?";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, add);
			pstmt.setString(2, target);
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("delete follow error : " + e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	// �ȷο� ����Ʈ ��������
	public List<FollowDto> getFollowers(String id) {
		List<FollowDto> list = new ArrayList<FollowDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT User.id, User.name, User.nickname, User.profile_img, Follow.created_at "
				+ "FROM User "
				+ "JOIN (SELECT add_user_id, created_at FROM Follow WHERE target_user_id = ?) Follow "
				+ "ON User.id = Follow.add_user_id;";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				FollowDto dto = new FollowDto();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNickname(rs.getString("nickname"));
				dto.setProfile_img(rs.getString("profile_img"));
				// follow, user ���̺� �� �� Į������ created_at���� ���Ƽ�
				// follow�� dto �������� followed_at ���� �ۼ���
				dto.setFollowed_at(rs.getTimestamp("created_at"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("get followers method error : " + e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	// �ȷ��� ����Ʈ ��������
	public List<FollowDto> getFollowings(String id) {
		List<FollowDto> list = new ArrayList<FollowDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT User.id, User.name, User.nickname, User.profile_img, Follow.created_at "
				+ "FROM User "
				+ "JOIN (SELECT target_user_id, created_at FROM Follow WHERE add_user_id = ?) Follow "
				+ "ON User.id = Follow.target_user_id;";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				FollowDto dto = new FollowDto();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNickname(rs.getString("nickname"));
				dto.setProfile_img(rs.getString("profile_img"));
				// follow, user ���̺� �� �� Į������ created_at���� ���Ƽ�
				// follow�� dto �������� followed_at ���� �ۼ���
				dto.setFollowed_at(rs.getTimestamp("created_at"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("get followers method error : " + e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	// ���� �ȷο��ϴ��� �˾ƺ���
	public String followNow(String id, String userid) {
		String now = "follow";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) FROM Follow "
				+ "WHERE add_user_id = ? AND target_user_id = ?";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (rs.getInt(1) > 0)
					now = "unfollow";
			}
			
		} catch (SQLException e) {
			System.out.println("follow now method error : " + e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
		
		return now;
	}
	
	// �ȷο� ��õ
	// �� ģ���� �ȷο��ϴ� ģ���� ����Ʈ��, ���� �ֱٿ� �ȷο��� �������
	public List<FollowDto> rcmmdFollow(String userid) {
		List<FollowDto> list = new ArrayList<FollowDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT User.id, User.name, User.nickname, User.profile_img, Follow.created_at "
				+ "FROM User JOIN (SELECT * FROM Follow "
				+ "WHERE add_user_id IN (SELECT target_user_id FROM Follow "
				+ "WHERE add_user_id = ?)) Follow "
				+ "ON User.id = Follow.target_user_id "
				+ "ORDER BY Follow.created_at DESC;";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				FollowDto dto = new FollowDto();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNickname(rs.getString("nickname"));
				dto.setProfile_img(rs.getString("profile_img"));
				dto.setFollowed_at(rs.getTimestamp("created_at"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("get followers method error : " + e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
}