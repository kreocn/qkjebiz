package com.qkj.manage.domain;

import java.util.Date;

public class Entertain {
	private Integer uuid;// (int)主键自增
	private String apply_dept;// (varchar)申请部门
	private String apply_user;// (varchar)申请人
	private Date apply_date;// (varchar)主题
	private String add_user;// (varchar)添加人
	private Date add_time;// (datetime)添加时间
	private String lm_user;// (varchar)修改人
	private Date lm_time;// (timestamp)修改时
	private String remark;
	
	private String apply_user_name;
	private String apply_dept_name;
	private Date plan_start_begin;
	private Date plan_start_end;
	private String is_sub_dept;
	private Integer proNum;
	
	private Integer state;
	
	
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getProNum() {
		return proNum;
	}
	public void setProNum(Integer proNum) {
		this.proNum = proNum;
	}
	public String getIs_sub_dept() {
		return is_sub_dept;
	}
	public void setIs_sub_dept(String is_sub_dept) {
		this.is_sub_dept = is_sub_dept;
	}
	public Date getPlan_start_begin() {
		return plan_start_begin;
	}
	public void setPlan_start_begin(Date plan_start_begin) {
		this.plan_start_begin = plan_start_begin;
	}
	public Date getPlan_start_end() {
		return plan_start_end;
	}
	public void setPlan_start_end(Date plan_start_end) {
		this.plan_start_end = plan_start_end;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getApply_user() {
		return apply_user;
	}
	public void setApply_user(String apply_user) {
		this.apply_user = apply_user;
	}
	public Date getApply_date() {
		return apply_date;
	}
	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
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
	public String getApply_user_name() {
		return apply_user_name;
	}
	public void setApply_user_name(String apply_user_name) {
		this.apply_user_name = apply_user_name;
	}
	public String getApply_dept_name() {
		return apply_dept_name;
	}
	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}


	

}
