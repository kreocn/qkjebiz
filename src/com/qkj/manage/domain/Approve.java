package com.qkj.manage.domain;

import java.util.Date;

public class Approve {
	private Integer uuid;// (int)系统编号
	private Integer approve_type;// (int)审阅类型0至事由1活动
	private Integer int_id;// (int)所有int类型的id(至事由编号)
	private String varchar_id;// (varchar)所有字符型id(活动编号)
	private Integer flag;// (int)审核标记(0无标记 5不通过 10通过)
	private String check_user;// (varchar)审核人
	private String advice;// (varchar)审核意见
	private Date ad_time;// (datetime)审核时间

	// 以下为非数据库字段
	private String check_user_name;
	private Date ad_time_start;
	private Date ad_time_end;

	public Date getAd_time_start() {
		return ad_time_start;
	}

	public void setAd_time_start(Date ad_time_start) {
		this.ad_time_start = ad_time_start;
	}

	public Date getAd_time_end() {
		return ad_time_end;
	}

	public void setAd_time_end(Date ad_time_end) {
		this.ad_time_end = ad_time_end;
	}

	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getApprove_type() {
		return approve_type;
	}

	public void setApprove_type(Integer approve_type) {
		this.approve_type = approve_type;
	}

	public Integer getInt_id() {
		return int_id;
	}

	public void setInt_id(Integer int_id) {
		this.int_id = int_id;
	}

	public String getVarchar_id() {
		return varchar_id;
	}

	public void setVarchar_id(String varchar_id) {
		this.varchar_id = varchar_id;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public String getCheck_user() {
		return check_user;
	}

	public void setCheck_user(String check_user) {
		this.check_user = check_user;
	}

	public String getAdvice() {
		return advice;
	}

	public void setAdvice(String advice) {
		this.advice = advice;
	}

	public Date getAd_time() {
		return ad_time;
	}

	public void setAd_time(Date ad_time) {
		this.ad_time = ad_time;
	}

}
