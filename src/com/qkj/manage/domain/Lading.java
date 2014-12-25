package com.qkj.manage.domain;

import java.util.Date;

public class Lading {
	private Integer uuid;// (int)申请编号
	private String member_id;// (varchar)客户ID
	private String content;// (text)内容
	private String address;// (varchar)配送地点
	private String note;// (text)其他说明
	private Double total_price; // 总价
	private Double curr_price;// 实际打款金额
	private Integer manager_check;// (int)渠道/运营经理确认
	private String manager_check_user;
	private Date manager_check_time;// (datetime)确认时间
	private Integer sd_check;// (int)销售部经理确认
	private String sd_check_user;
	private Date sd_check_time;// (datetime)确认时间
	private Integer md_check;// (int)市场部经理确认
	private String md_check_user;
	private Date md_check_time;// (datetime)确认时间
	private Integer fd_check;// (int)财务确认 0 未付款 1 未结清 2 已付款
	private String fd_type; // 付款方式
	private Date fd_date; // 付款时间
	private String fd_check_user;
	private Date fd_check_time;// (datetime)确认时间
	private Integer coo_check;// (int)运营总监确认
	private String coo_check_user;
	private Date coo_check_time;// (datetime)确认时间
	private Integer status;// (int)状态 0初始 1报批 2结案
	private Date close_time;// (datetime)结案时间
	private String applicant;// (varchar)申请人ID
	private Date apply_time;// (datetime)申请时间
	private String add_user;// (varchar)添加人ID
	private Date add_time;// (datetime)添加时间
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (timestamp)最后修改时间
	private Integer out_flag; // 出货标记(0:未出货 1:已出货)
	private Integer rebates_flag; // 返利标记 0未返利 1已返利

	// 以下为非数据库字段
	private String manager_check_user_name;
	private String sd_check_user_name;
	private String md_check_user_name;
	private String fd_check_user_name;
	private String coo_check_user_name;
	private String applicant_name;
	private String add_user_name;
	private String lm_user_name;

	private String member_name;
	private String member_mobile;

	// 特殊字段
	private String[] fd_types; // 专门为赋值checkbox而设定

	public Double getCurr_price() {
		return curr_price;
	}

	public void setCurr_price(Double curr_price) {
		this.curr_price = curr_price;
	}

	public Integer getOut_flag() {
		return out_flag;
	}

	public void setOut_flag(Integer out_flag) {
		this.out_flag = out_flag;
	}

	public Integer getRebates_flag() {
		return rebates_flag;
	}

	public void setRebates_flag(Integer rebates_flag) {
		this.rebates_flag = rebates_flag;
	}

	public String[] getFd_types() {
		return fd_types;
	}

	public void setFd_types(String[] fd_types) {
		this.fd_types = fd_types;
	}

	public String getFd_type() {
		return fd_type;
	}

	public void setFd_type(String fd_type) {
		this.fd_type = fd_type;
	}

	public Date getFd_date() {
		return fd_date;
	}

	public void setFd_date(Date fd_date) {
		this.fd_date = fd_date;
	}

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

	public String getMember_mobile() {
		return member_mobile;
	}

	public void setMember_mobile(String member_mobile) {
		this.member_mobile = member_mobile;
	}

	public String getManager_check_user() {
		return manager_check_user;
	}

	public void setManager_check_user(String manager_check_user) {
		this.manager_check_user = manager_check_user;
	}

	public String getSd_check_user() {
		return sd_check_user;
	}

	public void setSd_check_user(String sd_check_user) {
		this.sd_check_user = sd_check_user;
	}

	public String getMd_check_user() {
		return md_check_user;
	}

	public void setMd_check_user(String md_check_user) {
		this.md_check_user = md_check_user;
	}

	public String getFd_check_user() {
		return fd_check_user;
	}

	public void setFd_check_user(String fd_check_user) {
		this.fd_check_user = fd_check_user;
	}

	public String getCoo_check_user() {
		return coo_check_user;
	}

	public void setCoo_check_user(String coo_check_user) {
		this.coo_check_user = coo_check_user;
	}

	public String getManager_check_user_name() {
		return manager_check_user_name;
	}

	public void setManager_check_user_name(String manager_check_user_name) {
		this.manager_check_user_name = manager_check_user_name;
	}

	public String getSd_check_user_name() {
		return sd_check_user_name;
	}

	public void setSd_check_user_name(String sd_check_user_name) {
		this.sd_check_user_name = sd_check_user_name;
	}

	public String getMd_check_user_name() {
		return md_check_user_name;
	}

	public void setMd_check_user_name(String md_check_user_name) {
		this.md_check_user_name = md_check_user_name;
	}

	public String getFd_check_user_name() {
		return fd_check_user_name;
	}

	public void setFd_check_user_name(String fd_check_user_name) {
		this.fd_check_user_name = fd_check_user_name;
	}

	public String getCoo_check_user_name() {
		return coo_check_user_name;
	}

	public void setCoo_check_user_name(String coo_check_user_name) {
		this.coo_check_user_name = coo_check_user_name;
	}

	public String getApplicant_name() {
		return applicant_name;
	}

	public void setApplicant_name(String applicant_name) {
		this.applicant_name = applicant_name;
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

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getManager_check() {
		return manager_check;
	}

	public void setManager_check(Integer manager_check) {
		this.manager_check = manager_check;
	}

	public Date getManager_check_time() {
		return manager_check_time;
	}

	public void setManager_check_time(Date manager_check_time) {
		this.manager_check_time = manager_check_time;
	}

	public Integer getSd_check() {
		return sd_check;
	}

	public void setSd_check(Integer sd_check) {
		this.sd_check = sd_check;
	}

	public Date getSd_check_time() {
		return sd_check_time;
	}

	public void setSd_check_time(Date sd_check_time) {
		this.sd_check_time = sd_check_time;
	}

	public Integer getMd_check() {
		return md_check;
	}

	public void setMd_check(Integer md_check) {
		this.md_check = md_check;
	}

	public Date getMd_check_time() {
		return md_check_time;
	}

	public void setMd_check_time(Date md_check_time) {
		this.md_check_time = md_check_time;
	}

	public Integer getFd_check() {
		return fd_check;
	}

	public void setFd_check(Integer fd_check) {
		this.fd_check = fd_check;
	}

	public Date getFd_check_time() {
		return fd_check_time;
	}

	public void setFd_check_time(Date fd_check_time) {
		this.fd_check_time = fd_check_time;
	}

	public Integer getCoo_check() {
		return coo_check;
	}

	public void setCoo_check(Integer coo_check) {
		this.coo_check = coo_check;
	}

	public Date getCoo_check_time() {
		return coo_check_time;
	}

	public void setCoo_check_time(Date coo_check_time) {
		this.coo_check_time = coo_check_time;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getClose_time() {
		return close_time;
	}

	public void setClose_time(Date close_time) {
		this.close_time = close_time;
	}

	public String getApplicant() {
		return applicant;
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}

	public Date getApply_time() {
		return apply_time;
	}

	public void setApply_time(Date apply_time) {
		this.apply_time = apply_time;
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

}
