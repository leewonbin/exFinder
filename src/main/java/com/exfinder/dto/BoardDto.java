package com.exfinder.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class BoardDto {
    
	private int b_id;				//게시판 번호
	private String b_title;			//게시판 제목
	private String b_content;		//게시판 내용
	private String b_category;		//게시판 카테고리
	private int b_view;				//조회수
	private String u_id;			//유저 아이디(작성자)
	private String b_del="N";		//게시판 삭제 여부

	public BoardDto() {}
	
	public BoardDto(int b_id, String b_title, String b_content, String b_category, int b_view, String u_id,
			String b_del) {
		super();
		this.b_id = b_id;
		this.b_title = b_title;
		this.b_content = b_content;
		this.b_category = b_category;
		this.b_view = b_view;
		this.u_id = u_id;
		this.b_del = b_del;
	}

	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public int getB_view() {
		return b_view;
	}
	public void setB_view(int b_view) {
		this.b_view = b_view;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getB_del() {
		return b_del;
	}
	public void setB_del(String b_del) {
		this.b_del = b_del;
	}
	
	
	@Override
	public String toString() {
		return "BoardDto [b_id=" + b_id + ", b_title=" + b_title + ", b_content=" + b_content + ", b_category="
				+ b_category + ", b_view=" + b_view + ", u_id=" + u_id + ", b_del=" + b_del + "]";
	}
	
}