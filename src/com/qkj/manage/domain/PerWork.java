package com.qkj.manage.domain;

public class PerWork {
	private Integer perUuid;
	private String ptype;
	private String title;
	private String apply_user_name;
	private String apply_dept;
	private String nameSpace;
	private String upaction;
	private String upUuid;

	public String getNameSpace() {
		return nameSpace;
	}

	public void setNameSpace(String nameSpace) {
		this.nameSpace = nameSpace;
	}

	public String getUpaction() {
		return upaction;
	}

	public void setUpaction(String upaction) {
		this.upaction = upaction;
	}

	public String getUpUuid() {
		return upUuid;
	}

	public void setUpUuid(String upUuid) {
		this.upUuid = upUuid;
	}

	public String getApply_dept() {
		return apply_dept;
	}

	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
	}

	public Integer getPerUuid() {
		return perUuid;
	}

	public void setPerUuid(Integer perUuid) {
		this.perUuid = perUuid;
	}

	public String getPtype() {
		return ptype;
	}

	public void setPtype(String ptype) {
		this.ptype = ptype;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getApply_user_name() {
		return apply_user_name;
	}

	public void setApply_user_name(String apply_user_name) {
		this.apply_user_name = apply_user_name;
	}

}
