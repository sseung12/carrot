package com.carrot.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import javax.naming.NamingException;
import javax.naming.*;

import jsp.util.DBConnection;

public class MemberDAO {
	

	private static MemberDAO instance;
	
	
	public static MemberDAO getInstance() {
		if(instance == null) {
			instance = new MemberDAO();
		}
		
		return instance;
	}
	

	
	// String -> DATE로 변경하는 메서
	public Date StringToDate(MemberVO vo) {
		String year = vo.getBirthyy();
		String month = vo.getBirthmm();
		String day = vo.getBirthdd();
		
		Date birthday = Date.valueOf(year+"-"+month+"-"+day);
		return birthday;
	}
	
	//회원 정보 저장 메서드
	public void insertMember(MemberVO vo) throws SQLException, NamingException, ClassNotFoundException  {
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into member(id,pwd,phone_num,name,birth) values(?,?,?,?,?)");
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
		
			conn = DBConnection.getConnection();
			System.out.println(conn);
			conn.setAutoCommit(false);
		
		pstmt = (PreparedStatement) conn.prepareStatement(sql.toString());
		pstmt.setString(1,vo.getId());
		pstmt.setString(2,vo.getPwd());
		pstmt.setString(3,vo.getPhone_num());
		pstmt.setString(4,vo.getName());
		pstmt.setDate(5,StringToDate(vo));
		
		pstmt.executeUpdate(); 
		conn.commit();
		
		}catch(NamingException | SQLException sqle) {
			System.out.println("오류");
			System.out.println(sqle);
			conn.rollback();
			throw new RuntimeException(sqle.getMessage());
		}finally {
			try {
				if(pstmt!= null) {pstmt.close(); pstmt = null;}
				if(conn!=null) {conn.close(); conn = null;}
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		
		
		
	}
	
}
