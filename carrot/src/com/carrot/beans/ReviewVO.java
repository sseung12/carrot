package com.carrot.beans;

import java.sql.Date;

public class ReviewVO {

	
	private int shoes_id;
	private int member_id;
	private String title;
	private String content;
	private String name;
	private String star;
	private String img;
	private String shoes_size;
	private Date registdate;
	
	
	
	
	public int getShoes_id() {
		return shoes_id;
	}
	public void setShoes_id(int shoes_id) {
		this.shoes_id = shoes_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public Date getRegistdate() {
		return registdate;
	}
	public void setRegistdate(Date registdate) {
		this.registdate = registdate;
	}
	public String getShoes_size() {
		return shoes_size;
	}
	public void setShoes_size(String shoes_size) {
		this.shoes_size = shoes_size;
	}
	
	
}
