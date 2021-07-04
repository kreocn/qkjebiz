package com.qkj.adm.domain;

import java.util.Date;

public class Leave {
	private Integer uuid;// (int)主键自增
	private Integer leave_type;// (int)类型 0出差 1请假 2加班 3换休
	private String leave_dept;// (varchar)申请部门
	private String leave_mold;// 假期类别
	private String leave_user;// (varchar)申请人
	private Date leave_time;// 添加时间
	private Date leave_start;// (date)开始日期
	private String leave_start_time;// (varchar)开始时间
	private Date leave_end;// (date)结束日期
	private String leave_end_time;// (varchar)结束时间
	private Double totle;// (decimal)共计
	private String cause;// (varchar)事由
	private Integer check_status;// (int)审核状态
	private String check_user;// (varchar)审核人
	private Date check_time;// (datetime)审核时间
	private String check_note;// (text)审核意见
	private Integer acheck_status;// (int)行政审核状态
	private String acheck_user;// (varchar)行政审核人
	private Date acheck_time;// (datetime)行政审核时间
	private String acheck_note;// (text)行政审核意见
	private Date lm_time;// (datetime)最后修改时间
	private String lm_user;// (varchar)最后修改人
	private Integer allowance_status;// (int)已补贴
	private Date allowance_date;// (date)补贴时间
	private String peer;

	// 以下为非数据库字段
	private String check_user_name;// 审核人
	private String check_user_sign;
	private String acheck_user_name;// 行政审核人
	private String acheck_user_sign;// 行政审核人
	private String leave_dept_name;
	private String leave_user_name;

	// 以下为查询专用字段
	private Date serach_date;
	private String is_sub_dept; // 包含子部门

	public String getIs_sub_dept() {
		return is_sub_dept;
	}

	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}

	public String getPeer() {
		return peer;
	}

	public void setPeer(String peer) {
		this.peer = peer;
	}

	public String getCheck_user_sign() {
		return check_user_sign;
	}

	public void setCheck_user_sign(String check_user_sign) {
		this.check_user_sign = check_user_sign;
	}

	public String getAcheck_user_sign() {
		return acheck_user_sign;
	}

	public void setAcheck_user_sign(String acheck_user_sign) {
		this.acheck_user_sign = acheck_user_sign;
	}

	public Date getLeave_time() {
		return leave_time;
	}

	public void setLeave_time(Date leave_time) {
		this.leave_time = leave_time;
	}

	public Date getSerach_date() {
		return serach_date;
	}

	public void setSerach_date(Date serach_date) {
		this.serach_date = serach_date;
	}

	public String getLeave_user_name() {
		return leave_user_name;
	}

	public void setLeave_user_name(String leave_user_name) {
		this.leave_user_name = leave_user_name;
	}

	public String getLeave_dept_name() {
		return leave_dept_name;
	}

	public void setLeave_dept_name(String leave_dept_name) {
		this.leave_dept_name = leave_dept_name;
	}

	public String getLeave_mold() {
		return leave_mold;
	}

	public void setLeave_mold(String leave_mold) {
		this.leave_mold = leave_mold;
	}

	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	public String getAcheck_user_name() {
		return acheck_user_name;
	}

	public void setAcheck_user_name(String acheck_user_name) {
		this.acheck_user_name = acheck_user_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getLeave_type() {
		return leave_type;
	}

	public void setLeave_type(Integer leave_type) {
		this.leave_type = leave_type;
	}

	public String getLeave_dept() {
		return leave_dept;
	}

	public void setLeave_dept(String leave_dept) {
		this.leave_dept = leave_dept;
	}

	public String getLeave_user() {
		return leave_user;
	}

	public void setLeave_user(String leave_user) {
		this.leave_user = leave_user;
	}

	public Date getLeave_start() {
		return leave_start;
	}

	public void setLeave_start(Date leave_start) {
		this.leave_start = leave_start;
	}

	public String getLeave_start_time() {
		return leave_start_time;
	}

	public void setLeave_start_time(String leave_start_time) {
		this.leave_start_time = leave_start_time;
	}

	public Date getLeave_end() {
		return leave_end;
	}

	public void setLeave_end(Date leave_end) {
		this.leave_end = leave_end;
	}

	public String getLeave_end_time() {
		return leave_end_time;
	}

	public void setLeave_end_time(String leave_end_time) {
		this.leave_end_time = leave_end_time;
	}

	public Double getTotle() {
		return totle;
	}

	public void setTotle(Double totle) {
		this.totle = totle;
	}

	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public Integer getCheck_status() {
		return check_status;
	}

	public void setCheck_status(Integer check_status) {
		this.check_status = check_status;
	}

	public String getCheck_user() {
		return check_user;
	}

	public void setCheck_user(String check_user) {
		this.check_user = check_user;
	}

	public Date getCheck_time() {
		return check_time;
	}

	public void setCheck_time(Date check_time) {
		this.check_time = check_time;
	}

	public String getCheck_note() {
		return check_note;
	}

	public void setCheck_note(String check_note) {
		this.check_note = check_note;
	}

	public Integer getAcheck_status() {
		return acheck_status;
	}

	public void setAcheck_status(Integer acheck_status) {
		this.acheck_status = acheck_status;
	}

	public String getAcheck_user() {
		return acheck_user;
	}

	public void setAcheck_user(String acheck_user) {
		this.acheck_user = acheck_user;
	}

	public Date getAcheck_time() {
		return acheck_time;
	}

	public void setAcheck_time(Date acheck_time) {
		this.acheck_time = acheck_time;
	}

	public String getAcheck_note() {
		return acheck_note;
	}

	public void setAcheck_note(String acheck_note) {
		this.acheck_note = acheck_note;
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

	public Integer getAllowance_status() {
		return allowance_status;
	}

	public void setAllowance_status(Integer allowance_status) {
		this.allowance_status = allowance_status;
	}

	public Date getAllowance_date() {
		return allowance_date;
	}

	public void setAllowance_date(Date allowance_date) {
		this.allowance_date = allowance_date;
	}

}
