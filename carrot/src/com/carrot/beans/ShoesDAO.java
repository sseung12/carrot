package com.carrot.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import jsp.util.DBConnection;


public class ShoesDAO {
	
	
	
	private static ShoesDAO instance;
	
	
	
	public static ShoesDAO getInstance() {
		if(instance== null) {
			instance = new ShoesDAO();
		}
		return instance;
	}
	
	public boolean checkInputCount(String shoes_id, String size,int count) throws SQLException,NamingException,ClassNotFoundException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		size = "s"+size;
		int size_count=0;
		StringBuffer sql = new StringBuffer();
		sql.append("select ? from shoes_size where shoes_id = ?");
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt =(PreparedStatement)conn.prepareStatement(sql.toString());
			pstmt.setString(1,size);
			pstmt.setString(2,shoes_id);
			rs =pstmt.executeQuery();
			rs.next();
			size_count = rs.getInt(size);
		}catch(NamingException | SQLException sqle) {
			System.out.println(sqle);
		}finally {
			try {
			if(pstmt!= null) {pstmt.close(); pstmt = null;}
			if(conn!=null) {conn.close(); conn = null;}
			if(rs!=null) {rs.close(); rs =null;}
		}catch(Exception e) {
			throw new RuntimeException(e.getMessage());
		
		}
		 
	}
		return size_count <count ? false : true;
		
	}
	public int signReview(ReviewVO vo) throws SQLException,NamingException,ClassNotFoundException{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int result =0;
		sql.append("insert into shoes_review(shoes_id,member_id,title,content,name,img,shoes_size,star) values(?, ?, ?, ?, ?, ?, ?, ?)");
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = (PreparedStatement)conn.prepareStatement(sql.toString());
			pstmt.setInt(1,vo.getShoes_id());
			pstmt.setInt(2,vo.getMember_id());
			pstmt.setString(3,vo.getTitle());
			pstmt.setString(4,vo.getContent());
			pstmt.setString(5,vo.getName());
			pstmt.setString(6,vo.getImg());
			pstmt.setString(7,vo.getShoes_size());
			pstmt.setString(8,vo.getStar());
			result =pstmt.executeUpdate();
			conn.commit();
			
		}catch(Exception sqle) {
			System.out.println(sqle);
		}finally {
			try {
				if(pstmt!= null) {pstmt.close(); pstmt = null;}
				if(conn!=null) {conn.close(); conn = null;}
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return result;
	}
	public ArrayList<ReviewVO> getReviewList(String id) throws SQLException,NamingException,ClassNotFoundException{
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		StringBuffer sql = new StringBuffer();
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		sql.append("select * from shoes_review where shoes_id = ? ");
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = (PreparedStatement)conn.prepareStatement(sql.toString());
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewVO vo = new ReviewVO();
				vo.setMember_id(rs.getInt("member_id"));
				vo.setShoes_id(rs.getInt("shoes_id"));
				vo.setContent(rs.getString("content"));
				vo.setTitle(rs.getString("title"));
				vo.setStar(rs.getString("star"));
				vo.setName(rs.getString("name"));
				vo.setShoes_size(rs.getString("shoes_size"));
				vo.setImg(rs.getString("img"));
				vo.setRegistdate(rs.getDate("registdate"));
				list.add(vo);
			}
			
		}catch(NamingException | SQLException sqle) {
			System.out.println(sqle);
		}finally {
			try {
				if(pstmt!= null) {pstmt.close(); pstmt = null;}
				if(conn!=null) {conn.close(); conn = null;}
				if(rs!=null) {rs.close(); rs =null;}
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return list;
	}
	public ArrayList<Shoes_size> getSizeList(String id) throws SQLException,NamingException,ClassNotFoundException{
		
		ArrayList<Shoes_size> list = new ArrayList<Shoes_size>();
		
//		String[] list = new String[12];
		StringBuffer sql = new StringBuffer();
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		sql.append("select * from shoes_size where shoes_id = ?");
		Shoes_size vo = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = (PreparedStatement)conn.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs =pstmt.executeQuery();
			rs.next();
			for(int i=225;i<=280;i+=5) {
				vo = new Shoes_size();
				vo.setName(Integer.toString(i));
				vo.setCount(rs.getInt("s"+Integer.toString(i)));
				list.add(vo);
			}
			
			
		}catch(NamingException | SQLException sqle) {
			System.out.println(sqle);
		}finally {
			try {
				if(pstmt!= null) {pstmt.close(); pstmt = null;}
				if(conn!=null) {conn.close(); conn = null;}
				if(rs!=null) {rs.close(); rs =null;}
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		
		
		return list;
		
	}
	public ShoesVO getShoesOne(String id) throws SQLException,NamingException,ClassNotFoundException {
		
		ShoesVO result = new ShoesVO();
		StringBuffer sql  = new StringBuffer();
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt =null;
		sql.append("select * from shoes where shoes_id = ? ");
		try {
			conn =DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = (PreparedStatement)conn.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			rs.next();
			result.setShoes_id(rs.getInt("shoes_id"));
			result.setName(rs.getString("name"));
			result.setPrice(rs.getString("price"));
			result.setType(rs.getString("type"));
			result.setImg(rs.getString("img"));
			
			
		}catch(NamingException | SQLException sqle) {
			System.out.println(sqle);
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
	public ArrayList<ShoesVO> getShoesList() throws SQLException,NamingException,ClassNotFoundException {
		
		ArrayList<ShoesVO> list = new ArrayList<ShoesVO>();
		
		StringBuffer sql= new StringBuffer();
		sql.append("select * from shoes");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int i =0;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			pstmt = (PreparedStatement)conn.prepareStatement(sql.toString());
			rs =pstmt.executeQuery();
			
			while(rs.next()) {
				ShoesVO vo = new ShoesVO();
				vo.setShoes_id(rs.getInt("shoes_id"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getString("price"));
				vo.setType(rs.getString("type"));
				vo.setImg(rs.getString("img"));
				
				list.add(vo);
			}
		}catch(NamingException | SQLException sqle) {
			System.out.println(sqle);
			
		}finally {
			try {
				if(pstmt!= null) {pstmt.close(); pstmt = null;}
				if(conn!=null) {conn.close(); conn = null;}
				if(rs!=null) {rs.close(); rs =null;}
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		
		
		
		return list; 
	}
	
	
}
