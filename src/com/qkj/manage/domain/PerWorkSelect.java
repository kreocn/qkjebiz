package com.qkj.manage.domain;

import java.util.Date;

public class PerWorkSelect {
	private Integer uuid;
	private String perUser;
	private String roles;
	private String table_name;// 表名
	private String table_field;// 查询的字段
	private String table_condition;// 查询条件
	private String lm_user;
	private Date lm_time;
	private String remark;
	private Integer isValid;

	public String getPerUser() {
		return perUser;
	}

	public void setPerUser(String perUser) {
		this.perUser = perUser;
	}

	public PerWorkSelect() {

	}

	public PerWorkSelect(String table_name, String table_field, String table_condition) {
		this.setTable_name(table_name);
		this.setTable_field(table_field);
		this.setTable_condition(table_condition);

	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
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

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	public String getTable_field() {
		return table_field;
	}

	public void setTable_field(String table_field) {
		this.table_field = table_field;
	}

	public String getTable_condition() {
		return table_condition;
	}

	public void setTable_condition(String table_condition) {
		this.table_condition = table_condition;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

}
