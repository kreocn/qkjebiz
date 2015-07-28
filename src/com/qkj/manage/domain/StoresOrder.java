package com.qkj.manage.domain;

import java.util.Date;
public class StoresOrder {
private int id;  //主键
private String user_id;//用户id
private String user_name;//用户名称
private Double total_price;//订单总价
private int fd_check=0;//订单状态
private String add_time;//添加时间
private Date lmtime;//修改时间
private String login_dept;
private String login_name;
private String member_id;
private String member_name;
private String member_mobile;
private Integer payment_type;//付款方式
private Integer is_arrears;//是否欠款
private Double arrears_price;//欠款金额
private String remark;//备注
private Integer is_ticket;
private String invoice_title;
private Double invoice_price;
private String invoice_id;
private Integer is_library;//是否出库 默认0
public Integer getIs_library() {
	return is_library;
}

public void setIs_library(Integer is_library) {
	this.is_library = is_library;
}

public String getLogin_name() {
	return login_name;
}

public void setLogin_name(String login_name) {
	this.login_name = login_name;
}
public Integer getIs_ticket() {
	return is_ticket;
}

public void setIs_ticket(Integer is_ticket) {
	this.is_ticket = is_ticket;
}

public String getInvoice_title() {
	return invoice_title;
}

public void setInvoice_title(String invoice_title) {
	this.invoice_title = invoice_title;
}

public Double getInvoice_price() {
	return invoice_price;
}

public void setInvoice_price(Double invoice_price) {
	this.invoice_price = invoice_price;
}

public String getInvoice_id() {
	return invoice_id;
}

public void setInvoice_id(String invoice_id) {
	this.invoice_id = invoice_id;
}


public Integer getPayment_type() {
	return payment_type;
}

public void setPayment_type(Integer payment_type) {
	this.payment_type = payment_type;
}

public Integer getIs_arrears() {
	return is_arrears;
}

public void setIs_arrears(Integer is_arrears) {
	this.is_arrears = is_arrears;
}

public Double getArrears_price() {
	return arrears_price;
}

public void setArrears_price(Double arrears_price) {
	this.arrears_price = arrears_price;
}

public String getRemark() {
	return remark;
}

public void setRemark(String remark) {
	this.remark = remark;
}

public String getMember_id() {
	return member_id;
}

public void setMember_id(String member_id) {
	this.member_id = member_id;
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

public String getLogin_dept() {
	return login_dept;
}

public void setLogin_dept(String login_dept) {
	this.login_dept = login_dept;
}

public Date getLmtime() {
	return lmtime;
}

public void setLmtime(Date lmtime) {
	this.lmtime = lmtime;
}

private String lm_user;//修改用户
public String getAdd_time() {
	return add_time;
}

public void setAdd_time(String add_time) {
	this.add_time = add_time;
}

public int getId() {
	return id;
}

public Double getTotal_price() {
	return total_price;
}
public int getFd_check() {
	return fd_check;
}

public String getLm_user() {
	return lm_user;
}
public void setId(int id) {
	this.id = id;
}
public void setTotal_price(Double total_price) {
	this.total_price = total_price;
}
public void setFd_check(int fd_check) {
	this.fd_check = fd_check;
}

public void setLm_user(String lm_user) {
	this.lm_user = lm_user;
}

public String getUser_id() {
	return user_id;
}

public String getUser_name() {
	return user_name;
}

public void setUser_id(String user_id) {
	this.user_id = user_id;
}

public void setUser_name(String user_name) {
	this.user_name = user_name;
}

}
