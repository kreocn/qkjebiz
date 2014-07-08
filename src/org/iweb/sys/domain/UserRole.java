package org.iweb.sys.domain;

import java.util.Date;

public class UserRole {
	private String uuid;
	private Integer role_type; // 0用户角色 1系统角色
	private String role_name;
	private Integer role_rank;
	private String descriptions;
	private String lm_user;
	private Date lm_time;

	public Integer getRole_rank() {
		return role_rank;
	}

	public void setRole_rank(Integer role_rank) {
		this.role_rank = role_rank;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Integer getRole_type() {
		return role_type;
	}

	public void setRole_type(Integer role_type) {
		this.role_type = role_type;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
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
