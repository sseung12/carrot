package com.carrot.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.sql.Date;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.management.RuntimeErrorException;
import javax.naming.*;
import jsp.util.DBConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.File;

public class MemberDAO {
	

	private static MemberDAO instance;
	
	
	public static MemberDAO getInstance() {
		if(instance == null) {
			instance = new MemberDAO();
		}
		
		return instance;
	}
	public void uploadImg(HttpServletRequest request) {
		
		MultipartRequest multi = null;
		
		// 파일의 크기 제한 // 100mb 크기제한
		int sizeLimit = 100 * 1024 * 1024;
		
		//파일 저장위치 절대경로와 상대경로
		String savePath = "/Users/seungsu/dev/java/carrot/carrot/WebContent/img";
		
		//파일 이름 변수
		String fileName1 = null;
		
		//파일 타입 변수
		String fileType ="";
		
		try {
			// multi 객체를 생성하면서 파일을 해당 경로에 업로드 한다.
			// 마지막 인자를 중복되는 이름이 존재할 경우 뒤에 1을 붙여서 저장하는 정책이다.
			
			multi = new MultipartRequest(request,savePath,sizeLimit,"utf-8", new DefaultFileRenamePolicy());
			
			// request.getParameter 대신에 multi.getParameter로 값을 받을 수 있다.
			int id = Integer.parseInt(multi.getParameter("id"));
			
			// 첨부 파일의 이름을 얻어낸다.
			Enumeration<?> files = multi.getFileNames();
			
			String file1 = (String)files.nextElement();
			
			System.out.println("저장위치 : "+ file1);
			System.out.println(savePath);
			
			//정책을 하고 난 다음의 이름값을 가져온다. 중복되는 파일이 있다면 뒤에 1,2,3,4..을 붙인 이름을 할당한다.
			fileName1 = multi.getFilesystemName(file1);
			
			//파일 타입 가져오기
			fileType = multi.getContentType(file1);
			System.out.println("파일 타입 : "+fileType);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	// 아이디 중복 체크 
	
	public int checkId(String id) throws SQLException, NamingException, ClassNotFoundException{
		
		int result;
		String sql; 
		sql="select count(*) from member where id = ?";
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			rs.next();
			result = Integer.parseInt(rs.getString(1)); 
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
				if(rs!=null) {rs.close(); rs =null;}
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		System.out.println(result);
		return result;
	}
	
	// 비밀번호 해쉬화
	public String hashCode(String pwd) throws NoSuchAlgorithmException  {
		String result;
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(pwd.getBytes());
		byte byteData[] = md.digest();
		
		StringBuffer sb = new StringBuffer();
		
		for(int i =0; i<byteData.length;i++) {
			sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
		}
		result = sb.toString();
		return result;
		
	}
	
	//로그인
	public MemberVO login(String id,String pwd )throws SQLException,NamingException,ClassNotFoundException,NoSuchAlgorithmException{
		MemberVO result = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select * from member where id=? and pwd= ?");
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = (PreparedStatement)conn.prepareStatement(sql.toString());
			pstmt.setString(1,id);
			pstmt.setString(2, hashCode(pwd));
			rs =pstmt.executeQuery();
			while(rs.next()) {
			result = new MemberVO();
			result.setMember_id(rs.getString("member_id"));
			result.setId(rs.getString("id"));
			result.setPwd(rs.getString("pwd"));
			result.setName(rs.getString("name"));
//			result.setPhone_num("phone_num");
//			result.setBirth(rs.getDate("birth"));
//			result.setTime(rs.getDate("time"));
//			result.setEmail(rs.getString("email"));
			}
			
			conn.commit();
		}catch(NamingException | SQLException sqle){
			System.out.println(sqle);
			conn.rollback();
			throw new RuntimeException(sqle.getMessage());
		}finally {
			try {
				if(pstmt!= null) {pstmt.close(); pstmt = null;}
				if(conn!=null) {conn.close(); conn = null;}
				if(rs!=null) {rs.close(); rs =null;}
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return result;
	}
	
	
	// String -> DATE로 변경하는 메서
	public Date StringToDate(MemberVO vo) {
		String year = vo.getBirthyy();
		String month = vo.getBirthmm();
		String day = vo.getBirthdd();
		Date birthday = Date.valueOf(year+"-"+month+"-"+day);
		return birthday;
	}

	//test 메서드
	public void insertTest(TestVO vo) throws SQLException, NamingException,ClassNotFoundException{
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into test(id,pwd) values(?,?)");
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = (PreparedStatement)conn.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getId());
			pstmt.setString(2,vo.getPwd());
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
	
	//회원 정보 저장 메서드
	public void insertMember(MemberVO vo) throws Exception  {
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into member(id,pwd,phone_num,name,birth) values(?,?,?,?,?)");
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
		
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
		
		pstmt = (PreparedStatement) conn.prepareStatement(sql.toString());
		pstmt.setString(1,vo.getId());
		pstmt.setString(2,hashCode(vo.getPwd()));
		pstmt.setString(3,vo.getPhone_num());
		pstmt.setString(4,vo.getName());
		if(vo.getBirthyy()!=null || vo.getBirthdd()!=null) {
		pstmt.setDate(5,StringToDate(vo));
		}
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
