package com.exfinder.dto;



public class CsDto {

	private int cs_id; 				// cs 번호
	private String cs_title; 		// cs 제목 (질문)
	private String cs_content; 		// cs 내용 (답변)
	private String u_id; 			// 관리자 id
	private int cs_state = 1; 	// cs 활

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

	

	public int getcs_state() {
		return cs_state;
	}

	public void setcs_state(int cs_state) {
		this.cs_state = cs_state;
	}

	@Override
	public String toString() {
		return "CsDto [cs_id=" + cs_id + ", cs_title=" + cs_title + ", cs_content=" + cs_content + ", admin_id="
				+ u_id + ", cs_state=" + cs_state + "]";
	}

	public CsDto(int cs_id, String cs_title, String cs_content, String admin_id, int cs_state) {
		super();
		this.cs_id = cs_id;
		this.cs_title = cs_title;
		this.cs_content = cs_content;
		this.u_id = admin_id;
		this.cs_state = cs_state;
	}

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

}
