package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.UserDto;
import encrypt.Encryption;
import mysql.db.DbConnect;

public class UserDao {
	DbConnect db = new DbConnect();
	Encryption encrypt = new Encryption();

	// 회원가입 유저추가
	public void insertUser(UserDto dto) {
		Connection conn = db.getConnection();
		String sql = "INSERT INTO user (password, nickname, name, email, created_at, updated_at) "
				+ "VALUES (?, ?, ?, ?, now(), now())";
		PreparedStatement pstmt = null;
		String encryptPwd = "";

		try {
			pstmt = conn.prepareStatement(sql);
			boolean isSuccess = encrypt.encryption(dto.getPassword());
			if(isSuccess) {
				encryptPwd = encrypt.getPassword();
				pstmt.setString(1, encryptPwd);
			}
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());

			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("Insert문 오류 : "+e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}

	}
	// 유저삭제(회원탈퇴)
	public void deleteUser(String id) {
		Connection conn = db.getConnection();
		String sql = "DELETE FROM user WHERE ID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("DELETE문 오류 : "+e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	// 전체 유저 조회
	public List<UserDto> getAllUsers(){
		List<UserDto> list = new ArrayList<UserDto>();
		Connection conn = db.getConnection();
		String sql = "SELECT * FROM user ORDER BY id";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				UserDto dto = new UserDto();

				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getString("birth"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setProfile_img(rs.getString("profile_img"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setUpdated_at(rs.getTimestamp("updated_at"));

				list.add(dto);
			}	
		} catch (SQLException e) {
			System.out.println("전체 회원 목록 출력 : "+e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

	// 유저id로 해당 유저 정보 수정폼에 dto 보내는 메소드
	public UserDto getUser(String id) {
		UserDto dto = new UserDto();
		Connection conn = db.getConnection();
		String sql = "SELECT * FROM user WHERE ID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if(rs.next()) {

				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getString("birth"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setProfile_img(rs.getString("profile_img"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setUpdated_at(rs.getTimestamp("updated_at"));
			}
		} catch (SQLException e) {
			System.out.println("id에 해당하는 유저정보 출력 : "+e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}


	// 회원정보 수정 - 비밀번호, 닉네임, 이름, 생년월일, 성별, 이메일,
	// 휴대폰, 우편번호, 주소, 업데이트날짜 변경
	public void updateUser(UserDto dto) {
		Connection conn = db.getConnection();
		String sql = "UPDATE user SET password=?, nickname=?, name=?, birth=?, "
				+ "gender=?, email=?, phone=?, zipcode=?, address1=?, address2=?, updated_at=now() WHERE ID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPassword());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getBirth());
			pstmt.setString(5, dto.getGender());
			pstmt.setString(6, dto.getEmail());
			pstmt.setString(7, dto.getPhone());
			pstmt.setString(8, dto.getAddress1());
			pstmt.setString(9, dto.getAddress2());
			pstmt.setString(10, dto.getId());

			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("회원정보 수정 오류 : "+e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
	}

	// 이메일 인증시 유저 정보
	public UserDto getUserForEmail(String email) {
		UserDto dto = new UserDto();
		Connection conn = db.getConnection();
		String sql = "SELECT * FROM user WHERE email = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getString("birth"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setProfile_img(rs.getString("profile_img"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setUpdated_at(rs.getTimestamp("updated_at"));
			}
		} catch (SQLException e) {
			System.out.println("email에 해당하는 유저정보 출력 : "+e.getMessage());
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}

	// 로그인
	public int loginCheck(String email, String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String encryptPwd = "";
		String sql = "";

		boolean isSuccess = encrypt.encryption(password);
		if(isSuccess) {
			encryptPwd = encrypt.getPassword();
		}

		String dbPassword = ""; // db에서 꺼낸 비밀번호를 담을 변수
		int checkUser = -1;

		try {
			// 쿼리 - 먼저 입력된 아이디로 DB에서 비밀번호를 조회한다.
			sql = "select password from user where email = ?";

			conn = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) // 입력된 아이디에 해당하는 비밀번호 있을경우
			{
				dbPassword = rs.getString(1); // 비번을 변수에 넣는다.

				if (dbPassword.equals(encryptPwd)) 
					checkUser = 1; // 넘겨받은 비번과 꺼내온 비밀번호 비교. 같으면 인증성공
				else                  
					checkUser = 0; // DB의 비밀번호와 입력받은 비밀번호 다름, 인증실패

			} else {
				checkUser = -1; // 해당 아이디가 없을 경우
			}

			return checkUser;

		} catch (Exception sqle) {
			throw new RuntimeException(sqle.getMessage());
		} finally {
			try{
				db.dbClose(rs, pstmt, conn);
			}catch(Exception e){
				throw new RuntimeException(e.getMessage());
			}
		}
	} // end loginCheck()

	// 이메일에 해당하는 이름 반환
	public String getName(String email) {
		String name = "";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql = "select name from user where email = ?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			// 바인딩
			pstmt.setString(1, email);
			// 실행
			rs = pstmt.executeQuery();
			// 데이터가 있으면 비번이 맞음
			if(rs.next())
				name = rs.getString(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return name;
	}

	// 이메일에 해당하는 사용자 이름 반환
	public String getNickname(String email) {
		String name = "";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql = "select nickname from user where email = ?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			// 바인딩
			pstmt.setString(1, email);
			// 실행
			rs = pstmt.executeQuery();
			// 데이터가 있으면 비번이 맞음
			if(rs.next())
				name = rs.getString(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return name;
	}

	// 이메일 중복체크
	public boolean dupCheckEmail(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean check = true;
		String sql = "";

		conn = db.getConnection();
		sql = "select * from user where email = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if(email == null || rs.next() == true) {
				check = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return check;
	}

	// 사용자 이름 중복체크
	public boolean dupCheckNickname(String nickname) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean check = true;
		String sql = "";

		conn = db.getConnection();
		sql = "select * from user where nickname = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();

			if(nickname == null || rs.next() == true) {
				check = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return check;
	}
}
