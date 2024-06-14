package dao;

import java.sql.*;
import javax.naming.NamingException;
import util.*;

public class UserDAO {// 접근제어자 반환값 insert(매개변수){}
	/*
	 * UserDAO dao = new UserDAO(); boolean x =dao.insertboolean x
	 * =dao.insert(user);(user); signup에서 필요함
	 */
	public boolean insert(UserBean user) throws NamingException, SQLException {// 발생된 모든 예외를 throws함 try를 하지만 catch하지
																				// 않아도 됨
		Connection conn = null;
		PreparedStatement stmt = null;// String은 굳이 할 필요없은 문자열이라서 생성실패하는 경우가 없음
		try {
			String sql = "INSERT INTO user(id, password, name, phone, email) VALUES(?, ?, ?, ?, ?)";

			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, user.getId());
			stmt.setString(2, user.getPs());
			stmt.setString(3, user.getName());
			stmt.setString(4, user.getPhone());
			stmt.setString(5, user.getEmail());

			int count = stmt.executeUpdate();
			return (count == 1) ? true : false;

		} finally {
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
	}

	public boolean exists(String uid) throws NamingException, SQLException {// 아이디 중복여부 확인할때 사용 녹음참고 (11/08 1:50:00경)
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT id FROM user WHERE id = ?";

			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, uid);

			rs = stmt.executeQuery();
			return rs.next();

		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
	}

	public boolean delete(String uid) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "DELETE FROM user WHERE id = ?";

			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, uid);

			int count = stmt.executeUpdate();
			return (count == 1) ? true : false;

		} finally {
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
	}

	public int login(String uid, String upass) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT id, password FROM user WHERE id = ?";

			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, uid);

			rs = stmt.executeQuery();
			if (!rs.next())
				return 1;// 회원가입하세요
			if (!upass.equals(rs.getString("password")))
				return 2;

			return 0;

		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
	}

	// 회원정보를 수정하기 위해 기존의 정보를 표시
	public UserBean getUser(String uid) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		UserBean user = null;

		try {
			String sql = "select * from user where id = ?";

			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, uid);

			rs = stmt.executeQuery();

			if (rs.next()) { // 사용자가 로그인한 상태로 들어오기에 절대 작동할 일 없음
				user = new UserBean();
				stmt.setString(1, user.getId());
				user.setId(rs.getString("id"));
				user.setPs(rs.getString("password"));
				user.setName(rs.getString("name"));
				user.setPhone(rs.getString("phone"));
				user.setEmail(rs.getString("email"));
				user.setPoint(rs.getInt("point"));
				user.setGrade(rs.getInt("grade"));
			}
			return user;

		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
	}

	// 회원의 정보수정
	public boolean update(UserBean user) throws NamingException, SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			String sql = "update user set password = ?, name = ?, phone = ?, email = ? where id = ? ";

			con = ConnectionPool.get();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, user.getPs());
			stmt.setString(2, user.getName());
			stmt.setString(3, user.getPhone());
			stmt.setString(4, user.getEmail());
			stmt.setString(5, user.getId());

			int count = stmt.executeUpdate();
			return (count == 1) ? true : false;
		} finally {
			if (stmt != null)
				stmt.close();
			if (con != null)
				con.close();
		}

	}
	
	// 포인트 증가
	public boolean addpoint(String uid, int points) throws NamingException, SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			String sql = "update user set point=? where id = ? ";

			con = ConnectionPool.get();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, points);// 여기서 +-하면 +-됨 다만 변경시킬값이 경우가 다양해서 여기서 변경안함
			stmt.setString(2, uid);

			int count = stmt.executeUpdate();
			return (count == 1) ? true : false;
		} finally {
			if (stmt != null)
				stmt.close();
			if (con != null)
				con.close();
		}

	}
	
	public boolean updateGrade(String uid) throws SQLException, NamingException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    int grade;

	    try {
	        conn = ConnectionPool.get();

	        // 현재 포인트를 가져오는 쿼리
	        String queryPoint = "SELECT point FROM user WHERE id = ?";
	        stmt = conn.prepareStatement(queryPoint);
	        stmt.setString(1, uid);
	        rs = stmt.executeQuery();

	        if (!rs.next()) {
	            // 사용자가 존재하지 않으면 false 반환
	            return false;
	        }

	        int point = rs.getInt("point");

	        // 포인트에 따른 등급 계산
	        if (point >= 200) {
	            grade = 3;
	        } else if (point >= 100) {
	            grade = 2;
	        } else if (point >= 1) {
	            grade = 1;
	        } else {
	            grade = 0;
	        }

	        if (stmt != null) stmt.close();
	        // 데이터베이스에 grade 업데이트
	        String updateGrade = "UPDATE user SET grade = ? WHERE id = ?";
	        stmt = conn.prepareStatement(updateGrade);
	        stmt.setInt(1, grade);
	        stmt.setString(2, uid);

	        int affectedRows = stmt.executeUpdate();
	        return affectedRows == 1;

	    } finally {
	        if (rs != null) rs.close();
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	    }
	}



}
