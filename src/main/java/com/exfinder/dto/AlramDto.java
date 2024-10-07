package com.exfinder.dto;

public class AlramDto {
	private int a_id;
	private String u_id;
	private String c_code;
	private String create_date;
	private double target_exchange;
	private double deal_bas_r;
	private String checked;

	public AlramDto() {
		// TODO Auto-generated constructor stub
	}

	public AlramDto(int a_id, String u_id, String c_code, String create_date, double target_exchange, double deal_bas_r,
			String checked) {
		super();
		this.a_id = a_id;
		this.u_id = u_id;
		this.c_code = c_code;
		this.create_date = create_date;
		this.target_exchange = target_exchange;
		this.deal_bas_r = deal_bas_r;
		this.checked = checked;
	}
	

	public double getDeal_bas_r() {
		return deal_bas_r;
	}

	public void setDeal_bas_r(double deal_bas_r) {
		this.deal_bas_r = deal_bas_r;
	}

	public void setTarget_exchange(double target_exchange) {
		this.target_exchange = target_exchange;
	}
	
	public double getTarget_exchange() {
		return target_exchange;
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

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

}
