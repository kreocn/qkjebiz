package com.qkj.manage.domain;

import java.util.Date;

public class Apply {
	private Integer uuid;// (int)主键ID
	private String touser;// 至(From)
	private String title;// (varchar)主题
	private String note;// (text)详细说明
	private String apply_dept;// (varchar)申请部门
	private String apply_user;// (varchar)申请人
	private Date apply_time;// (datetime)申请时间
	private String check_user;// (varchar)审核人
	private Date check_time;// (datetime)审核时间
	private String check_note;// (text)审核意见
	private Integer is_fullcheck;// 是否需要会审
	private String fullcheck_text;// 会审说明
	private Integer status;// (int)状态 0:新事由 5:已退回 10:待审核 20:大区经理已审 30:运营总监已审
	private String lm_user;// (varchar)修改人
	private Date lm_time;// (timestamp)修改时间

	// 非数据库字段
	private String apply_user_name;
	private String check_user_name;
	private String apply_dept_name;
	private String check_user_sign;
	// 查询专用字段
	private Date apply_time_begin;
	private Date apply_time_end;
	private Date check_time_begin;
	private Date check_time_end;
	private String is_sub_dept;

	public Integer getIs_fullcheck() {
		return is_fullcheck;
	}

	public void setIs_fullcheck(Integer is_fullcheck) {
		this.is_fullcheck = is_fullcheck;
	}

	public String getFullcheck_text() {
		return fullcheck_text;
	}

	public void setFullcheck_text(String fullcheck_text) {
		this.fullcheck_text = fullcheck_text;
	}

	public Date getCheck_time_begin() {
		return check_time_begin;
	}

	public void setCheck_time_begin(Date check_time_begin) {
		this.check_time_begin = check_time_begin;
	}

	public Date getCheck_time_end() {
		return check_time_end;
	}

	public void setCheck_time_end(Date check_time_end) {
		this.check_time_end = check_time_end;
	}

	public String getCheck_user_sign() {
		return check_user_sign;
	}

	public void setCheck_user_sign(String check_user_sign) {
		this.check_user_sign = check_user_sign;
	}

	public String getTouser() {
		return touser;
	}

	public void setTouser(String touser) {
		this.touser = touser;
	}

	public String getIs_sub_dept() {
		return is_sub_dept;
	}

	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}

	public String getApply_user_name() {
		return apply_user_name;
	}

	public void setApply_user_name(String apply_user_name) {
		this.apply_user_name = apply_user_name;
	}

	public String getCheck_user_name() {
		return check_user_name;
	}

	public void setCheck_user_name(String check_user_name) {
		this.check_user_name = check_user_name;
	}

	public String getApply_dept_name() {
		return apply_dept_name;
	}

	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}

	public Date getApply_time_begin() {
		return apply_time_begin;
	}

	public void setApply_time_begin(Date apply_time_begin) {
		this.apply_time_begin = apply_time_begin;
	}

	public Date getApply_time_end() {
		return apply_time_end;
	}

	public void setApply_time_end(Date apply_time_end) {
		this.apply_time_end = apply_time_end;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getApply_dept() {
		return apply_dept;
	}

	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
	}

	public String getApply_user() {
		return apply_user;
	}

	public void setApply_user(String apply_user) {
		this.apply_user = apply_user;
	}

	public Date getApply_time() {
		return apply_time;
	}

	public void setApply_time(Date apply_time) {
		this.apply_time = apply_time;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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
