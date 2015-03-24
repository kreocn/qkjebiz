package com.qkjsys.ebiz.domain;

import java.util.Date;

public class GoodsType {
	private Integer uuid;// (int) 主键
	private String type_name;// (varchar) 类型名称
	private String type_group;// (varchar) 属性的可分组,用','隔开
	private Integer status;// (int) 状态 0 正常 1 停用
	private String lm_user;// (varchar) 0
	private Date lm_time;// (datetime) 0

	// 以下为非数据库字段
	private Integer item_num;
	private String lm_user_name;

	public Integer getItem_num() {
		return item_num;
	}

	public void setItem_num(Integer item_num) {
		this.item_num = item_num;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getType_name() {
		return type_name;
	}

	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	public String getType_group() {
		return type_group;
	}

	public void setType_group(String type_group) {
		this.type_group = type_group;
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
	
}
