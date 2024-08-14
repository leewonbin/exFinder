package com.exfinder.dto;

import java.time.LocalDate;

public class UserDto {
	private String u_id;
	private String u_pw;
	private String u_nickname;
	private String u_name;
	private String u_gender;
	private LocalDate u_birthday;
	private String u_email;
	private String u_phoneNumber;
	private String u_address;
	private LocalDate u_joinDate;
	private String u_del;
	
	public UserDto() {}
	
	public UserDto(String u_id, String u_pw, String u_nickname, String u_name, String u_gender, LocalDate u_birthday,
			String u_email, String u_phoneNumber, String u_address, LocalDate u_joinDate, String u_del) {
		super();
		this.u_id = u_id;
		this.u_pw = u_pw;
		this.u_nickname = u_nickname;
		this.u_name = u_name;
		this.u_gender = u_gender;
		this.u_birthday = u_birthday;
		this.u_email = u_email;
		this.u_phoneNumber = u_phoneNumber;
		this.u_address = u_address;
		this.u_joinDate = u_joinDate;
		this.u_del = u_del;
	}

	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pw() {
		return u_pw;
	}
	public void setU_pw(String u_pw) {
		this.u_pw = u_pw;
	}
	public String getU_nickname() {
		return u_nickname;
	}
	public void setU_nickname(String u_nickname) {
		this.u_nickname = u_nickname;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_gender() {
		return u_gender;
	}
	public void setU_gender(String u_gender) {
		this.u_gender = u_gender;
	}
	public LocalDate getU_birthday() {
		return u_birthday;
	}
	public void setU_birthday(LocalDate u_birthday) {
		this.u_birthday = u_birthday;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getU_phoneNumber() {
		return u_phoneNumber;
	}
	public void setU_phoneNumber(String u_phoneNumber) {
		this.u_phoneNumber = u_phoneNumber;
	}
	public String getU_address() {
		return u_address;
	}
	public void setU_address(String u_address) {
		this.u_address = u_address;
	}
	public LocalDate getU_joinDate() {
		return u_joinDate;
	}
	public void setU_joinDate(LocalDate u_joinDate) {
		this.u_joinDate = u_joinDate;
	}
	public String getU_del() {
		return u_del;
	}
	public void setU_del(String u_del) {
		this.u_del = u_del;
	}

	@Override
	public String toString() {
		return "UserDto [u_id=" + u_id + ", u_pw=" + u_pw + ", u_nickname=" + u_nickname + ", u_name=" + u_name
				+ ", u_gender=" + u_gender + ", u_birthday=" + u_birthday + ", u_email=" + u_email + ", u_phoneNumber="
				+ u_phoneNumber + ", u_address=" + u_address + ", u_joinDate=" + u_joinDate + ", u_del=" + u_del + "]";
	}
}
