package com.qkj.manage.domain;

import java.util.Date;

public class Rebates {
	private Integer uuid;// (int)主键ID
	private String member_id;// (varchar)会员ID
	private Integer re_type;// (int)返利类型 0随单返利 1季度返利 2年度返利
	private Integer re_form;// (int)返利方式 0积分 1实体 2现金 3混合
	private Integer re_score;// (int)返利积分
	private Double re_money;// (decimal)返现金数
	private Integer with_score;// (int)随量积分
	private String note; // 返利说明
	private Integer status;// (int)状态 0新申请 1主管审批 2经理审批 3财务审批 4运营总监审批 5总经理审批
	private String applicant;// (varchar)申请人ID
	private Date apply_time;// (datetime)申请时间
	private String lm_user;// (varchar)最后修改人
	private Date lm_time;// (timestamp)最后修改时间
	private Integer fd_check;// 财务最终确定标记
	private Date fd_check_time;// 确定时间
	private Integer out_flag;// 出货标记
	private Date out_time;// 出货时间
	private String re_scale;// 拼接字符,用来设置返利的每个产品的系数,用#隔开

	// 以下为非数据库字段
	private String member_name;
	private String member_mobile;
	private String applicant_name;
	private String lm_user_name;

	private Integer product_num;
	private Double product_money;

	public Integer getWith_score() {
		return with_score;
	}

	public void setWith_score(Integer with_score) {
		this.with_score = with_score;
	}

	public String getRe_scale() {
		return re_scale;
	}

	public void setRe_scale(String re_scale) {
		this.re_scale = re_scale;
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

	public Integer getOut_flag() {
		return out_flag;
	}

	public void setOut_flag(Integer out_flag) {
		this.out_flag = out_flag;
	}

	public Date getOut_time() {
		return out_time;
	}

	public void setOut_time(Date out_time) {
		this.out_time = out_time;
	}

	public Integer getProduct_num() {
		return product_num;
	}

	public void setProduct_num(Integer product_num) {
		this.product_num = product_num;
	}

	public Double getProduct_money() {
		return product_money;
	}

	public void setProduct_money(Double product_money) {
		this.product_money = product_money;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
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

	public String getApplicant_name() {
		return applicant_name;
	}

	public void setApplicant_name(String applicant_name) {
		this.applicant_name = applicant_name;
	}

	public String getLm_user_name() {
		return lm_user_name;
	}

	public void setLm_user_name(String lm_user_name) {
		this.lm_user_name = lm_user_name;
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

	public Integer getRe_type() {
		return re_type;
	}

	public void setRe_type(Integer re_type) {
		this.re_type = re_type;
	}

	public Integer getRe_form() {
		return re_form;
	}

	public void setRe_form(Integer re_form) {
		this.re_form = re_form;
	}

	public Integer getRe_score() {
		return re_score;
	}

	public void setRe_score(Integer re_score) {
		this.re_score = re_score;
	}

	public Double getRe_money() {
		return re_money;
	}

	public void setRe_money(Double re_money) {
		this.re_money = re_money;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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
