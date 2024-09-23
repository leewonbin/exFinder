package com.exfinder.dto;

public class NotificationDto {
	private int n_id;
	private String u_id;
	private String c_code;
	private double target_exchange;
	
	public NotificationDto() {
		// TODO Auto-generated constructor stub
	}
	
	public NotificationDto(int n_id, String u_id, String c_code, double target_exchange) {
		super();
		this.n_id = n_id;
		this.u_id = u_id;
		this.c_code = c_code;
		this.target_exchange = target_exchange;
	}

	public int getN_id() {
		return n_id;
	}
	public void setN_id(int n_id) {
		this.n_id = n_id;
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
	public double getTarget_exchange() {
		return target_exchange;
	}
	public void setTarget_exchange(double target_exchange) {
		this.target_exchange = target_exchange;
	}
	
	
	
}
