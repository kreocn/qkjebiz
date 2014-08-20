package org.iweb.sysvip.domain;

import java.util.Date;

public class Deposit {
	private Integer uuid;// (int)主键ID
	private Date pay_date;// (date)付款日期
	private Integer type;// (int)付款方式 0现金 1POS 2支票 3转账 4其他
	private Double amount;// (decimal)付款金额
	private String member_id;// (varchar)客户ID
	private String add_user;// (varchar)提交人
	private Date add_time;// (datetime)提交时间
	private Integer fd_check;// (int)财务确认 0未确认 1已确认
	private String fd_check_user;// (varchar)财务确认人
	private Date fd_check_time;// (datetime)财务确认时间
	private String lm_user;// (varchar)修改人
	private Date lm_time;// (timestamp)修改时间

	// 以下为非数据库字段
	private String member_name;
	private String add_user_name;
	private String fd_check_user_name;

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getFd_check_user_name() {
		return fd_check_user_name;
	}

	public void setFd_check_user_name(String fd_check_user_name) {
		this.fd_check_user_name = fd_check_user_name;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Date getPay_date() {
		return pay_date;
	}

	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
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

	public Integer getFd_check() {
		return fd_check;
	}

	public void setFd_check(Integer fd_check) {
		this.fd_check = fd_check;
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
