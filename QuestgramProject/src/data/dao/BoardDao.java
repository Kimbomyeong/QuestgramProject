package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.BoardDto;
import mysql.db.DbConnect;

public class BoardDao {
	DbConnect db = new DbConnect();
	
	// 게시글 출력 (최신순, 페이지의 마지막 게시물로부터 5개만! 더 로드)
	public List<BoardDto> getAllDatas(String board_id) {
		List<BoardDto> list = new ArrayList<BoardDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT board.*, user.name, user.nickname, user.profile_img "
				+ "FROM board JOIN user "
				+ "WHERE board.id < ? AND user.id = board.user_id "
				+ "ORDER BY board.id DESC limit 5;";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				dto.setUser_id(rs.getString("id"));
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
}
