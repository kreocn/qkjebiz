package com.qkj.ware.domain;

import java.util.*;

public class OutStock {
	private int uuid;// (varchar)
	private String ordernum;// 订单号
	private Date date;// (date)
	private Integer store_id;// (int)
	private String operator_id;// (int)
	private String take_id;// (int)
	private String note;// (varchar)
	private Double total_price;// (decimal)
	private String add_user;// (int)
	private Date add_timer;// (datetime)
	private String lm_user;// (int)
	private Date lm_timer;// (datetime)
	private Integer reason;// (int)0销售用酒，1董事会用酒 ，借酒
	private Integer send;// (int)2新单3待审核4结案5未出货6未返利
	private Integer manager_check;// (int)渠道/运营经理确认   1:已确认
	private String manager_check_user;// (varchar)
	private Date manager_check_time;// (datetime)确认时间
	private Integer coo_check;// (int)运营总监确认
	private String coo_check_user;// (varchar)
	private Date coo_check_time;// (datetime)确认时间
	private String bsreason;
	private Integer borrowStore_id; 

	private String member_id;
	private String member_mebile;
	private String member_name;
	private String member_adress;
	private Double member_price;
	private String dept_name;
	private String dept_code;
	private Integer boflag;//0未还1已还

	// 以下为非数据库字段
	private String add_user_name;
	private String lm_user_name;
	private String ware_name;
	private String manager_check_user_name;
	private String coo_check_user_name;
	private String operator_name;
	private String take_name;
	private Date date_start;
	private Date date_end;

	public Date getDate() {
		return date;
	}

	public int getUuid() {
		return uuid;
	}

	public void setUuid(int uuid) {
		this.uuid = uuid;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getStore_id() {
		return store_id;
	}

	public void setStore_id(Integer store_id) {
		this.store_id = store_id;
	}

	public String getOperator_id() {
		return operator_id;
	}

	public void setOperator_id(String operator_id) {
		this.operator_id = operator_id;
	}

	public String getTake_id() {
		return take_id;
	}

	public void setTake_id(String take_id) {
		this.take_id = take_id;
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

	public Date getAdd_timer() {
		return add_timer;
	}

	public void setAdd_timer(Date add_timer) {
		this.add_timer = add_timer;
	}

	public Date getLm_timer() {
		return lm_timer;
	}

	public void setLm_timer(Date lm_timer) {
		this.lm_timer = lm_timer;
	}

	public Integer getReason() {
		return reason;
	}

	public void setReason(Integer reason) {
		this.reason = reason;
	}

	public Integer getSend() {
		return send;
	}

	public void setSend(Integer send) {
		this.send = send;
	}

	public Integer getManager_check() {
		return manager_check;
	}

	public void setManager_check(Integer manager_check) {
		this.manager_check = manager_check;
	}

	public String getManager_check_user() {
		return manager_check_user;
	}

	public void setManager_check_user(String manager_check_user) {
		this.manager_check_user = manager_check_user;
	}

	public Date getManager_check_time() {
		return manager_check_time;
	}

	public void setManager_check_time(Date manager_check_time) {
		this.manager_check_time = manager_check_time;
	}

	public Integer getCoo_check() {
		return coo_check;
	}

	public void setCoo_check(Integer coo_check) {
		this.coo_check = coo_check;
	}

	public String getCoo_check_user() {
		return coo_check_user;
	}

	public void setCoo_check_user(String coo_check_user) {
		this.coo_check_user = coo_check_user;
	}

	public Date getCoo_check_time() {
		return coo_check_time;
	}

	public void setCoo_check_time(Date coo_check_time) {
		this.coo_check_time = coo_check_time;
	}

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
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

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_mebile() {
		return member_mebile;
	}

	public void setMember_mebile(String member_mebile) {
		this.member_mebile = member_mebile;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_adress() {
		return member_adress;
	}

	public void setMember_adress(String member_adress) {
		this.member_adress = member_adress;
	}

	public Double getMember_price() {
		return member_price;
	}

	public void setMember_price(Double member_price) {
		this.member_price = member_price;
	}

	public String getBsreason() {
		return bsreason;
	}

	public void setBsreason(String bsreason) {
		this.bsreason = bsreason;
	}

	public String getWare_name() {
		return ware_name;
	}

	public void setWare_name(String ware_name) {
		this.ware_name = ware_name;
	}

	public String getManager_check_user_name() {
		return manager_check_user_name;
	}

	public void setManager_check_user_name(String manager_check_user_name) {
		this.manager_check_user_name = manager_check_user_name;
	}

	public String getCoo_check_user_name() {
		return coo_check_user_name;
	}

	public void setCoo_check_user_name(String coo_check_user_name) {
		this.coo_check_user_name = coo_check_user_name;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public String getOperator_name() {
		return operator_name;
	}

	public void setOperator_name(String operator_name) {
		this.operator_name = operator_name;
	}

	public String getTake_name() {
		return take_name;
	}

	public void setTake_name(String take_name) {
		this.take_name = take_name;
	}

	public Integer getBorrowStore_id() {
		return borrowStore_id;
	}

	public void setBorrowStore_id(Integer borrowStore_id) {
		this.borrowStore_id = borrowStore_id;
	}

	public Integer getBoflag() {
		return boflag;
	}

	public void setBoflag(Integer boflag) {
		this.boflag = boflag;
	}

	public Date getDate_start() {
		return date_start;
	}

	public void setDate_start(Date date_start) {
		this.date_start = date_start;
	}

	public Date getDate_end() {
		return date_end;
	}

	public void setDate_end(Date date_end) {
		this.date_end = date_end;
	}
	
	
	
	
	
}
