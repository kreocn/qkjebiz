package com.qkj.manage.domain;

import java.util.Date;

public class SalPromot {
	private Integer uuid;// (int)
	private String sal_title;// (varchar)促销主题
	private Date startime;// (date)开始时间
	private Date endtime;// (date)结束时间
	private String sal_scop;// (varchar)范围
	private String sal_plan;// (text)促销方案
	private String add_user;// (varchar)添加人
	private Date add_time;// (datetime)添加时间
	private Integer status;
	private Integer sal_scopUs;
	private Integer sd_status;// (int)销售部审核状态30：大区经理
	private String sd_user;// (varchar)审核人
	private Date sd_time;// (datetime)审核时间
	private Integer smd_status;// (int)销管部审核状态20：销管经理
	private String smd_user;// (varchar)审核人
	private Date smd_time;// (datetime)审核时间
	private String lm_user;// (varchar)修改人
	private Date lm_time;// (datetime)修改时间
	private Integer rebate;
	private Integer priority;
	private String note;
	private String sal_scopDept;
	private String add_user_dept;

	// 以下为非数据库字段
	private String sd_name;
	private String smd_name;
	private String add_user_name;
	private String lm_user_name;
	private String dept_code;
	private String sal_scopDept_name;
	private String add_user_dept_name;

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getSal_title() {
		return sal_title;
	}

	public void setSal_title(String sal_title) {
		this.sal_title = sal_title;
	}

	public Date getStartime() {
		return startime;
	}

	public void setStartime(Date startime) {
		this.startime = startime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public String getSal_scop() {
		return sal_scop;
	}

	public void setSal_scop(String sal_scop) {
		this.sal_scop = sal_scop;
	}

	public String getSal_plan() {
		return sal_plan;
	}

	public void setSal_plan(String sal_plan) {
		this.sal_plan = sal_plan;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public Date getAdd_time() {
		return add_time;
	}

	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}

	public Integer getSd_status() {
		return sd_status;
	}

	public void setSd_status(Integer sd_status) {
		this.sd_status = sd_status;
	}

	public String getSd_user() {
		return sd_user;
	}

	public void setSd_user(String sd_user) {
		this.sd_user = sd_user;
	}

	public Date getSd_time() {
		return sd_time;
	}

	public void setSd_time(Date sd_time) {
		this.sd_time = sd_time;
	}

	public Integer getSmd_status() {
		return smd_status;
	}

	public void setSmd_status(Integer smd_status) {
		this.smd_status = smd_status;
	}

	public String getSmd_user() {
		return smd_user;
	}

	public void setSmd_user(String smd_user) {
		this.smd_user = smd_user;
	}

	public Date getSmd_time() {
		return smd_time;
	}

	public void setSmd_time(Date smd_time) {
		this.smd_time = smd_time;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getRebate() {
		return rebate;
	}

	public void setRebate(Integer rebate) {
		this.rebate = rebate;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public String getSd_name() {
		return sd_name;
	}

	public void setSd_name(String sd_name) {
		this.sd_name = sd_name;
	}

	public String getSmd_name() {
		return smd_name;
	}

	public void setSmd_name(String smd_name) {
		this.smd_name = smd_name;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getSal_scopDept() {
		return sal_scopDept;
	}

	public void setSal_scopDept(String sal_scopDept) {
		this.sal_scopDept = sal_scopDept;
	}

	public String getSal_scopDept_name() {
		return sal_scopDept_name;
	}

	public void setSal_scopDept_name(String sal_scopDept_name) {
		this.sal_scopDept_name = sal_scopDept_name;
	}

	public String getAdd_user_dept() {
		return add_user_dept;
	}

	public void setAdd_user_dept(String add_user_dept) {
		this.add_user_dept = add_user_dept;
	}

	public Integer getSal_scopUs() {
		return sal_scopUs;
	}

	public void setSal_scopUs(Integer sal_scopUs) {
		this.sal_scopUs = sal_scopUs;
	}

	public String getAdd_user_dept_name() {
		return add_user_dept_name;
	}

	public void setAdd_user_dept_name(String add_user_dept_name) {
		this.add_user_dept_name = add_user_dept_name;
	}

}
