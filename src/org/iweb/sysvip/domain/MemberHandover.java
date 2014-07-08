package org.iweb.sysvip.domain;

import java.util.Date;

public class MemberHandover {
	private Integer uuid;// (int)主键ID
	private String member_id;// (varchar)客户ID
	private String applicant;// (varchar)申请人ID
	private Date applicant_time;// (datetime)申请时间
	private String target_dept;// (varchar)目标部门
	private String target_manager;// (varchar)目标人
	private Integer status;// (int)状态 0待接受 1已拒收 2已接受
	private Date accept_time;// (datetime)接收/拒收时间
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (timestamp)最后修改时间

	// 以下为非数据库字段
	private String target_manager_name;
	private String dept_code;
	private String dept_name;
	private String member_name;
	private String applicant_name;
	private String target_dept_name;

	// 查询更新专用字段
	private Integer[] uuids;

	public Integer[] getUuids() {
		return uuids;
	}

	public void setUuids(Integer[] uuids) {
		this.uuids = uuids;
	}

	public String getTarget_manager_name() {
		return target_manager_name;
	}

	public void setTarget_manager_name(String target_manager_name) {
		this.target_manager_name = target_manager_name;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getApplicant_name() {
		return applicant_name;
	}

	public void setApplicant_name(String applicant_name) {
		this.applicant_name = applicant_name;
	}

	public String getTarget_dept_name() {
		return target_dept_name;
	}

	public void setTarget_dept_name(String target_dept_name) {
		this.target_dept_name = target_dept_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getApplicant() {
		return applicant;
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}

	public Date getApplicant_time() {
		return applicant_time;
	}

	public void setApplicant_time(Date applicant_time) {
		this.applicant_time = applicant_time;
	}

	public String getTarget_dept() {
		return target_dept;
	}

	public void setTarget_dept(String target_dept) {
		this.target_dept = target_dept;
	}

	public String getTarget_manager() {
		return target_manager;
	}

	public void setTarget_manager(String target_manager) {
		this.target_manager = target_manager;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getAccept_time() {
		return accept_time;
	}

	public void setAccept_time(Date accept_time) {
		this.accept_time = accept_time;
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
