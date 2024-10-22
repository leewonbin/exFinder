package com.exfinder.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class UserActivityDto {

	private int id;              		// user_activity 테이블의 기본 키
    private String u_id;         		// 유저 아이디
    private String c_code;       		// 통화 코드
    private Timestamp last_viewed;    	// 마지막 조회 날짜
    private int view_count;      		// 조회수
	
	public UserActivityDto() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public String getC_code() {
		return c_code;
	}

	public void setC_code(String c_code) {
		this.c_code = c_code;
	}

	public Timestamp getLast_viewed() {
		return last_viewed;
	}

	public void setLast_viewed(Timestamp last_viewed) {
		this.last_viewed = last_viewed;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public UserActivityDto(int id, String u_id, String c_code, Timestamp last_viewed, int view_count) {
		super();
		this.id = id;
		this.u_id = u_id;
		this.c_code = c_code;
		this.last_viewed = last_viewed;
		this.view_count = view_count;
	}

	@Override
	public String toString() {
		return "UserActivityDto [id=" + id + ", u_id=" + u_id + ", c_code=" + c_code + ", last_viewed=" + last_viewed
				+ ", view_count=" + view_count + "]";
	}

	
	

	
	
	

}
