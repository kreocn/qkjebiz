package com.qkj.sche.domain;

public class usercode {
	private Integer suuuid;// 用户id
	private Integer sduuid;//部门id
	private String user_name;// 用户名
	private String dept_code;// 部门代码
	private String cname;// 部门名称
	public Integer getSuuuid() {
		return suuuid;
	}
	public void setSuuuid(Integer suuuid) {
		this.suuuid = suuuid;
	}
	public Integer getSduuid() {
		return sduuid;
	}
	public void setSduuid(Integer sduuid) {
		this.sduuid = sduuid;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	
}
