package com.qkjsys.ebiz.domain;

import java.util.Date;

public class Ware {
	private Integer uuid;// (int) 0
	private Integer ware_class;// (int) 仓库分类 0普通库 1藏酒库 (其他分类待定义)
	private String ware_name;// (varchar) 仓库名称(简称)
	private String address;// (varchar) 仓库地点
	private String map_data;// (varchar) 在地图的数据,以地图类型为准
	private String short_note;// (text) 简短描述,在不使用图片时使用
	private String note;// (text) 详细描述
	private String lm_user;// (varchar) 最后修改人
	private Date lm_time;// (datetime) 最后修改时间
	
	private String bug;
	private String dept_code;
	private String prvg;
	private String son;
	private String username;

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getWare_class() {
		return ware_class;
	}

	public void setWare_class(Integer ware_class) {
		this.ware_class = ware_class;
	}

	public String getWare_name() {
		return ware_name;
	}

	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMap_data() {
		return map_data;
	}

	public void setMap_data(String map_data) {
		this.map_data = map_data;
	}

	public String getShort_note() {
		return short_note;
	}

	public void setShort_note(String short_note) {
		this.short_note = short_note;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
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

	public String getBug() {
		return bug;
	}

	public void setBug(String bug) {
		this.bug = bug;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getPrvg() {
		return prvg;
	}

	public void setPrvg(String prvg) {
		this.prvg = prvg;
	}

	public String getSon() {
		return son;
	}

	public void setSon(String son) {
		this.son = son;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	

}
