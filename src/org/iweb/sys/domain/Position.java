package org.iweb.sys.domain;

import java.util.Date;

public class Position {
	private String uuid; //
	private String position_name; // 职务名称
	private Integer position_grade; // 职务级别
	private String position_senior; // 汇报对象
	private String position_attribute; // 职务属性
	private String position_note; // 职务描述
	private String lm_user; //
	private Date lm_time; //

	public String getPosition_senior() {
		return position_senior;
	}

	public void setPosition_senior(String position_senior) {
		this.position_senior = position_senior;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getPosition_name() {
		return position_name;
	}

	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}

	public Integer getPosition_grade() {
		return position_grade;
	}

	public void setPosition_grade(Integer position_grade) {
		this.position_grade = position_grade;
	}

	public String getPosition_attribute() {
		return position_attribute;
	}

	public void setPosition_attribute(String position_attribute) {
		this.position_attribute = position_attribute;
	}

	public String getPosition_note() {
		return position_note;
	}

	public void setPosition_note(String position_note) {
		this.position_note = position_note;
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

}
