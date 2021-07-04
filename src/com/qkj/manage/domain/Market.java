package com.qkj.manage.domain;

import java.util.Date;

public class Market {
	private Integer uuid;// (int)主键自增
	private Double abs;
	private Double yaxis;
	private String name;
	private String area;
	private String lead;
	private String address;
	private String people;
	private String phone;
	private String img;
	private String lm_user;
	private Date lm_time;
	private String deptcode;
	//非数据库字段
	private String lm_user_name;
	
	
	public String getDeptcode() {
		return deptcode;
	}
	public void setDeptcode(String deptcode) {
		this.deptcode = deptcode;
	}
	public String getLm_user() {
		return lm_user;
	}
	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}
	
	public Date getLm_time() {
		return lm_time;
	}
	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}
	public String getLm_user_name() {
		return lm_user_name;
	}
	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}
	public Double getAbs() {
		return abs;
	}
	public void setAbs(Double abs) {
		this.abs = abs;
	}
	public Double getYaxis() {
		return yaxis;
	}
	public void setYaxis(Double yaxis) {
		this.yaxis = yaxis;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getLead() {
		return lead;
	}
	public void setLead(String lead) {
		this.lead = lead;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPeople() {
		return people;
	}
	public void setPeople(String people) {
		this.people = people;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	

}
