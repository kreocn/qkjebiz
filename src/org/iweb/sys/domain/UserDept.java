package org.iweb.sys.domain;

import java.util.Date;

public class UserDept {
	private Integer uuid;
	private String user_id;
	private String dept_code;
	private String position;
	private Integer subover;
	private String roles;
	private String prvgs;
	private Date lm_time;
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Integer getSubover() {
		return subover;
	}
	public void setSubover(Integer subover) {
		this.subover = subover;
	}
	public String getRoles() {
		return roles;
	}
	public void setRoles(String roles) {
		this.roles = roles;
	}
	public String getPrvgs() {
		return prvgs;
	}
	public void setPrvgs(String prvgs) {
		this.prvgs = prvgs;
	}
	public Date getLm_time() {
		return lm_time;
	}
	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}
	
}
