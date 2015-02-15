package com.qkj.manage.domain;

import java.util.Date;

public class Lading {
	private Integer uuid;// (int)申请编号
	private String member_id;// (varchar)客户ID
	private String content;// (text)内容
	private String address;// (varchar)配送地点
	private String note;// (text)其他说明
	private Double total_price; // 订单总价
	private Double curr_price;// 实际打款金额
	private Double total_price_g;// 返利总价
	private Integer fd_check;// (int)财务确认 0 未付款 1 未结清 2 已付款
	private String fd_type; // 付款方式
	private Date fd_date; // 付款时间
	private String fd_check_user;
	private Date fd_check_time;// (datetime)确认时间
	private String fd_note;// 确认说明
	private Integer status;// (int)状态 0初始 1报批 2结案
	private String check_user;// 审核人
	private Date check_time;// (datetime)结案时间
	private String applicant;// (varchar)申请人ID
	private String apply_dept;// 申请部门
	private Date apply_time;// (datetime)申请时间
	private String add_user;// (varchar)添加人ID
	private Date add_time;// (datetime)添加时间
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (timestamp)最后修改时间
	private Integer out_flag; // 出货标记(0:未出货 1:已出货)
	private Integer rebates_flag; // 返利标记 0未返利 1已返利
	private String promotions;// 促销ID
	private String dis_dept;//发货部门

	// 以下为非数据库字段
	private String fd_check_user_name;
	private String applicant_name;
	private String add_user_name;
	private String lm_user_name;
	private String apply_dept_name;
	private String check_user_name;

	private String member_name;
	private String member_mobile;
	private String dis_dept_name;

	// 特殊字段
	private Integer[] fd_typesx; // 专门为赋值checkbox而设定

	public Integer[] getFd_typesx() {
		return fd_typesx;
	}

	public void setFd_typesx(Integer[] fd_typesx) {
		this.fd_typesx = fd_typesx;
	}

	public String getFd_note() {
		return fd_note;
	}

	public void setFd_note(String fd_note) {
		this.fd_note = fd_note;
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

	public Double getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Double total_price) {
		this.total_price = total_price;
	}

	public Double getCurr_price() {
		return curr_price;
	}

	public void setCurr_price(Double curr_price) {
		this.curr_price = curr_price;
	}

	public Double getTotal_price_g() {
		return total_price_g;
	}

	public void setTotal_price_g(Double total_price_g) {
		this.total_price_g = total_price_g;
	}

	public Integer getFd_check() {
		return fd_check;
	}

	public void setFd_check(Integer fd_check) {
		this.fd_check = fd_check;
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

	public String getFd_check_user() {
		return fd_check_user;
	}

	public void setFd_check_user(String fd_check_user) {
		this.fd_check_user = fd_check_user;
	}

	public Date getFd_check_time() {
		return fd_check_time;
	}

	public void setFd_check_time(Date fd_check_time) {
		this.fd_check_time = fd_check_time;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public String getApplicant() {
		return applicant;
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}

	public String getApply_dept() {
		return apply_dept;
	}

	public void setApply_dept(String apply_dept) {
		this.apply_dept = apply_dept;
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

	public String getPromotions() {
		return promotions;
	}

	public void setPromotions(String promotions) {
		this.promotions = promotions;
	}

	public String getFd_check_user_name() {
		return fd_check_user_name;
	}

	public void setFd_check_user_name(String fd_check_user_name) {
		this.fd_check_user_name = fd_check_user_name;
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

	public String getApply_dept_name() {
		return apply_dept_name;
	}

	public void setApply_dept_name(String apply_dept_name) {
		this.apply_dept_name = apply_dept_name;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_mobile() {
		return member_mobile;
	}

	public void setMember_mobile(String member_mobile) {
		this.member_mobile = member_mobile;
	}

	public String getDis_dept() {
		return dis_dept;
	}

	public void setDis_dept(String dis_dept) {
		this.dis_dept = dis_dept;
	}

	public String getDis_dept_name() {
		return dis_dept_name;
	}

	public void setDis_dept_name(String dis_dept_name) {
		this.dis_dept_name = dis_dept_name;
	}
	
	
}
