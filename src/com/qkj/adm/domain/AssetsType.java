package com.qkj.adm.domain;

import java.util.Date;

public class AssetsType {
	private Integer uuid;// (int)
	private String typea;// (varchar)资产种类
	private Integer parent_type;// (varchar)资产类别
	private Date lm_time;// (timestamp)修改时间
	private String lm_user;// (varchar)修改人

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getTypea() {
		return typea;
	}

	public void setTypea(String typea) {
		this.typea = typea;
	}

	public Date getLm_time() {
		return lm_time;
	}

	public void setLm_time(Date lm_time) {
		this.lm_time = lm_time;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
	}

	public Integer getParent_type() {
		return parent_type;
	}

	public void setParent_type(Integer parent_type) {
		this.parent_type = parent_type;
	}

}
