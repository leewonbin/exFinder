package com.exfinder.dto;

import java.time.LocalDateTime;

public class AlramDto {
	private int a_id;
	private String u_id;
	private String c_code;
	private String create_date;
	private int target_exchange;
	private String checked;

	public AlramDto() {
		// TODO Auto-generated constructor stub
	}

	public AlramDto(int a_id, String u_id, String c_code, String create_date, int target_exchange, String checked) {
		super();
		this.a_id = a_id;
		this.u_id = u_id;
		this.c_code = c_code;
		this.create_date = create_date;
		this.target_exchange = target_exchange;
		this.checked = checked;
	}

	public String getC_code() {
		return c_code;
	}

	public void setC_code(String c_code) {
		this.c_code = c_code;
	}

	public int getA_id() {
		return a_id;
	}

	public void setA_id(int a_id) {
		this.a_id = a_id;
	}

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public int getTarget_exchange() {
		return target_exchange;
	}

	public void setTarget_exchange(int target_exchange) {
		this.target_exchange = target_exchange;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

}
