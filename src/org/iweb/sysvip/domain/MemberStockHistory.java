package org.iweb.sysvip.domain;

import java.util.*;

public class MemberStockHistory {
	private Integer uuid;// (int)
	private String up_user;// (varchar)上传人
	private String up_path;// (int)上传路径
	private String upIp;// (int)ip地址
	private Date up_time;// (datetime)修改时间
	public Integer getUuid() {
		return uuid;
	}
	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}
	public String getUp_user() {
		return up_user;
	}
	public void setUp_user(String up_user) {
		this.up_user = up_user;
	}
	public String getUp_path() {
		return up_path;
	}
	public void setUp_path(String up_path) {
		this.up_path = up_path;
	}
	public String getUpIp() {
		return upIp;
	}
	public void setUpIp(String upIp) {
		this.upIp = upIp;
	}
	public Date getUp_time() {
		return up_time;
	}
	public void setUp_time(Date up_time) {
		this.up_time = up_time;
	}

	
	
}
