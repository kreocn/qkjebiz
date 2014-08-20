package org.iweb.sys.domain;

import java.util.Date;

public class Department {
	private String uuid;
	private String dept_code;
	private String dept_ename;
	private String dept_cname;
	private String descriptions;
	private String lm_user;
	private Date lm_time;
	private String parent_dept;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getDept_ename() {
		return dept_ename;
	}

	public void setDept_ename(String dept_ename) {
		this.dept_ename = dept_ename;
	}

	public String getDept_cname() {
		return dept_cname;
	}

	public void setDept_cname(String dept_cname) {
		this.dept_cname = dept_cname;
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

	public String getParent_dept() {
		return parent_dept;
	}

	public void setParent_dept(String parent_dept) {
		this.parent_dept = parent_dept;
	}

}
