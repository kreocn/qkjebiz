package com.qkj.manage.domain;

import java.util.Date;

public class MyProcess {
	private Integer uuid;// (int)主键自增
	private Integer process_id;// (int)类型0无 1活动 2至事由 3:工时
	private Integer biz_id;// (int)业务ID
	private String biz_user;// (varchar)业务时间
	private Date biz_time;// (varchar)业务人
	private String biz_note;// (text)业务备注
	private Integer biz_status01;// (int)业务状态1
	private Integer biz_status02;// (int)业务状态2
	private Integer biz_status03;// (int)业务状态3
	private Integer biz_status04;// (int)业务状态4
	private Integer biz_status05;// (int)业务状态5
	private String biz_sign;// (varchar)业务标记

	// 以下为非数据库字段
	private String uname;
	

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getProcess_id() {
		return process_id;
	}

	public void setProcess_id(Integer process_id) {
		this.process_id = process_id;
	}

	public Integer getBiz_id() {
		return biz_id;
	}

	public void setBiz_id(Integer biz_id) {
		this.biz_id = biz_id;
	}

	public String getBiz_user() {
		return biz_user;
	}

	public void setBiz_user(String biz_user) {
		this.biz_user = biz_user;
	}

	public Date getBiz_time() {
		return biz_time;
	}

	public void setBiz_time(Date biz_time) {
		this.biz_time = biz_time;
	}

	public String getBiz_note() {
		return biz_note;
	}

	public void setBiz_note(String biz_note) {
		this.biz_note = biz_note;
	}

	public Integer getBiz_status01() {
		return biz_status01;
	}

	public void setBiz_status01(Integer biz_status01) {
		this.biz_status01 = biz_status01;
	}

	public Integer getBiz_status02() {
		return biz_status02;
	}

	public void setBiz_status02(Integer biz_status02) {
		this.biz_status02 = biz_status02;
	}

	public Integer getBiz_status03() {
		return biz_status03;
	}

	public void setBiz_status03(Integer biz_status03) {
		this.biz_status03 = biz_status03;
	}

	public Integer getBiz_status04() {
		return biz_status04;
	}

	public void setBiz_status04(Integer biz_status04) {
		this.biz_status04 = biz_status04;
	}

	public Integer getBiz_status05() {
		return biz_status05;
	}

	public void setBiz_status05(Integer biz_status05) {
		this.biz_status05 = biz_status05;
	}

	public String getBiz_sign() {
		return biz_sign;
	}

	public void setBiz_sign(String biz_sign) {
		this.biz_sign = biz_sign;
	}

}
