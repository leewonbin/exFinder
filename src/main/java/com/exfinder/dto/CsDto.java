package com.exfinder.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CsDto {

	private int cs_id; 				// cs 번호
	private String cs_title; 		// cs 제목 (질문)
	private String cs_content; 		// cs 내용 (답변)
	private String admin_id; 		// 관리자 id
	private String cs_del = "N"; 	// cs 삭제여부

	public CsDto() {
	}

	public int getCs_id() {
		return cs_id;
	}

	public void setCs_id(int cs_id) {
		this.cs_id = cs_id;
	}

	public String getCs_title() {
		return cs_title;
	}

	public void setCs_title(String cs_title) {
		this.cs_title = cs_title;
	}

	public String getCs_content() {
		return cs_content;
	}

	public void setCs_content(String cs_content) {
		this.cs_content = cs_content;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getCs_del() {
		return cs_del;
	}

	public void setCs_del(String cs_del) {
		this.cs_del = cs_del;
	}

	@Override
	public String toString() {
		return "CsDto [cs_id=" + cs_id + ", cs_title=" + cs_title + ", cs_content=" + cs_content + ", admin_id="
				+ admin_id + ", cs_del=" + cs_del + "]";
	}

	public CsDto(int cs_id, String cs_title, String cs_content, String admin_id, String cs_del) {
		super();
		this.cs_id = cs_id;
		this.cs_title = cs_title;
		this.cs_content = cs_content;
		this.admin_id = admin_id;
		this.cs_del = cs_del;
	}

}
