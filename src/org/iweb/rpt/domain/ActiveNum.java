package org.iweb.rpt.domain;

import java.util.Date;

public class ActiveNum {
	private Integer uuid;
	private String apply_dept;
	private String dept_cname;
	private Integer cout;
	private String atype;
	private Date adate;
	private String acode;
	private String merger;
	
	public String getMerger() {
		return merger;
	}
	public void setMerger(String merger) {
		this.merger = merger;
	}
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}
	public String getApply_dept() {
		return apply_dept;
	}
	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
	}
	public String getDept_cname() {
		return dept_cname;
	}
	public void setDept_cname(String dept_cname) {
		this.dept_cname = dept_cname;
	}
	public Integer getCout() {
		return cout;
	}
	public void setCout(Integer cout) {
		this.cout = cout;
	}
	public String getAtype() {
		return atype;
	}
	public void setAtype(String atype) {
		this.atype = atype;
	}
	public Date getAdate() {
		return adate;
	}
	public void setAdate(Date adate) {
		this.adate = adate;
	}
	public String getAcode() {
		return acode;
	}
	public void setAcode(String acode) {
		this.acode = acode;
	}
	

}
