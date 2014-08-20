package org.iweb.fileupload.domain;

import java.util.Date;

public class UploadClass {
	private String uuid;
	private String c_id;
	private String c_name;
	private String c_dir;
	private Integer max_size;
	private String descriptions;
	private String union_type;
	private Integer union_num;
	private String lm_user;
	private Date lm_time;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getC_id() {
		return c_id;
	}

	public void setC_id(String c_id) {
		this.c_id = c_id;
	}

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	public String getC_dir() {
		return c_dir;
	}

	public void setC_dir(String c_dir) {
		this.c_dir = c_dir;
	}

	public Integer getMax_size() {
		return max_size;
	}

	public void setMax_size(Integer max_size) {
		this.max_size = max_size;
	}

	public String getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}

	public String getUnion_type() {
		return union_type;
	}

	public void setUnion_type(String union_type) {
		this.union_type = union_type;
	}

	public Integer getUnion_num() {
		return union_num;
	}

	public void setUnion_num(Integer union_num) {
		this.union_num = union_num;
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
