package com.qkj.ware.domain;

import java.util.*;

public class InStockH {
	private int uuid;// (varchar)
	private String ordernum;
	private Date date;// (date)
	private Integer store_id;// (int)
	private String operator_id;// (varchar)经办人
	private String take_id;// (varchar)保管员
	private String note;// (varchar)其它说明
	private Double total_price;// (decimal)总价
	private String add_user;// (varchar)添加人
	private Date add_timer;// (datetime)
	private String lm_user;// (varchar)修改人
	private Date lm_timer;// (datetime)
	private Integer reason;// (int)入库原因：0正常，1报溢
	private Integer confirm;// (int)确认
	private String conname;// (varchar)确认人
	private Date contime;// (date)确认时间

	// 以下为非数据库字段

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public int getUuid() {
		return uuid;
	}

	public void setUuid(int uuid) {
		this.uuid = uuid;
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

}
