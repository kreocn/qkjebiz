package com.qkj.ware.domain;

import java.util.*;

public class InStock {
	private Integer uuid;// (varchar)
	private String ordernum;
	private Date date;// (date)
	private Integer store_id;// (int)
	private String operator_id;// (int)经办人
	private String take_id;// (int)保管员
	private String note;// (varchar)其它说明
	private Double total_price;// (decimal)总价
	private String add_user;// (int)添加人
	private Date add_timer;// (datetime)
	private String lm_user;// (int)修改人
	private Date lm_timer;// (datetime)
	private Integer reason;// (int)入库原因：0正常，1报溢
	private Integer status;// 0:新单1：

	private Integer confirm;// (int)确认
	private String conname;// (varchar)确认人
	private Date contime;// (date)确认时间
	private Integer send;

	// 数据库外
	private String add_user_name;
	private String lm_user_name;

	// 以下为非数据库字段
	private String prvg;
	private String operator_name;
	private String take_name;
	private Date date_start;
	private Date date_end;
	private String conname_u;

	
	
	public String getConname_u() {
		return conname_u;
	}

	public void setConname_u(String conname_u) {
		this.conname_u = conname_u;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public Date getDate() {
		return date;
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

	public String getAdd_user() {
		return add_user;
	}

	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}

	public Date getAdd_timer() {
		return add_timer;
	}

	public void setAdd_timer(Date add_timer) {
		this.add_timer = add_timer;
	}

	public String getLm_user() {
		return lm_user;
	}

	public void setLm_user(String lm_user) {
		this.lm_user = lm_user;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public Integer getConfirm() {
		return confirm;
	}

	public void setConfirm(Integer confirm) {
		this.confirm = confirm;
	}

	public String getConname() {
		return conname;
	}

	public void setConname(String conname) {
		this.conname = conname;
	}

	public Date getContime() {
		return contime;
	}

	public void setContime(Date contime) {
		this.contime = contime;
	}

	public String getPrvg() {
		return prvg;
	}

	public void setPrvg(String prvg) {
		this.prvg = prvg;
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

	public Integer getSend() {
		return send;
	}

	public void setSend(Integer send) {
		this.send = send;
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
