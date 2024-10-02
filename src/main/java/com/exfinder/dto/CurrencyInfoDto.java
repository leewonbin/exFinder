package com.exfinder.dto;

public class CurrencyInfoDto {
	private String c_code;
	private String c_name;
	private String c_country;
	private int c_id;
	
	public CurrencyInfoDto() {
		// TODO Auto-generated constructor stub
	}
	
	public CurrencyInfoDto(String c_code, String c_name, String c_country, int c_id) {
		super();
		this.c_code = c_code;
		this.c_name = c_name;
		this.c_country = c_country;
		this.c_id = c_id;
	}

	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_country() {
		return c_country;
	}
	public void setC_country(String c_country) {
		this.c_country = c_country;
	}
	public int getC_id() {
		return c_id;
	}
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}
	
	

}
